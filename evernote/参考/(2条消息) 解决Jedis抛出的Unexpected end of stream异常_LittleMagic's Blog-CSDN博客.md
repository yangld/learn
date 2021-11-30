
# 解决Jedis抛出的Unexpected end of stream异常

![[./_resources/(2条消息)_解决Jedis抛出的Unexpected_end_of_stream异常_LittleMagic's_Blog-CSDN博客.resources/original.png]]
[LittleMagics](https://me.csdn.net/nazeniwaresakini) 2020-03-10 21:54:43 ![[./_resources/(2条消息)_解决Jedis抛出的Unexpected_end_of_stream异常_LittleMagic's_Blog-CSDN博客.resources/articleReadEyes.png]] 1651  

		
分类专栏： [Redis](https://blog.csdn.net/nazeniwaresakini/category_9705495.html)

今晚断网，很久没修好，写篇超短的，然后趁早休息。

有一个Flink程序从Kafka读取数据，按1分钟滚动窗口汇总计算指标，并向Redis写入结果，即每1分钟写入一次。虽然Kafka Source输入的数据量巨大，但每分钟汇总的结果只有几百KB大。程序运行数小时之后，就会抛出如下的异常：

    1redis.clients.jedis.exceptions.JedisConnectionException: Unexpected end of stream.2        at redis.clients.util.RedisInputStream.ensureFill(RedisInputStream.java:199)3        at redis.clients.util.RedisInputStream.readByte(RedisInputStream.java:40)4        at redis.clients.jedis.Protocol.process(Protocol.java:151)5        at redis.clients.jedis.Protocol.read(Protocol.java:215)6// 以下略...

此后程序频繁重启，过最多5分钟就会重复抛出同样的异常，导致数据完全无法写入。采用的Redis是单机3.2.10版本，Jedis则是Bahir提供的Flink-Redis连接器中自带的2.9.0版本。

按照图中的异常栈追溯Jedis源码，并不能得到什么有用的信息。各种Google之后，找到3个排查的方向：

1.  客户端的输出缓冲区满了；
2.  Jedis实例被多线程并发操作；
3.  连接长时间闲置被服务器断开。

看一下缓冲区的设置：

    1> config get client-output-buffer-limit21) "client-output-buffer-limit"32) "normal 0 0 0 slave 268435456 67108864 60 pubsub 33554432 8388608 60"

根本没有限制。何况就算限制了，每分钟几百K的输出量也完全不是瓶颈。多线程的问题也不存在，因为一早就在代码中将RedisSink的并行度设为1了。所以只剩下第三种可能性了，看一下redis.conf里timeout的设置。

    1> config get timeout21) "timeout"32) "120"

120秒的时间还是相当短的。再来看一下我们在使用连接器时构造的FlinkJedisPoolConfig实例在哪里用到了，答案是RedisCommandsContainerBuilder：

    1    public static RedisCommandsContainer build(FlinkJedisPoolConfig jedisPoolConfig) {2        Objects.requireNonNull(jedisPoolConfig, "Redis pool config should not be Null");3 4        GenericObjectPoolConfig genericObjectPoolConfig = new GenericObjectPoolConfig();5        genericObjectPoolConfig.setMaxIdle(jedisPoolConfig.getMaxIdle());6        genericObjectPoolConfig.setMaxTotal(jedisPoolConfig.getMaxTotal());7        genericObjectPoolConfig.setMinIdle(jedisPoolConfig.getMinIdle());8 9        JedisPool jedisPool = new JedisPool(genericObjectPoolConfig, jedisPoolConfig.getHost(),10            jedisPoolConfig.getPort(), jedisPoolConfig.getConnectionTimeout(), jedisPoolConfig.getPassword(),11            jedisPoolConfig.getDatabase());12        return new RedisContainer(jedisPool);13    }

可见这个JedisPool**根本没有监测idle连接**。由于并发很低，随着程序运行，JedisPool中的所有连接都会逐渐变为idle连接，并且不会被清理掉，异常就产生了。所以一定要先吐槽一下这个Redis连接器。

![[./_resources/(2条消息)_解决Jedis抛出的Unexpected_end_of_stream异常_LittleMagic's_Blog-CSDN博客.resources/195230-82eaa8011ac4ffe5.png]]

吐槽完了还是得改。修改思路有三：

1.  把maxIdle设为0。过于简单粗暴了，治标不治本，不考虑。
    
2.  在FlinkJedisPoolConfig类的代码中直接加上testOnBorrow和testOnReturn的配置项，也就是从JedisPool获取和归还连接时，都检测一下连接的有效性，失效的连接会被清理掉。虽然会多出两次ping的开销，但是每分钟才写一批次数据的话，显然没有瓶颈。
    
3.  把上面代码中用到的GenericObjectPoolConfig替换成JedisPoolConfig。JedisPoolConfig的代码很简单：
    

    1public class JedisPoolConfig extends GenericObjectPoolConfig {2  public JedisPoolConfig() {3    // defaults to make your life with connection pool easier :)4    setTestWhileIdle(true);5    setMinEvictableIdleTimeMillis(60000);6    setTimeBetweenEvictionRunsMillis(30000);7    setNumTestsPerEvictionRun(-1);8  }9}

虽然简单，但它默认设定的四个参数确实“make our life easier”了：

*   testWhileIdle：开启空闲连接检测；
*   minEvictableIdleTimeMillis：JedisPool中连接的空闲时间阈值，当达到这个阈值时，空闲连接就会被移除。Redis的默认值是30分钟，太长，所以JedisPoolConfig的默认值是1分钟；
*   timeBetweenEvictionRunsMillis：检测空闲连接的周期，上面是30秒；
*   numTestsPerEvictionRun：每次检测时，取多少个连接进行检测。如果设置成-1，就表示检测所有链接。

当然我们还可以在FlinkJedisPoolConfig使用的GenericObjectPoolConfig中加上空闲连接检测的参数，但这样还不如直接用JedisPoolConfig来的方便。这种方法更具有普适性，因为testOnBorrow和testOnReturn带来的开销在大并发时还是很可观的。

民那晚安晚安。

    Created at: 2020-10-28T14:25:35+08:00
    Updated at: 2020-10-28T14:25:35+08:00


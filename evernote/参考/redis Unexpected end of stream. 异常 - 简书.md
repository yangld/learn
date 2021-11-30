
# redis Unexpected end of stream. 异常

[![[./_resources/redis_Unexpected_end_of_stream._异常_-_简书.resources/webp.3.webp]]](https://www.jianshu.com/u/cdb830d96bb3)

[超神气的二月飞](https://www.jianshu.com/u/cdb830d96bb3)
2017.10.12 19:56:46字数 971阅读 21,607

近期生产环境碰到不少redis的异常，有获取不到连接的，有返回资源出错，还有就是Unexpected end of stream. 这个异常。各种百度google之后发现造成这种问题的原因大致如下

1.输出缓冲区满。例如将普通客户端的输出缓冲区设置为1M 1M 60：

config set client-output-buffer-limit "normal 1048576 1048576 60 slave 268435456 67108864 60 pubsub 33554432 8388608 60"

如果使用get命令获取一个bigkey(例如3M)，就会出现这个异常。(我们的是0无限制)

2.长时间闲置连接被服务端主动断开，可以查询timeout配置的设置以及自身连接池配置是否需要做空闲检测。

3.不正常并发读写：Jedis对象同时被多个线程并发操作，可能会出现上述异常。（每个线程一个jedis对象）

但通过观察我们的设置和代码1和3 是可以排除的，因此怀疑是2，是什么原因造成的2呢。经过一番查找，初步怀疑是服务器端的timeout和客户端的timeout(minEvictableIdleTimeMillis) 不是很一致出现的这个问题。经过搜索，minEvictableIdleTimeMillis这个值客户端默认是30分钟，而查看了下我们redis服务器的timeout为600s初步怀疑是这个原因造成。查询语句为config get timeout。但开发人员无法搞生产环境啊，就只能自己回来验证了。

代码如下，分了两部分，一部分是集群的，一部分是jedispool的，其实最终都是jedispool了。

private static void clusterTest() throws InterruptedException {Setsets = new HashSet<>();

HostAndPort hostAndPort = new HostAndPort("", 5000);

HostAndPort hostAndPort1 = new HostAndPort("", 5001);

HostAndPort hostAndPort2 = new HostAndPort("", 5002);

HostAndPort hostAndPort3 = new HostAndPort("", 5003);

HostAndPort hostAndPort4 = new HostAndPort("", 5004);

HostAndPort hostAndPort5 = new HostAndPort("", 5005);

sets.add(hostAndPort);

sets.add(hostAndPort1);

sets.add(hostAndPort2);

sets.add(hostAndPort3);

sets.add(hostAndPort4);

sets.add(hostAndPort5);

JedisPoolConfig config = new JedisPoolConfig();

config.setMaxTotal(100);

config.setTestOnBorrow(false);

config.setMaxWaitMillis(2000);

final JedisCluster jedisCluster = new JedisCluster(sets, 2000, 1, config);//注意这里第三个参数是1，本地没有模拟高并发的情况下，重试的时候会获取一个新建的connect，就不会发生异常了

System.out.println(jedisCluster.get("5"));

java.lang.Thread.sleep(12000);

System.out.println(jedisCluster.get("5"));

}

public static void jedisTest() throws InterruptedException {

JedisPoolConfig config = new JedisPoolConfig();

config.setMaxTotal(100);

config.setTestOnBorrow(false);

config.setMaxWaitMillis(2000);

JedisPool jedisPool = new JedisPool(config, "", 5001);

Jedis jedis = jedisPool.getResource();

System.out.println(jedis.get("5"));

jedis.close();

java.lang.Thread.sleep(12000);

System.out.println(jedisPool.getResource().get("5"));

}

在执行一次redis查询之后线程休息了12s，redis 服务器我设置的timeout是10s

![[./_resources/redis_Unexpected_end_of_stream._异常_-_简书.resources/webp.2.webp]]

main方法跑起来，果然在第二个命令的时候报错

Exception in thread "main" redis.clients.jedis.exceptions.JedisConnectionException: Unexpected end of stream.

at redis.clients.util.RedisInputStream.ensureFill(RedisInputStream.java:199)

at redis.clients.util.RedisInputStream.readByte(RedisInputStream.java:40)

at redis.clients.jedis.Protocol.process(Protocol.java:151)

at redis.clients.jedis.Protocol.read(Protocol.java:215)

at redis.clients.jedis.Connection.readProtocolWithCheckingBroken(Connection.java:340)

at redis.clients.jedis.Connection.getBinaryBulkReply(Connection.java:259)

at redis.clients.jedis.Connection.getBulkReply(Connection.java:248)

at redis.clients.jedis.Jedis.get(Jedis.java:153)

at redis.clients.jedis.JedisCluster$3.execute(JedisCluster.java:122)

at redis.clients.jedis.JedisCluster$3.execute(JedisCluster.java:119)

at redis.clients.jedis.JedisClusterCommand.runWithRetries(JedisClusterCommand.java:120)

at redis.clients.jedis.JedisClusterCommand.run(JedisClusterCommand.java:31)

at redis.clients.jedis.JedisCluster.get(JedisCluster.java:124)

将线程的sleep时间改为8s使之小于10s之后，错误消失。

通过查看jedis集群 的源码

![[./_resources/redis_Unexpected_end_of_stream._异常_-_简书.resources/webp.1.webp]]

发现这样出错之后会重新设置缓存。此处怀疑会造成Could not return the resource to the pool(仅仅是怀疑)。

最终线上的问题是否由于这个原因造成不得而知，没有去验证。但至少已经证实timeout设置不合理服务端单方关闭连接是造成此异常 的一个原因，也算是学习了。

_![[./_resources/redis_Unexpected_end_of_stream._异常_-_简书.resources/embedded.svg]]_
1人点赞_![[./_resources/redis_Unexpected_end_of_stream._异常_-_简书.resources/embedded.1.svg]]_

_![[./_resources/redis_Unexpected_end_of_stream._异常_-_简书.resources/embedded.2.svg]]_

[_![[./_resources/redis_Unexpected_end_of_stream._异常_-_简书.resources/embedded.3.svg]]_随笔](https://www.jianshu.com/nb/16667789)

_![[./_resources/redis_Unexpected_end_of_stream._异常_-_简书.resources/embedded.4.svg]]_

"小礼物走一走，来简书关注我"
共2人赞赏

[![[./_resources/redis_Unexpected_end_of_stream._异常_-_简书.resources/webp.webp]]](https://www.jianshu.com/u/cdb830d96bb3)

[超神气的二月飞](https://www.jianshu.com/u/cdb830d96bb3)有追求的码农一枚
总资产1 (约0.07元)共写了2606字获得3个赞共1个粉丝

    Created at: 2020-10-28T14:38:21+08:00
    Updated at: 2020-10-28T14:38:21+08:00



# 记一次Jedis连接池泄漏的分析

[![[8知识管理/InBox/evernote/参考/_resources/记一次Jedis连接池泄漏的分析_-_简书.resources/webp.1.webp]]](https://www.jianshu.com/u/cc3b7b3d3fb0)

[Ever\_00](https://www.jianshu.com/u/cc3b7b3d3fb0)
_![[./_resources/记一次Jedis连接池泄漏的分析_-_简书.resources/embedded.svg]]_22019.05.29 21:49:19字数 3,001阅读 3,248

## 1\. 背景

随着业务的快速发展，公司使用redis cluster+本地缓存的模式来化解大流量下对系统的冲击。
redis客户端驱动采用的是市面上流行的jedis，版本为2.6.2.

jedis采用连接池的方式来满足多线程对redis的访问需要。
在高并发以及大服务集群的环境下，jedis有各种弊端：

1.  连接池的模式采用了传统bio的通信模式，资源利用效率低下，完全没有发挥nio无阻塞双工通信的优势
2.  连接池的模式，服务节点数目上去之后(尤其是大促期间扩容)，很可能超过redis的连接数限制
3.  jedis让人莫名其妙的异常信息，让人很难定位到问题所在
4.  不支持mget，mset以及pipeline等指令，但又支持了很多对业务没太大用处的管理指令。
5.  在特定场景下会发生连接泄漏的问题，需要重启业务服务才能恢复。

所以，目前架构组在研发一个基于nio的redis驱动，以取代jedis。

## 2\. 故障描述

jedis的问题困扰了我们好久，尤其是连接泄漏的问题，直接影响到业务。

在研究了业务异常日志后，发现有2个问题:

### 2.1 jedis连接池耗尽，且一直无法恢复

理论上，在服务启动后的瞬间， 大量请求涌进来， 而这时候连接池还没有准备好连接， 这时候是可能存在短时间的连接耗尽，从而导致服务拿不到连接的情况的。
但这种情况应该在几秒内恢复正常。

如果一直都拿不到连接，那么毫无疑问，发生了连接池泄漏。
这时候，日志上会大量打印:
`Pool exhausted`
或者:
`Timeout waiting for idle object` (如果配置了`blockWhenExhausted`的话)

使用Jmx工具或者arthas去查看连接池的状态，发现就算没有请求过来了， 其NumActive值依然保持在一个比较高的水平(如果没请求过来的话，理论上大部分时间这个值都是0，除了恰好碰到jedis为维持连接而发送心跳包外)。
更加印证了连接池泄漏真的发生了。

## 2.2 redis返回莫名其妙的MOVE指令

redis.clients.jedis.exceptions.JedisMovedDataException: MOVED 12790 172.30.221.82:14161

查了redis的手册，MOVED只有redis在发生槽迁移的时候，才有可能返回MOVED。 但发生异常的时候，我们并没有做任何槽的迁移操作。

看了jedis的源码，发现其逻辑为:

1.  根据key拿到对应redis节点的连接a(每个key可以算出落在哪个槽上, 从而算出具体的redis节点,这里假设是redisA)
2.  用连接a发送指令，例如 get aaa
3.  如果发生异常，例如拿不到连接、连接超时、读超时等，会进入重试阶段(重试次数通过jedis参数配置), 随机再拿一条连接b(对应redisB)，去发送同样的指令
4.  大部分情况下，redisB会返回MOVED xxx redisA (xxx为aaa所在的槽号，告知客户端aaa所在的槽xxx位于redisA中)

这个就是MOVED异常的由来了。
正常来说，经过MOVED后，后续jedis能再次拿到redisA的连接，从而得到正确的结果。

诡异的是， `有时候key明明在redisA上，但是redis却告诉你它在redisB上`.
也就是说， 用连接a发了一个指令get aaa， 结果redis返回MOVED xxx redisB

这就非常不可理解了。

## 3\. 抓虫经历

我们试图把造成连接泄漏的线程揪出来，于是修改了jedis的代码，

1.  当某个线程申请到一个连接的时候，把线程的堆栈、连接信息以及申请时间记录下来，并记录到集合a中。
2.  当线程归还连接的时候，把线程信息从集合a中去除。

通过一个timer， 每隔5秒检查一下，当集合a中存在申请时间超过30秒的连接时， 就认为发生了泄漏，并把泄漏的连接对应的线程堆栈打出来。

然后，在测试同事的鼎力帮忙下，把改造过的jedis放到压测环境，启动tsung，开始了痛苦的抓虫过程。

### 3.1 问题重现

开始并发量从2k增加到2w，每轮持续5分钟， 第一天、第二天都没重现。
然后心一横， 把接入层、服务分别扩大到30台、40台，qps增大到20w， 还是很难重现问题。
恰好到周末了， 把压测时间放宽到10小时。 结果第二天早上一看，果然发生了连接池泄漏。

> 现在回首，重现的前提是请求并发高、redis压力大且压测的持续时间需要有一定的保证，毕竟要重现的话，概率比较小。

看打印出来的线程堆栈，都是很正常的路径，获取连接一般都是在第一次访问redis发生了读超时或者获取连接超后，重试的时候拿到的。

那我们聚焦重试的时候拿连接的逻辑:

    public Jedis getConnection() {
      // In antirez's redis-rb-cluster implementation,
      // getRandomConnection always return valid connection (able to
      // ping-pong)
      // or exception if all connections are invalid
    
      List<JedisPool> pools = getShuffledNodesPool();
    
      for (JedisPool pool : pools) {
        Jedis jedis = null;
        try {
          jedis = pool.getResource();
    
          if (jedis == null) {
            continue;
          }
    
          String result = jedis.ping();
    
          if (result.equalsIgnoreCase("pong")) return jedis;
    
          pool.returnBrokenResource(jedis);
        } catch (JedisConnectionException ex) {
          if (jedis != null) {
            pool.returnBrokenResource(jedis);
          }
        }
      }
    
      throw new JedisConnectionException("no reachable node in cluster");
    }
    12345678910111213141516171819202122232425262728293031

我们发现，这里jedis只处理了连接异常并释放了连接。 有没有可能存在其它异常，导致连接没有归还呢？
于是我们在这里加了一个catch块，捕获所有的异常(Throwable).

### 3.2 柳暗花明

重新打包再出发， 又压了一晚， 第二天，果不其然，有个空指针在这一行报了出来:

    String result = jedis.ping();
    1

`这个空指针会导致连接没有归还!`

仔细看了代码，各种路径都不可能返回null。

一下子又没了头绪。

这时候，@飞狐 又展现出了老司机风范， 建议通过tcpdump抓包，配合日志一起分析。

tcpdump抓包，这个镇宅神奇，是最后一招了。

### 3.3 镇宅神器 - tcpdump

又过了一晚，问题重现了， 并抓了服务节点跟redis之间的tcp通讯包。

#### 3.3.1. 日志

日志1:

    [2019-05-26 09:16:26:510]Jedis-Debugger:Thread:[Thread[DubboServerHandler-172.30.2.206:29955-thread-1629,5,main]], currentTs:1558833386510, detail:redirection:4, key:short_url_pre.qGZmAb, slot:137 java.net.SocketTimeoutException: Read timed out
    [2019-05-26 09:16:26:510]Jedis-Debugger:Thread:[Thread[DubboServerHandler-172.30.2.206:29955-thread-1629,5,main]], currentTs:1558833386510, detail:redis.clients.jedis.exceptions.JedisConnectionException: java.net.SocketTimeoutException: Read timed out
            redis.clients.util.RedisInputStream.ensureFill(RedisInputStream.java:201)
            redis.clients.util.RedisInputStream.readByte(RedisInputStream.java:40)
            redis.clients.jedis.Protocol.process(Protocol.java:128)
            redis.clients.jedis.Protocol.read(Protocol.java:192)
            redis.clients.jedis.Connection.readProtocolWithCheckingBroken(Connection.java:287)
            redis.clients.jedis.Connection.getBinaryBulkReply(Connection.java:206)
            redis.clients.jedis.Connection.getBulkReply(Connection.java:195)
            redis.clients.jedis.Jedis.get$original$c4ny46N9(Jedis.java:93)
            redis.clients.jedis.Jedis.get$original$c4ny46N9$accessor$54NXOkqL(Jedis.java)
            redis.clients.jedis.Jedis$auxiliary$lC2USXlw.call(Unknown Source)
            com.yunji.erlang.agent.plugin.interceptor.enhance.InstMethodsInter.intercept(InstMethodsInter.java:87)
            redis.clients.jedis.Jedis.get(Jedis.java)
            yunji.stock.StockJedisCluster$3.execute(StockJedisCluster.java:358)
            yunji.stock.StockJedisCluster$3.execute(StockJedisCluster.java:355)
            redis.clients.jedis.JedisClusterCommand.runWithRetries(JedisClusterCommand.java:62)
            redis.clients.jedis.JedisClusterCommand.run(JedisClusterCommand.java:35)
            yunji.stock.StockJedisCluster.get(StockJedisCluster.java:360)
            com.yunji.shorturl.service.provider.base.ShortUrlBaseService.getByJedis(ShortUrlBaseService.java:140)
            com.yunji.shorturl.service.provider.base.ShortUrlBaseService.getSourceByJedis(ShortUrlBaseService.java:68)
            com.yunji.shorturl.service.provider.ShortUrlWriteServiceImpl.genShortUrl(ShortUrlWriteServiceImpl.java:538)
            com.yunji.shorturl.service.provider.ShortUrlWriteServiceImpl.createShortUrlAddRealmName(ShortUrlWriteServiceImpl.java:145)
            com.alibaba.dubbo.common.bytecode.Wrapper7.invokeMethod(Wrapper7.java)
            com.alibaba.dubbo.rpc.proxy.javassist.JavassistProxyFactory$1.doInvoke(JavassistProxyFactory.java:46)
    [2019-05-26 09:16:26:510]Jedis-Debugger:Thread:[Thread[DubboServerHandler-172.30.2.206:29955-thread-1629,5,main]], currentTs:1558833386510, detail:host:172.30.232.59, port:14159
    
    
    ....
    [2019-05-26 09:16:26:801]Jedis-Debugger:Thread:[Thread[DubboServerHandler-172.30.2.206:29955-thread-1629,5,main]], currentTs:1558833386801, detail:PossibleJedisLeak :null
    [2019-05-26 09:16:26:801]Jedis-Debugger:Thread:[Thread[DubboServerHandler-172.30.2.206:29955-thread-1629,5,main]], currentTs:1558833386801, detail:java.lang.NullPointerException
            redis.clients.jedis.JedisSlotBasedConnectionHandler.getConnection(JedisSlotBasedConnectionHandler.java:36)
            redis.clients.jedis.JedisClusterCommand.runWithRetries(JedisClusterCommand.java:56)
            redis.clients.jedis.JedisClusterCommand.runWithRetries(JedisClusterCommand.java:87)
            redis.clients.jedis.JedisClusterCommand.run(JedisClusterCommand.java:35)
            yunji.stock.StockJedisCluster.get(StockJedisCluster.java:360)
            com.yunji.shorturl.service.provider.base.ShortUrlBaseService.getByJedis(ShortUrlBaseService.java:140)
            com.yunji.shorturl.service.provider.base.ShortUrlBaseService.getSourceByJedis(ShortUrlBaseService.java:68)
            com.yunji.shorturl.service.provider.ShortUrlWriteServiceImpl.genShortUrl(ShortUrlWriteServiceImpl.java:538)
            com.yunji.shorturl.service.provider.ShortUrlWriteServiceImpl.createShortUrlAddRealmName(ShortUrlWriteServiceImpl.java:145)
    12345678910111213141516171819202122232425262728293031323334353637383940

服务向redis发get请求后，读超时，然后随机选择了一个节点再次创建了一个连接，在返回连接前做了一个连接校验的动作

1.  发`PING`请求给redis
2.  预期redis返回`PONG`, 结果拿到的结果是null，
3.  空指针从而导致连接泄漏

    try {
      jedis = pool.getResource();
    
      if (jedis == null) {
        continue;
      }
    
      String result = jedis.ping();
    
      if (result.equalsIgnoreCase("pong")) return jedis;  //Line 36
    
      pool.returnBrokenResource(jedis);
    } catch (JedisConnectionException ex) {
      if (jedis != null) {
        pool.returnBrokenResource(jedis);
      }
    } catch (Throwable ex) {
      // TODO
      if (jedis != null) { // localPort, remoteIp,port
        Debugger.log("PossibleJedisLeak :" + ex.getMessage(), ex);
      }
    }
    12345678910111213141516171819202122

注意这个时间点是`09:16:26:801`

接着，连接泄漏检测线程检测到有连接泄漏了，打印出如下日志:

    [2019-05-26 09:16:59:354]Jedis-Debugger-simpleLog:!! PossibleJedisLeak: Jedis-Debugger-Error:ConnInfo[172.30.232.59:14159] borrowed by Thread[DubboServerHandler-172.30.2.206:29955-thread-1629,5,main] at:1558833386765
    java.lang.RuntimeException: connDebugger
            redis.clients.util.Debugger.addConn(Debugger.java:28)
            redis.clients.jedis.JedisPool.getResource(JedisPool.java:95)
            redis.clients.jedis.JedisSlotBasedConnectionHandler.getConnection(JedisSlotBasedConnectionHandler.java:28)
            redis.clients.jedis.JedisClusterCommand.runWithRetries(JedisClusterCommand.java:56)
            redis.clients.jedis.JedisClusterCommand.runWithRetries(JedisClusterCommand.java:87)
            redis.clients.jedis.JedisClusterCommand.run(JedisClusterCommand.java:35)
            yunji.stock.StockJedisCluster.get(StockJedisCluster.java:360)
            com.yunji.shorturl.service.provider.base.ShortUrlBaseService.getByJedis(ShortUrlBaseService.java:140)
            com.yunji.shorturl.service.provider.base.ShortUrlBaseService.getSourceByJedis(ShortUrlBaseService.java:68)
            com.yunji.shorturl.service.provider.ShortUrlWriteServiceImpl.genShortUrl(ShortUrlWriteServiceImpl.java:538)
            com.yunji.shorturl.service.provider.ShortUrlWriteServiceImpl.createShortUrlAddRealmName(ShortUrlWriteServiceImpl.java:145)
    12345678910111213

注意这条连接是在`1558833386765`生成的， 也就是`2019-05-26 09:16:26 765`

#### 3.3.2. tcpdump日志

我们关注下相关时间段内的tcp数据包:

    ##get
    2019-05-26 09:16:24.508718 IP (tos 0x0, ttl 64, id 41654, offset 0, flags [DF], proto TCP (6), length 92)
        172.30.2.206.40970 > 172.30.232.59.14159: Flags [P.], cksum 0x4395 (incorrect -> 0x0db1), seq 1:41, ack 1, win 229, options [nop,nop,TS val 400338731 ecr 3351988106], length 40
            0x0000:  4500 005c a2b6 4000 4006 549f ac1e 02ce  E..\..@.@.T.....
            0x0010:  ac1e e83b a00a 374f b932 0da0 84f0 b53d  ...;..7O.2.....=
            0x0020:  8018 00e5 4395 0000 0101 080a 17dc af2b  ....C..........+
            0x0030:  c7cb 478a 2a32 0d0a 2433 0d0a 4745 540d  ..G.*2..$3..GET.
            0x0040:  0a24 3230 0d0a 7368 6f72 745f 7572 6c5f  .$20..short_url_
            0x0050:  7072 652e 7147 5a6d 4162 0d0a            pre.qGZmAb..
    2019-05-26 09:16:24.508825 IP (tos 0x0, ttl 64, id 62135, offset 0, flags [DF], proto TCP (6), length 52)
        172.30.232.59.14159 > 172.30.2.206.40970: Flags [.], cksum 0x83b3 (correct), seq 1, ack 41, win 227, options [nop,nop,TS val 3351988106 ecr 400338731], length 0
            0x0000:  4500 0034 f2b7 4000 4006 04c6 ac1e e83b  E..4..@.@......;
            0x0010:  ac1e 02ce 374f a00a 84f0 b53d b932 0dc8  ....7O.....=.2..
            0x0020:  8010 00e3 83b3 0000 0101 080a c7cb 478a  ..............G.
            0x0030:  17dc af2b
    ##2秒后超时， 产生read timeout异常， 并关闭连接。
    2019-05-26 09:16:26.510990 IP (tos 0x0, ttl 64, id 41655, offset 0, flags [DF], proto TCP (6), length 66)
        172.30.2.206.40970 > 172.30.232.59.14159: Flags [P.], cksum 0x437b (incorrect -> 0x6b9c), seq 41:55, ack 1, win 229, options [nop,nop,TS val 400340733 ecr 3351988106], length 14
            0x0000:  4500 0042 a2b7 4000 4006 54b8 ac1e 02ce  E..B..@.@.T.....
            0x0010:  ac1e e83b a00a 374f b932 0dc8 84f0 b53d  ...;..7O.2.....=
            0x0020:  8018 00e5 437b 0000 0101 080a 17dc b6fd  ....C{..........
            0x0030:  c7cb 478a 2a31 0d0a 2434 0d0a 5155 4954  ..G.*1..$4..QUIT
            0x0040:  0d0a                                     ..
    2019-05-26 09:16:26.511082 IP (tos 0x0, ttl 64, id 62136, offset 0, flags [DF], proto TCP (6), length 52)
        172.30.232.59.14159 > 172.30.2.206.40970: Flags [.], cksum 0x7401 (correct), seq 1, ack 55, win 227, options [nop,nop,TS val 3351990108 ecr 400340733], length 0
            0x0000:  4500 0034 f2b8 4000 4006 04c5 ac1e e83b  E..4..@.@......;
            0x0010:  ac1e 02ce 374f a00a 84f0 b53d b932 0dd6  ....7O.....=.2..
            0x0020:  8010 00e3 7401 0000 0101 080a c7cb 4f5c  ....t.........O\
            0x0030:  17dc b6fd
    2019-05-26 09:16:26.761088 IP (tos 0x0, ttl 64, id 62137, offset 0, flags [DF], proto TCP (6), length 62)
        172.30.232.59.14159 > 172.30.2.206.40970: Flags [P.], cksum 0xb73a (correct), seq 1:11, ack 55, win 227, options [nop,nop,TS val 3351990358 ecr 400340733], length 10
            0x0000:  4500 003e f2b9 4000 4006 04ba ac1e e83b  E..>..@.@......;
            0x0010:  ac1e 02ce 374f a00a 84f0 b53d b932 0dd6  ....7O.....=.2..
            0x0020:  8018 00e3 b73a 0000 0101 080a c7cb 5056  .....:........PV
            0x0030:  17dc b6fd 242d 310d 0a2b 4f4b 0d0a       ....$-1..+OK..
    2019-05-26 09:16:26.761107 IP (tos 0x0, ttl 64, id 41656, offset 0, flags [DF], proto TCP (6), length 52)
        172.30.2.206.40970 > 172.30.232.59.14159: Flags [.], cksum 0x436d (incorrect -> 0x7201), seq 55, ack 11, win 229, options [nop,nop,TS val 400340983 ecr 3351990358], length 0
            0x0000:  4500 0034 a2b8 4000 4006 54c5 ac1e 02ce  E..4..@.@.T.....
            0x0010:  ac1e e83b a00a 374f b932 0dd6 84f0 b547  ...;..7O.2.....G
            0x0020:  8010 00e5 436d 0000 0101 080a 17dc b7f7  ....Cm..........
            0x0030:  c7cb 5056                                ..PV
    2019-05-26 09:16:26.761094 IP (tos 0x0, ttl 64, id 62138, offset 0, flags [DF], proto TCP (6), length 52)
        172.30.232.59.14159 > 172.30.2.206.40970: Flags [F.], cksum 0x72fc (correct), seq 11, ack 55, win 227, options [nop,nop,TS val 3351990358 ecr 400340733], length 0
            0x0000:  4500 0034 f2ba 4000 4006 04c3 ac1e e83b  E..4..@.@......;
            0x0010:  ac1e 02ce 374f a00a 84f0 b547 b932 0dd6  ....7O.....G.2..
            0x0020:  8011 00e3 72fc 0000 0101 080a c7cb 5056  ....r.........PV
            0x0030:  17dc b6fd                                ....
    2019-05-26 09:16:26.761124 IP (tos 0x0, ttl 64, id 41657, offset 0, flags [DF], proto TCP (6), length 52)
        172.30.2.206.40970 > 172.30.232.59.14159: Flags [R.], cksum 0x436d (incorrect -> 0x41d0), seq 55, ack 12, win 229, options [nop,nop,TS val 0 ecr 3351990358], length 0
            0x0000:  4500 0034 a2b9 4000 4006 54c4 ac1e 02ce  E..4..@.@.T.....
            0x0010:  ac1e e83b a00a 374f b932 0dd6 84f0 b548  ...;..7O.2.....H
            0x0020:  8014 00e5 436d 0000 0101 080a 0000 0000  ....Cm..........
            0x0030:  c7cb 5056                                ..PV
    
    
    ##########################################
    ##get
    2019-05-26 09:16:26.760545 IP (tos 0x0, ttl 64, id 16696, offset 0, flags [DF], proto TCP (6), length 92)
        172.30.2.206.58294 > 172.30.232.59.14159: Flags [P.], cksum 0x4395 (incorrect -> 0xc855), seq 152287:152327, ack 12032, win 229, options [nop,nop,TS val 400340983 ecr 3351990354], length 40
            0x0000:  4500 005c 4138 4000 4006 b61d ac1e 02ce  E..\A8@.@.......
            0x0010:  ac1e e83b e3b6 374f 67d5 5b16 7bd8 9365  ...;..7Og.[.{..e
            0x0020:  8018 00e5 4395 0000 0101 080a 17dc b7f7  ....C...........
            0x0030:  c7cb 5052 2a32 0d0a 2433 0d0a 4745 540d  ..PR*2..$3..GET.
            0x0040:  0a24 3230 0d0a 7368 6f72 745f 7572 6c5f  .$20..short_url_
            0x0050:  7072 652e 5056 6164 7a4e 0d0a            pre.PVadzN..
    
    
    ## ack
    2019-05-26 09:16:26.760631 IP (tos 0x0, ttl 64, id 48437, offset 0, flags [DF], proto TCP (6), length 52)
        172.30.232.59.14159 > 172.30.2.206.58294: Flags [.], cksum 0x5d46 (correct), seq 12032, ack 152327, win 227, options [nop,nop,TS val 3351990358 ecr 400340983], length 0
            0x0000:  4500 0034 bd35 4000 4006 3a48 ac1e e83b  E..4.5@.@.:H...;
            0x0010:  ac1e 02ce 374f e3b6 7bd8 9365 67d5 5b3e  ....7O..{..eg.[>
            0x0020:  8010 00e3 5d46 0000 0101 080a c7cb 5056  ....]F........PV
            0x0030:  17dc b7f7
    
    
    ## PING??
    2019-05-26 09:16:26.765741 IP (tos 0x0, ttl 64, id 16697, offset 0, flags [DF], proto TCP (6), length 66)
        172.30.2.206.58294 > 172.30.232.59.14159: Flags [P.], cksum 0x437b (incorrect -> 0x4915), seq 152327:152341, ack 12032, win 229, options [nop,nop,TS val 400340988 ecr 3351990358], length 14
            0x0000:  4500 0042 4139 4000 4006 b636 ac1e 02ce  E..BA9@.@..6....
            0x0010:  ac1e e83b e3b6 374f 67d5 5b3e 7bd8 9365  ...;..7Og.[>{..e
            0x0020:  8018 00e5 437b 0000 0101 080a 17dc b7fc  ....C{..........
            0x0030:  c7cb 5056 2a31 0d0a 2434 0d0a 5049 4e47  ..PV*1..$4..PING
            0x0040:  0d0a
    
    
    ## ack
    2019-05-26 09:16:26.765828 IP (tos 0x0, ttl 64, id 48438, offset 0, flags [DF], proto TCP (6), length 52)
        172.30.232.59.14159 > 172.30.2.206.58294: Flags [.], cksum 0x5d2e (correct), seq 12032, ack 152341, win 227, options [nop,nop,TS val 3351990363 ecr 400340988], length 0
            0x0000:  4500 0034 bd36 4000 4006 3a47 ac1e e83b  E..4.6@.@.:G...;
            0x0010:  ac1e 02ce 374f e3b6 7bd8 9365 67d5 5b4c  ....7O..{..eg.[L
            0x0020:  8010 00e3 5d2e 0000 0101 080a c7cb 505b  ....].........P[
            0x0030:  17dc b7fc
    
    
    ## 两个响应，一个是对上面get的响应 $-1, 另一个是PING的响应PONG
    2019-05-26 09:16:26.801028 IP (tos 0x0, ttl 64, id 48439, offset 0, flags [DF], proto TCP (6), length 64)
        172.30.232.59.14159 > 172.30.2.206.58294: Flags [P.], cksum 0x51f1 (correct), seq 12032:12044, ack 152341, win 227, options [nop,nop,TS val 3351990398 ecr 400340988], length 12
            0x0000:  4500 0040 bd37 4000 4006 3a3a ac1e e83b  E..@.7@.@.::...;
            0x0010:  ac1e 02ce 374f e3b6 7bd8 9365 67d5 5b4c  ....7O..{..eg.[L
            0x0020:  8018 00e3 51f1 0000 0101 080a c7cb 507e  ....Q.........P~
            0x0030:  17dc b7fc 242d 310d 0a2b 504f 4e47 0d0a  ....$-1..+PONG..
    
    
    
    
    2019-05-26 09:17:06.867043 IP (tos 0x0, ttl 64, id 48440, offset 0, flags [DF], proto TCP (6), length 52)
        172.30.232.59.14159 > 172.30.2.206.58294: Flags [.], cksum 0xc032 (correct), seq 12043, ack 152341, win 227, options [nop,nop,TS val 3352030464 ecr 400341063], length 0
            0x0000:  4500 0034 bd38 4000 4006 3a45 ac1e e83b  E..4.8@.@.:E...;
            0x0010:  ac1e 02ce 374f e3b6 7bd8 9370 67d5 5b4c  ....7O..{..pg.[L
            0x0020:  8010 00e3 c032 0000 0101 080a c7cb ed00  .....2..........
            0x0030:  17dc b847                                ...G
    2019-05-26 09:17:06.867053 IP (tos 0x0, ttl 64, id 16699, offset 0, flags [DF], proto TCP (6), length 52)
        172.30.2.206.58294 > 172.30.232.59.14159: Flags [.], cksum 0x436d (incorrect -> 0xc057), seq 152341, ack 12044, win 229, options [nop,nop,TS val 400381089 ecr 3351990398], length 0
            0x0000:  4500 0034 413b 4000 4006 b642 ac1e 02ce  E..4A;@.@..B....
            0x0010:  ac1e e83b e3b6 374f 67d5 5b4c 7bd8 9371  ...;..7Og.[L{..q
            0x0020:  8010 00e5 436d 0000 0101 080a 17dd 54a1  ....Cm........T.
            0x0030:  c7cb 507e                                ..P~
    
    
    ## FIN
    2019-05-26 09:17:27.574951 IP (tos 0x0, ttl 64, id 48441, offset 0, flags [DF], proto TCP (6), length 52)
        172.30.232.59.14159 > 172.30.2.206.58294: Flags [F.], cksum 0xd2f2 (correct), seq 12044, ack 152341, win 227, options [nop,nop,TS val 3352051171 ecr 400381089], length 0
            0x0000:  4500 0034 bd39 4000 4006 3a44 ac1e e83b  E..4.9@.@.:D...;
            0x0010:  ac1e 02ce 374f e3b6 7bd8 9371 67d5 5b4c  ....7O..{..qg.[L
            0x0020:  8011 00e3 d2f2 0000 0101 080a c7cc 3de3  ..............=.
            0x0030:  17dd 54a1                                ..T.
    
    
    ## ACK
    2019-05-26 09:17:27.614148 IP (tos 0x0, ttl 64, id 16700, offset 0, flags [DF], proto TCP (6), length 52)
        172.30.2.206.58294 > 172.30.232.59.14159: Flags [.], cksum 0x436d (incorrect -> 0x81e4), seq 152341, ack 12045, win 229, options [nop,nop,TS val 400401837 ecr 3352051171], length 0
            0x0000:  4500 0034 413c 4000 4006 b641 ac1e 02ce  E..4A<@.@..A....
            0x0010:  ac1e e83b e3b6 374f 67d5 5b4c 7bd8 9372  ...;..7Og.[L{..r
            0x0020:  8010 00e5 436d 0000 0101 080a 17dd a5ad  ....Cm..........
            0x0030:  c7cc 3de3
    123456789101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899100101102103104105106107108109110111112113114115116117118119120121122123124125126127128129130131132133134135136

没搞懂， 客户端(同一个线程)通过socket(172.30.2.206.58294 > 172.30.232.59.14159）跟redis发生关系，

1.  首先发了一个get
2.  然后发了一个PING(为何这时候会有PING？）
3.  redis同时返回了上面两个请求的响应 $-1+PONG，但这时候-1就产生了空指针。

这里没搞明白为何在一个get请求之后会有个PING。

此外， 在看tcp包的时候， 经常会发现一条连接接连发了多个指令给redis，然后redis一次发回多个响应的情况。
有些怀疑人生了，因为jedis是用请求-响应，再请求-再响应这种交互模式的(非pipeline下)。
莫非tcpdump发生了丢包，导致我们看到的是假象？

确实， 从tcpdump的日志可以看出(tcpdump在退出的时候会打印一些统计数据)， 有1.8w+的包给丢弃了。

    4492851 packets captured
    4675218 packets received by filter
    182367 packets dropped by kernel
    
    1234

于是，调整了一下参数(主要是s0改为了s256，详见本文后的抓包脚本),继续抓包。
果然，丢包现象没有了， 但是依然存在同一条连接给一个或者多个线程连发2个指令的情况。

这时候已经分析了差不多一个月了， 身心俱疲， 且山穷水尽，就要放弃了。

明知道存在泄漏， 但不知道为何会泄漏。
明知道你在那里， 但不知道你在哪里。

### 3.3. 问题根源

抱着最后一搏的心态整理了一下思路，发现出现问题时，往往伴随着一次jedis的超时，这时候redis会一次返回两个指令的结果， 从而导致上面两个问题。

但jedis是连接池的模式， 单个线程独占一条连接，发完一个指令， 有了响应之后才会发第二个请求。
出现上面的问题，只有一个解释，就是jedis出现异常的时候， 没有关闭连接而是释放了连接。

看代码， 果不其然，在超时后，会触发JedisConnectionException， 然后如果是随机模式，jedis会进入finally块`释放`而不是`关闭`连接

    private T runWithRetries(String key, int redirections, boolean tryRandomNode, boolean asking) {
        if (redirections <= 0) {
            throw new JedisClusterMaxRedirectionsException("Too many Cluster redirections?");
        }
    
        Jedis connection = null;
        try {
    
            if (asking) {
                //...
            } else {
                if (tryRandomNode) {
                    connection = connectionHandler.getConnection();
                } else {
                    connection = connectionHandler.getConnectionFromSlot(JedisClusterCRC16.getSlot(key));
                }
            }
    
            return execute(connection);
        } catch (JedisConnectionException jce) {
            if (tryRandomNode) {
                // maybe all connection is down
                throw jce;
            }
    
            releaseConnection(connection, true);
            connection = null;
    
            // retry with random connection
            return runWithRetries(key, redirections - 1, true, asking);
        } catch (JedisRedirectionException jre) {
            //....
        } finally {
            releaseConnection(connection, false);
        }
    
    }
    12345678910111213141516171819202122232425262728293031323334353637

## 4\. 问题重现条件

要重现上述问题的话，需要满足如下条件:
问题1-连接泄漏:

1.  线程a向redis1发一个请求，超时，关闭连接，然后选择随机选择一个节点， 恰好也选择回redis1，
2.  a向redis1发请求，继续超时，这时候由于是random模式， 不会关闭连接而只是释放连接
3.  线程b拿到redis1这条连接，发PING
4.  redis1返回两个响应，第一个是线程a的响应， 第二个是PONG。 如果第一个响应是-1(表示key不存在)， 那么就会触发空指针，导致连接溢出

问题2-无中生有的MOVED指令:

1.  线程a向redis1发一个请求，get keyA, 超时，关闭链接，随机选择一个节点，为redis2
2.  线程a向redis2发请求，get keyA, 超时，这时候由于是random模式， 不会关闭连接而只是释放连接
3.  线程b拿到redis2，发请求 get keyB
4.  redis2返回两个响应，一个是线程a的响应: move redis1, 第二个是线程b的响应。
5.  线程b会拿到move redis1这个响应，然后就很疑惑， 明明keyB在redis2上， 为何要我move去redis1？

## 5\. 问题解决

在异常情况下，不管任何模式，都必须关闭连接，防止进入不可知之地。

    @@ -58,17 +58,20 @@ public abstract class JedisClusterCommand<T> {
     
           return execute(connection);
         } catch (JedisConnectionException jce) {
    +      releaseConnection(connection, true);
    +      connection = null;
    +
           if (tryRandomNode) {
             // maybe all connection is down
             throw jce;
           }
     
    -      releaseConnection(connection, true);
    -      connection = null;
    -
           // retry with random connection
           return runWithRetries(key, redirections - 1, true, asking);
         } catch (JedisRedirectionException jre) {
    +      releaseConnection(connection, false);
    +      connection = null;
    +
           if (jre instanceof JedisAskDataException) {
             asking = true;
             askConnection.set(this.connectionHandler.getConnectionFromNode(jre.getTargetNode()));
    @@ -80,9 +83,6 @@ public abstract class JedisClusterCommand<T> {
             throw new JedisClusterException(jre);
           }
     
    -      releaseConnection(connection, false);
    -      connection = null;
    -
           return runWithRetries(key, redirections - 1, false, asking);
         } finally {
           releaseConnection(connection, false);
    
    1234567891011121314151617181920212223242526272829303132333435

> 另外， 也可以通过设置AbandonedConfig, 对长时间没归还的活跃连接进行定期清理，一定程度上缓解连接泄漏造成的服务不可用的情况

## 6\. 后记

jedis的最新版本已经解决了这个问题。但升级也会存在风险。
我们的版本是2.6.2， jedis-2.7.x依然存在这个问题， 而且，新的版本也引入了其它的bug，在没有踩过坑的情况下，不建议贸然升级，何况我们即将推出重量级（实际上很轻巧）的自研`Yedis`驱动呢

> 抓包脚本

    #!/bin/bash
    nohup tcpdump -i eth0 -s 256 -C 1024 host 172.30.232.59 and tcp -n -X  -w redisTcpDump.cap &
    12

_![[./_resources/记一次Jedis连接池泄漏的分析_-_简书.resources/embedded.1.svg]]_
11人点赞_![[./_resources/记一次Jedis连接池泄漏的分析_-_简书.resources/embedded.2.svg]]_

_![[./_resources/记一次Jedis连接池泄漏的分析_-_简书.resources/embedded.3.svg]]_

[_![[./_resources/记一次Jedis连接池泄漏的分析_-_简书.resources/embedded.4.svg]]_技术](https://www.jianshu.com/nb/22398940)

_![[./_resources/记一次Jedis连接池泄漏的分析_-_简书.resources/embedded.5.svg]]_

"小礼物走一走，来简书关注我"
还没有人赞赏，支持一下
[![[8知识管理/InBox/evernote/参考/_resources/记一次Jedis连接池泄漏的分析_-_简书.resources/webp.webp]]](https://www.jianshu.com/u/cc3b7b3d3fb0)

[Ever\_00](https://www.jianshu.com/u/cc3b7b3d3fb0)轻量级开源微服务框架dapeng-soa维护者
总资产13 (约1.09元)共写了1.9W字获得35个赞共25个粉丝

    Created at: 2020-09-23T14:50:15+08:00
    Updated at: 2020-09-23T14:50:15+08:00


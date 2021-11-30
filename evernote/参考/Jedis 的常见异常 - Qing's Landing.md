
最近在读的 [Redis开发与运维](https://book.douban.com/subject/26971561/)，很好地总结了客户端的常见异常。这篇博客权且作为读书笔记。

# [__](https://hellokangning.github.io/zh/post/exceptions-thrown-by-jedis/#%E6%97%A0%E6%B3%95%E4%BB%8E%E8%BF%9E%E6%8E%A5%E6%B1%A0%E8%8E%B7%E5%8F%96%E5%88%B0%E8%BF%9E%E6%8E%A5)无法从连接池获取到连接

JedisPool 中的 Jedis 对象个数默认是 8 个。如果有 8 个 Jedis 对象被占用，并且没有归还，此时调用者还要从 JedisPool 中借用 Jedis，就需要进行等待（例如设置了 `maxWaitMillis > 0`），如果在 `maxWaitMillis` 时间内仍然无法获取到 Jedis 对象就会抛出如下异常：

Code

|     |     |
| --- | --- |
| 1<br>    2<br>    3<br>    4<br>    5<br>    6 | redis.clients.jedis.exceptions.JedisConnectionException: Could not get a resource<br>    from the pool<br>    …<br>    Caused by: java.util.NoSuchElementException: Timeout waiting for idle object<br>    at org.apache.commons.pool2.impl.GenericObjectPool.borrowObject(GenericObjectPool.<br>    java:449) |

另外一种情况，是设置了 `blockWhenExhausted = false`。调用者不会等待，直接抛出异常。

Code

|     |     |
| --- | --- |
| 1<br>    2<br>    3<br>    4<br>    5<br>    6 | redis.clients.jedis.exceptions.JedisConnectionException: Could not get a resource<br>    from the pool<br>    …<br>    Caused by: java.util.NoSuchElementException: Pool exhausted<br>    at org.apache.commons.pool2.impl.GenericObjectPool.borrowObject(GenericObjectPool.<br>    java:464) |

为甚么连接池没有资源了呢，原因非常多，首先检查下客户端：

1.  高并发下连接池设置过小。
2.  没有正确释放连接池。
3.  存在慢查询时，该 Jedis 对象归还速度会很慢，导致池子满了。

如果客户端正常，服务端的某些原因可能导致用户命令的阻塞，也会使客户端抛出这种异常。

# [__](https://hellokangning.github.io/zh/post/exceptions-thrown-by-jedis/#%E5%AE%A2%E6%88%B7%E7%AB%AF%E8%AF%BB%E5%86%99%E8%B6%85%E6%97%B6)客户端读写超时

Jedis 在调用 Redis 时，如果出现了读写超时后，会出现下面的异常：

Code

|     |     |
| --- | --- |
| 1<br>    2 | redis.clients.jedis.exceptions.JedisConnectionException:<br>    java.net.SocketTimeoutException: Read timed out |

造成该异常的原因也有以下几种：

*   读写超时间设置得过短。
*   命令本身就比较慢。
*   客户端与服务端网络不正常。
*   Redis自身发生阻塞。

# [__](https://hellokangning.github.io/zh/post/exceptions-thrown-by-jedis/#%E5%AE%A2%E6%88%B7%E7%AB%AF%E8%BF%9E%E6%8E%A5%E8%B6%85%E6%97%B6)客户端连接超时

Jedis 在调用 Redis 时，如果出现了连接超时后，会出现下面的异常：

Code

|     |     |
| --- | --- |
| 1<br>    2 | redis.clients.jedis.exceptions.JedisConnectionException:<br>    java.net.SocketTimeoutException: connect timed out |

造成该异常的原因也有以下几种：

1.  连接超时设置得过短，
2.  Redis发生阻塞，造成tcp-backlog已满，造成新的连接失败。
3.  客户端与服务端网络不正常。

# [__](https://hellokangning.github.io/zh/post/exceptions-thrown-by-jedis/#%E5%AE%A2%E6%88%B7%E7%AB%AF%E7%BC%93%E5%86%B2%E5%8C%BA%E5%BC%82%E5%B8%B8)客户端缓冲区异常

Jedis 在调用 Redis 时，如果出现客户端数据流异常，会出现下面的异常：

Code

|     |     |
| --- | --- |
| 1   | redis.clients.jedis.exceptions.JedisConnectionException: Unexpected end of stream. |

造成这个异常的原因可能有如下几种：

1.  输出缓冲区满。例如将普通客户端的输出缓冲区设置为 `1M 1M 60`： `config set client-output-buffer-limit "normal 1048576 1048576 60 slave 268435456 67108864 60 pubsub 33554432 8388608 60`。如果使用get命令获取一个bigkey（例如3M），就会出现这个异常。
2.  长时间闲置连接被服务端主动断开。
3.  不正常并发读写：Jedis对象同时被多个线程并发操作，可能会出现上述异常。

# [__](https://hellokangning.github.io/zh/post/exceptions-thrown-by-jedis/#redis-%E6%AD%A3%E5%9C%A8%E5%8A%A0%E8%BD%BD%E6%8C%81%E4%B9%85%E5%8C%96%E6%96%87%E4%BB%B6)Redis 正在加载持久化文件

Jedis 调用 Redis 时，如果 Redis 正在加载持久化文件，那么会收到下面的异常：

Code

|     |     |
| --- | --- |
| 1   | redis.clients.jedis.exceptions.JedisDataException: LOADING Redis is loading the dataset in memory |

# [__](https://hellokangning.github.io/zh/post/exceptions-thrown-by-jedis/#redis-%E4%BD%BF%E7%94%A8%E7%9A%84%E5%86%85%E5%AD%98%E8%B6%85%E8%BF%87-maxmemory-%E9%85%8D%E7%BD%AE)Redis 使用的内存超过 `maxmemory` 配置

Jedis 执行写操作时，如果 Redis 的使用内存大于 `maxmemory` 的设置，会收到下面的异常，此时应该调整 `maxmemory` 并找到造成内存增长的原因：

Code

|     |     |
| --- | --- |
| 1   | redis.clients.jedis.exceptions.JedisDataException: OOM command not allowed when used memory > 'maxmemory'. |

# [__](https://hellokangning.github.io/zh/post/exceptions-thrown-by-jedis/#%E5%AE%A2%E6%88%B7%E7%AB%AF%E8%BF%9E%E6%8E%A5%E6%95%B0%E8%BF%87%E5%A4%A7)客户端连接数过大

如果客户端连接数超过了maxclients，新申请的连接就会出现如下异常：

Code

|     |     |
| --- | --- |
| 1   | redis.clients.jedis.exceptions.JedisDataException: ERR max number of clients reached |

此时新的客户端连接执行任何命令，返回结果都是如下：

Code

|     |     |
| --- | --- |
| 1<br>    2 | 127.0.0.1:6379> get hello<br>    (error) ERR max number of clients reached |

    Created at: 2020-10-28T14:47:12+08:00
    Updated at: 2020-10-28T14:47:12+08:00


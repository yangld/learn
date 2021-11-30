
原创

# 详述 JedisCommands 接口中的方法说明

2020-04-07阅读 3090

# 前言

在 JedisCommands 接口中，其提供了操作 [Redis](https://cloud.tencent.com/product/crs?from=10680) 的全部方法，分别对应着 Redis 的各种操作命令，但遗憾的是，该接口中并没有给出详细的注释。

在这种情况下，如果我们想知道某个方法的作用，就需要我们找到其对应的 Redis 命令来进行理解了，很不方便。

因此，在本文中，给出 JedisCommands 接口中各方法的详细注释，希望对大家有所帮助！

顺便，给出 JedisCommands 接口所在包的 Maven 坐标：

<dependency\>
     <groupId\>redis.clients</groupId\>
     <artifactId\>jedis</artifactId\>
     <version\>2.9.0</version\>
</dependency\>

# 方法说明

package redis.clients.jedis;

import java.util.List;
import java.util.Map;
import java.util.Set;

import redis.clients.jedis.params.geo.GeoRadiusParam;
import redis.clients.jedis.params.sortedset.ZAddParams;
import redis.clients.jedis.params.sortedset.ZIncrByParams;

/\*\*
 \* Common interface for sharded and non-sharded Jedis
 \*/
public interface JedisCommands {

    /\*\*
     \* 存储数据到缓存中，若 key 已存在则覆盖
     \* value 的长度不能超过 1073741824 bytes (1 GB)
     \*
     \* @param key   缓存键
     \* @param value 缓存值
     \* @return
     \*/
    String set(String key, String value);

    /\*\*
     \* 存储数据到缓存中，并制定过期时间以及当 Key 存在时是否覆盖
     \*
     \* @param key   缓存键
     \* @param value 缓存值
     \* @param nxxx  该的值只能取 NX 或者 XX，
     \*              如果取 NX，则只有当 key 不存在时才进行 set
     \*              如果取 XX，则只有当 key 已经存在时才进行 set
     \* @param expx  该的值只能取 EX 或者 PX，代表数据过期时间的单位，EX 代表秒，PX 代表毫秒
     \* @param time  过期时间，单位是 expx 所代表的单位
     \* @return
     \*/
    String set(String key, String value, String nxxx, String expx, long time);

    /\*\*
     \* 从缓存中根据 key 取得其 String 类型的值
     \* 如果 key 不存在则返回 null
     \* 如果 key 存在但 value 不是 string 类型的，则返回一个错误
     \* 这个方法只能从缓存中取得 value 为 string 类型的值。
     \*
     \* @param key 缓存键
     \* @return
     \*/
    String get(String key);

    /\*\*
     \* 检查某个 key 是否在缓存中存在，如果存在返回true，否则返回false
     \* 需要注意的是，即使该 key 所对应的 value 是一个空字符串，也依然会返回 true
     \*
     \* @param key 缓存键
     \* @return
     \*/
    Boolean exists(String key);

    /\*\*
     \* 如果一个 key 设置了过期时间，则取消其过期时间，使其永久存在
     \*
     \* @param key 缓存键
     \* @return 返回 1 或者 0, 1 代表取消过期时间成功，0 代表不成功(只有当 key 不存在时这种情况才会发生)
     \*/
    Long persist(String key);

    /\*\*
     \* 返回某个 key 所存储的数据类型，返回的数据类型有可能是：
     \* "none", "string", "list", "set", "zset", "hash"
     \* 其中，"none" 代表 key 不存在
     \*
     \* @param key 缓存键
     \* @return
     \*/
    String type(String key);

    /\*\*
     \* 为 key 设置一个特定的过期时间，单位为秒，过期时间一到，redis 将会从缓存中删除掉该 key
     \* 即使是有过期时间的 key，redis 也会在持久化时将其写到硬盘中，并把相对过期时间改为绝对的 Unix 过期时间
     \* 在一个有设置过期时间的 key 上重复设置过期时间将会覆盖原先设置的过期时间
     \*
     \* @param key     缓存键
     \* @param seconds 过期时间，单位为秒
     \* @return 返回 1 表示成功设置过期时间，返回 0 表示 key 不存在
     \*/
    Long expire(String key, int seconds);

    /\*\*
     \* 机制同{@link expire}一样，只是时间单位改为毫秒
     \*
     \* @param key          缓存键
     \* @param milliseconds 过期时间，单位为毫秒
     \* @return 返回值同 {@link expire}一样
     \*/
    Long pexpire(String key, long milliseconds);

    /\*\*
     \* 与{@link expire}不一样，
     \* expireAt 设置的时间不是能存活多久，而是固定的 UNIX 时间（从1970年开始算起），单位为秒
     \*
     \* @param key      缓存键
     \* @param unixTime 过期时间
     \* @return
     \*/
    Long expireAt(String key, long unixTime);

    /\*\*
     \* 同{@link expireAt}机制相同，但单位为毫秒
     \*
     \* @param key                   缓存键
     \* @param millisecondsTimestamp 过期时间
     \* @return
     \*/
    Long pexpireAt(String key, long millisecondsTimestamp);

    /\*\*
     \* 返回一个 key 还能活多久，单位为秒
     \*
     \* @param key 缓存键
     \* @return 如果该 key 本来并没有设置过期时间，则返回 -1，如果该 key 不存在，则返回 -2
     \*/
    Long ttl(String key);

    /\*\*
     \* 设置或者清除指定 key 的 value 上的某个位置的比特位
     \* 如果该 key 原先不存在，则新创建一个 key，其 value 将会自动分配内存，
     \* 直到可以放下指定位置的bit值
     \*
     \* @param key    缓存键
     \* @param offset 位置偏移量
     \* @param value  true 代表 1，false 代表 0
     \* @return 返回原来位置的 bit 值是否是 1，如果是 1，则返回 true，否则返回 false
     \*/
    Boolean setbit(String key, long offset, boolean value);

    /\*\*
     \* 设置或者清除指定 key 的 value 上的某个位置的比特位，
     \* 如果该 key 原先不存在，则新创建一个 key，其 value 将会自动分配内存，
     \* 直到可以放下指定位置的 bit 值
     \*
     \* @param key    缓存键
     \* @param offset 位置偏移量
     \* @param value  只能是 "1" 或者 "0"
     \* @return 返回原来位置的 bit 值是否是 1，如果是 1，则返回 true，否则返回 false
     \*/
    Boolean setbit(String key, long offset, String value);

    /\*\*
     \* 取得偏移量为 offset 的 bit 值
     \*
     \* @param key    缓存键
     \* @param offset 位置偏移量
     \* @return true 代表 1，false 代表 0
     \*/
    Boolean getbit(String key, long offset);

    /\*\*
     \* 这个命令的作用是覆盖 key 对应的 string 的一部分，从指定的 offset 处开始，覆盖 value 的长度
     \* 如果 offset 比当前 key 对应 string 还要长，那这个 string 后面就补 0 以达到 offset
     \* 不存在的 key 被认为是空字符串，所以这个命令可以确保 key 有一个足够大的字符串，能在 offset 处设置 value
     \*
     \* @param key    缓存键
     \* @param offset 位置偏移量
     \* @param value
     \* @return 该命令修改后的字符串长度
     \*/
    Long setrange(String key, long offset, String value);

    /\*\*
     \* 获得 start - end 之间的子字符串，若偏移量为负数，代表从末尾开始计算
     \* 例如 -1 代表倒数第一个，-2 代表倒数第二个
     \*
     \* @param key         缓存键
     \* @param startOffset 起始偏移量
     \* @param endOffset   末尾偏移量
     \* @return
     \*/
    String getrange(String key, long startOffset, long endOffset);

    /\*\*
     \* 自动将 key 对应到 value 并且返回原来 key 对应的 value
     \* 如果 key 存在但是对应的 value不 是字符串，就返回错误
     \*
     \* @param key   缓存键
     \* @param value 缓存值
     \* @return
     \*/
    String getSet(String key, String value);

    /\*\*
     \* 当 key 不存在时，进行 set
     \*
     \* @param key   缓存键
     \* @param value 缓存值
     \* @return
     \*/
    Long setnx(String key, String value);

    /\*\*
     \* 当 key 存在时，进行 set
     \*
     \* @param key     缓存键
     \* @param seconds 过期时间，单位为秒
     \* @param value   缓存键
     \* @return
     \*/
    String setex(String key, int seconds, String value);

    /\*\*
     \* 将指定 key 的值减少某个值
     \*
     \* @param key     缓存键
     \* @param integer 待减值
     \* @return 返回减少后的新值
     \*/
    Long decrBy(String key, long integer);

    /\*\*
     \* 将指定 Key 的值减少 1
     \*
     \* @param key 缓存键
     \* @return 返回减少后的新值
     \*/
    Long decr(String key);

    /\*\*
     \* 将指定的 key 的值增加指定的值
     \*
     \* @param key     缓存键
     \* @param integer 待加值
     \* @return 返回增加后的新值
     \*/
    Long incrBy(String key, long integer);

    /\*\*
     \* 将指定的 key 的值增加指定的值(浮点数)
     \*
     \* @param key   缓存键
     \* @param value 待加值
     \* @return 返回增加后的新值
     \*/
    Double incrByFloat(String key, double value);

    /\*\*
     \* 将指定的 key 的值增加 1
     \*
     \* @param key 缓存键
     \* @return 返回增加后的新值
     \*/
    Long incr(String key);

    /\*\*
     \* 若 key 存在，将 value 追加到原有字符串的末尾
     \* 若 key 不存在，则创建一个新的空字符串
     \*
     \* @param key   缓存键
     \* @param value 待处理值
     \* @return 返回字符串的总长度
     \*/
    Long append(String key, String value);

    /\*\*
     \* 返回 start - end 之间的子字符串(start 和 end 处的字符也包括在内)
     \*
     \* @param key   缓存键
     \* @param start 起始索引
     \* @param end   结束索引
     \* @return 返回子字符串
     \*/
    String substr(String key, int start, int end);

    /\*\*
     \* 设置 hash 表里 field 字段的值为 value
     \* 如果 key 不存在，则创建一个新的 hash 表
     \*
     \* @param key   缓存键
     \* @param field 哈希表字段
     \* @param value 字段对应的值
     \* @return 如果该字段已经存在，那么将会更新该字段的值，返回 0，如果字段不存在，则新创建一个并且返回 1
     \*/
    Long hset(String key, String field, String value);

    /\*\*
     \* 如果该 key 对应的值是一个哈希表，则返回对应字段的值
     \* 如果不存在该字段，或者 key 不存在，则返回一个 "nil" 值
     \*
     \* @param key   缓存键
     \* @param field 哈希表字段
     \* @return
     \*/
    String hget(String key, String field);

    /\*\*
     \* 当字段不存在时，才进行 set
     \*
     \* @param key   缓存键
     \* @param field 哈希表字段
     \* @param value 字段对应的值
     \* @return 如果该字段已经存在，则返回 0，若字段不存在，则创建后 set，返回 1
     \*/
    Long hsetnx(String key, String field, String value);

    /\*\*
     \* 设置多个字段和值，如果字段存在，则覆盖
     \*
     \* @param key  缓存键
     \* @param hash 哈希表
     \* @return 设置成功返回 OK，设置不成功则返回 EXCEPTION
     \*/
    String hmset(String key, Map<String, String\> hash);

    /\*\*
     \* 在 hash 中获取多个字段的值，若字段不存在，则其值为 nil
     \*
     \* @param key    缓存键
     \* @param fields 哈希表字段
     \* @return 按顺序返回多个字段的值。
     \*/
    List<String\> hmget(String key, String... fields);

    /\*\*
     \* 对 hash 中指定字段的值增加指定的值
     \*
     \* @param key   缓存键
     \* @param field 哈希表字段
     \* @param value 字段对应的值
     \* @return 返回增加后的新值
     \*/
    Long hincrBy(String key, String field, long value);

    /\*\*
     \* 判断 hash 中指定字段是否存在
     \*
     \* @param key   缓存键
     \* @param field 哈希表字段
     \* @return 若存在返回 1，若不存在返回 0
     \*/
    Boolean hexists(String key, String field);

    /\*\*
     \* 删除 hash 中指定字段
     \*
     \* @param key   缓存键
     \* @param field 哈希表字段
     \* @return 删除成功返回 1， 删除不成功返回 0
     \*/
    Long hdel(String key, String... field);

    /\*\*
     \* 返回 key 指定的哈希集包含的字段的数量
     \*
     \* @param key 缓存键
     \* @return 哈希集中字段的数量，当 key 指定的哈希集不存在时返回 0
     \*/
    Long hlen(String key);

    /\*\*
     \* 返回 key 指定的哈希集中所有字段的名字
     \*
     \* @param key 缓存键
     \* @return 哈希集中的字段列表，当 key 指定的哈希集不存在时返回空列表
     \*/
    Set<String\> hkeys(String key);

    /\*\*
     \* 返回 key 指定的哈希集中所有字段的值。
     \*
     \* @param key 缓存键
     \* @return 哈希集中的值的列表，当 key 指定的哈希集不存在时返回空列表
     \*/
    List<String\> hvals(String key);

    /\*\*
     \* 返回 key 指定的哈希集中所有的字段和值
     \*
     \* @param key 缓存键
     \* @return 返回 key 指定的哈希集中所有的字段和值,若 key 不存在返回空 map
     \*/
    Map<String, String\> hgetAll(String key);

    /\*\*
     \* 向存于 key 的列表的尾部插入所有指定的值
     \* 如果 key 不存在，那么会创建一个空的列表然后再进行 push 操作
     \* 当 key 对应的值不是一个列表，那么会返回一个错误
     \* <p>
     \* 可以使用一个命令把多个元素打入队列，只需要在命令后面指定多个参数，元素是从左到右一个接一个从列表尾部插入
     \* 比如命令 RPUSH mylist a b c 会返回一个列表，其第一个元素是 a ，第二个元素是 b ，第三个元素是 c
     \*
     \* @param key    缓存键
     \* @param string 待处理字符串
     \* @return 返回 push 操作后的列表长度
     \*/
    Long rpush(String key, String... string);

    /\*\*
     \* 将所有指定的值插入到存于 key 的列表的头部
     \* 如果 key 不存在，那么在进行 push 操作前会创建一个空列表
     \* 如果 key 对应的值不是一个 list 的话，那么会返回一个错误
     \* <p>
     \* 可以使用一个命令把多个元素 push 进入列表，只需在命令末尾加上多个指定的参数，元素是从最左端的到最右端的、一个接一个被插入到列表的头部
     \* 比如命令 LPUSH mylist a b c，返回的列表是 c 为第一个元素， b 为第二个元素， a 为第三个元素
     \*
     \* @param key    缓存键
     \* @param string 待处理字符串
     \* @return 在 push 操作后的列表长度。
     \*/
    Long lpush(String key, String... string);

    /\*\*
     \* 返回存储在 key 里的 list 的长度
     \* 如果 key 不存在，那么就被看作是空 list，并且返回长度为 0
     \* 当存储在 key 里的值不是一个 list 的话，会返回错误
     \*
     \* @param key 缓存键
     \* @return key 对应的 list 的长度。
     \*/
    Long llen(String key);

    /\*\*
     \* 返回存储在 key 的列表里指定范围内的元素
     \* start 和 end 偏移量都是基于 0 的下标
     \* 即 list 的第一个元素下标是 0（list 的表头），第二个元素下标是 1，以此类推
     \* <p>
     \* 偏移量也可以是负数，表示偏移量是从 list 尾部开始计数
     \* 例如，-1 表示列表的最后一个元素，-2 是倒数第二个，以此类推
     \*
     \* @param key   缓存键
     \* @param start 起始偏移量
     \* @param end   结束偏移量
     \* @return 指定范围里的列表元素
     \*/
    List<String\> lrange(String key, long start, long end);

    /\*\*
     \* 修剪(trim)一个已存在的 list，处理后的 list 只包含指定范围的指定元素
     \* start 和 stop 都是由 0 开始计数的，
     \* 这里的 0 是列表里的第一个元素（表头），1 是第二个元素，以此类推
     \*
     \* @param key   缓存键
     \* @param start 起始偏移量
     \* @param end   结束偏移量
     \* @return
     \*/
    String ltrim(String key, long start, long end);

    /\*\*
     \* 返回列表里的元素的索引 index 存储在 key 里面
     \* 下标是从 0 开始索引的，所以 0 是表示第一个元素，1 表示第二个元素，并以此类推
     \* 负数索引用于指定从列表尾部开始索引的元素。在这种方法下，-1 表示最后一个元素，-2 表示倒数第二个元素，并以此往前推
     \* <p>
     \* 当 key 位置的值不是一个列表的时候，会返回一个错误
     \*
     \* @param key   缓存键
     \* @param index 索引
     \* @return 请求的对应元素，或者当 index 超过范围的时候返回 nil
     \*/
    String lindex(String key, long index);

    /\*\*
     \* 设置 index 位置的 list 元素的值为 value，当 index 超出范围时会返回一个错误
     \*
     \* @param key   缓存键
     \* @param index 索引
     \* @param value 待处理值
     \* @return 状态恢复
     \*/
    String lset(String key, long index, String value);

    /\*\*
     \* 从存于 key 的列表里移除前 count 次出现的值为 value 的元素，这个 count 参数通过下面几种方式影响这个操作：
     \* <p>
     \* count > 0: 从头往尾移除值为 value 的元素
     \* count < 0: 从尾往头移除值为 value 的元素
     \* count = 0: 移除所有值为 value 的元素
     \* <p>
     \* 比如， LREM list -2 "hello" 会从存于 list 的列表里移除最后两个出现的 "hello"
     \* <p>
     \* 需要注意的是，如果 list 里没有存在 key 就会被当作空 list 处理，所以当 key 不存在的时候，这个命令会返回 0
     \*
     \* @param key   缓存键
     \* @param count 出现次数
     \* @param value 待处理值
     \* @return 返回删除的个数
     \*/
    Long lrem(String key, long count, String value);

    /\*\*
     \* 移除并且返回 key 对应的 list 的第一个元素
     \*
     \* @param key 缓存键
     \* @return 返回第一个元素的值，或者当 key 不存在时返回 nil
     \*/
    String lpop(String key);

    /\*\*
     \* 移除并返回存于 key 的 list 的最后一个元素
     \*
     \* @param key 缓存键
     \* @return 最后一个元素的值，或者当 key 不存在的时候返回 nil
     \*/
    String rpop(String key);

    /\*\*
     \* 添加一个或多个指定的 member 元素到 key 对应的集合中
     \* 指定的一个或者多个元素 member 如果已经在集合 key 中存在则忽略
     \* 如果集合 key 不存在，则新建集合 key,并添加 member 元素到集合 key 中
     \* <p>
     \* 如果key 的类型不是集合则返回错误.
     \*
     \* @param key    缓存键
     \* @param member 待处理成员
     \* @return 返回新成功添加到集合里元素的数量，不包括已经存在于集合中的元素
     \*/
    Long sadd(String key, String... member);

    /\*\*
     \* 返回 key 集合所有的元素
     \* <p>
     \* 该命令的作用与使用一个参数的 SINTER 命令作用相同
     \*
     \* @param key 缓存键
     \* @return 集合中的所有元素
     \*/
    Set<String\> smembers(String key);

    /\*\*
     \* 在 key 集合中移除指定的元素
     \* 如果指定的元素不是 key 集合中的元素则忽略
     \* 如果 key 集合不存在则被视为一个空的集合，该命令返回 0
     \* <p>
     \* 如果 key 的类型不是一个集合,则返回错误
     \*
     \* @param key    缓存键
     \* @param member 待处理成员
     \* @return 从集合中移除元素的个数，不包括不存在的成员
     \*/
    Long srem(String key, String... member);

    /\*\*
     \* 移除并返回一个集合中的随机元素
     \* <p>
     \* 该命令与 SRANDMEMBER 相似,不同的是 srandmember 命令返回一个随机元素但是不移除
     \*
     \* @param key 缓存键
     \* @return 被移除的元素, 当 key 不存在的时候返回 nil
     \*/
    String spop(String key);

    /\*\*
     \* 移除并返回多个集合中的随机元素
     \*
     \* @param key   缓存键
     \* @param count 数量
     \* @return 被移除的元素, 当 key 不存在的时候值为 nil
     \*/
    Set<String\> spop(String key, long count);

    /\*\*
     \* 返回集合存储的 key 的基数 (集合元素的数量)
     \*
     \* @param key 缓存键
     \* @return 集合的基数(元素的数量), 如果 key 不存在, 则返回 0
     \*/
    Long scard(String key);

    /\*\*
     \* 返回成员 member 是否是存储的集合 key 的成员
     \*
     \* @param key    缓存键
     \* @param member 待处理成员
     \* @return 如果 member 元素是集合 key 的成员，则返回 1，如果不是或者集合 key 不存在，则返回 0
     \*/
    Boolean sismember(String key, String member);

    /\*\*
     \* 仅提供 key 参数,那么随机返回 key 集合中的一个元素
     \* 该命令作用类似于 SPOP 命令, 不同的是 SPOP 命令会将被选择的随机元素从集合中移除
     \* 而 SRANDMEMBER 仅仅是返回该随记元素，而不做任何操作
     \*
     \* @param key 缓存键
     \* @return 返回随机的元素, 如果 key 不存在则返回 nil
     \*/
    String srandmember(String key);

    /\*\*
     \* 如果 count 是整数且小于元素的个数，则返回含有 count 个不同的元素的列表
     \* 如果 count 是整数且大于集合中元素的个数时，仅返回整个集合的所有元素
     \* 如果 count 是负数，则会返回一个包含 count 的绝对值的个数元素的列表
     \* 如果 count 的绝对值大于元素的个数，则返回的结果集里会出现一个元素出现多次的情况
     \*
     \* @param key   缓存键
     \* @param count 数量
     \* @return 返回一个随机的元素数组, 如果 key 不存在则返回一个空的列表
     \*/
    List<String\> srandmember(String key, int count);

    /\*\*
     \* 返回 key 的 string 类型 value 的长度
     \* 如果 key 对应的非 string 类型，就返回错误
     \*
     \* @param key 缓存键
     \* @return key 对应的字符串 value 的长度，或者 0（key不存在）
     \*/
    Long strlen(String key);

    /\*\*
     \* 该命令添加指定的成员到 key 对应的有序集合中，每个成员都有一个分数，你可以指定多个分数/成员组合
     \* 如果一个指定的成员已经在对应的有序集合中了，那么其分数就会被更新成最新的，并且该成员会重新调整到正确的位置，以确保集合有序
     \* 如果 key 不存在，就会创建一个含有这些成员的有序集合，就好像往一个空的集合中添加一样
     \* 如果 key 存在，但是它并不是一个有序集合，那么就返回一个错误
     \* <p>
     \* 分数的值必须是一个表示数字的字符串，并且可以是 double 类型的浮点数
     \*
     \* @param key    缓存键
     \* @param score  分数
     \* @param member 待处理成员
     \* @return 返回添加到有序集合中元素的个数，不包括那种已经存在只是更新分数的元素
     \*/
    Long zadd(String key, double score, String member);

    /\*\*
     \* 该命令添加指定的成员到 key 对应的有序集合中，每个成员都有一个分数，你可以指定多个分数/成员组合
     \* 如果一个指定的成员已经在对应的有序集合中了，那么其分数就会被更新成最新的，并且该成员会重新调整到正确的位置，以确保集合有序
     \* 如果 key 不存在，就会创建一个含有这些成员的有序集合，就好像往一个空的集合中添加一样
     \* 如果 key 存在，但是它并不是一个有序集合，那么就返回一个错误
     \* <p>
     \* 分数的值必须是一个表示数字的字符串，并且可以是 double 类型的浮点数
     \*
     \* @param key          缓存键
     \* @param scoreMembers 成员及分数 MAP
     \* @return 返回添加到有序集合中元素的个数，不包括那种已经存在只是更新分数的元素
     \*/
    Long zadd(String key, Map<String, Double\> scoreMembers);

    /\*\*
     \* 返回有序集 key 中，指定区间内的成员。
     \* 其中成员按 score 值递增(从小到大)来排序，具有相同 score 值的成员按字典序来排列
     \* <p>
     \* 如果你需要成员按 score 值递减(score 相等时按字典序递减)来排列，请使用 ZREVRANGE 命令
     \* 下标参数 start 和 stop 都以 0 为底，也就是说，以 0 表示有序集第一个成员，以 1 表示有序集第二个成员，以此类推
     \* 你也可以使用负数下标，以 -1 表示最后一个成员，-2 表示倒数第二个成员，以此类推
     \* <p>
     \* 超出范围的下标并不会引起错误。如果 start 的值比有序集的最大下标还要大，
     \* 或是 start > stop 时，ZRANGE 命令只是简单地返回一个空列表
     \* 另一方面，假如 stop 参数的值比有序集的最大下标还要大，那么 Redis 将 stop 当作最大下标来处理
     \*
     \* @param key   缓存键
     \* @param start 起始索引
     \* @param end   结束索引
     \* @return 指定范围的元素列表
     \*/
    Set<String\> zrange(String key, long start, long end);

    /\*\*
     \* 从集合中删除指定 member 元素，当 key 存在，但是其不是有序集合类型，就返回一个错误
     \*
     \* @param key    缓存键
     \* @param member 待处理成员
     \* @return 返回的是从有序集合中删除的成员个数，不包括不存在的成员
     \*/
    Long zrem(String key, String... member);

    /\*\*
     \* 为有序集 key 的成员 member 的 score 值加上增量 increment
     \* 如果 key 中不存在 member，就在 key 中添加一个 member，其 score 是 increment（就好像它之前的 score 是0.0）
     \* 如果 key 不存在，就创建一个只含有指定 member 成员的有序集合
     \* 如果 key 不是有序集类型时，返回一个错误
     \* <p>
     \* score 值必须整数值或双精度浮点数，也有可能给一个负数来减少 score 的值
     \*
     \* @param key    缓存键
     \* @param score  分数
     \* @param member 待处理成员
     \* @return member 成员的新 score 值
     \*/
    Double zincrby(String key, double score, String member);

    /\*\*
     \* 返回有序集 key 中成员 member 的排名
     \* 其中有序集成员按 score 值递增(从小到大)顺序排列
     \* 排名以 0 为底，也就是说，score 值最小的成员排名为 0
     \* <p>
     \* 使用 ZREVRANK 命令可以获得成员按 score 值递减(从大到小)排列的排名
     \*
     \* @param key    缓存键
     \* @param member 待处理成员
     \* @return 如果 member 是有序集 key 的成员，返回 member 的排名的整数，如果 member 不是有序集 key 的成员，返回 nil
     \*/
    Long zrank(String key, String member);

    /\*\*
     \* 返回有序集 key 中成员 member 的排名
     \* 其中有序集成员按 score 值从大到小排列
     \* 排名以 0 为底，也就是说，score 值最大的成员排名为 0
     \* <p>
     \* 使用 ZRANK 命令可以获得成员按 score 值递增(从小到大)排列的排名
     \*
     \* @param key    缓存键
     \* @param member 待处理成员
     \* @return 如果 member 是有序集 key 的成员，返回 member 的排名，如果 member 不是有序集 key 的成员，返回 nil
     \*/
    Long zrevrank(String key, String member);

    /\*\*
     \* 返回有序集 key 中，指定区间内的成员
     \* 其中成员的位置按 score 值递减(从大到小)来排列，具有相同 score 值的成员按字典序的反序排列
     \* 除了成员按 score 值递减的次序排列这一点外，ZREVRANGE 命令的其他方面和 ZRANGE 命令一样
     \*
     \* @param key   缓存键
     \* @param start 起始索引
     \* @param end   结束索引
     \* @return 指定范围的元素列表(可选是否含有分数)
     \*/
    Set<String\> zrevrange(String key, long start, long end);

    /\*\*
     \* 返回有序集 key 中，指定区间内的成员
     \* 其中成员按 score 值递增(从小到大)来排序，具有相同 score 值的成员按字典序来排列
     \* <p>
     \* 如果你需要成员按 score 值递减(score 相等时按字典序递减)来排列，请使用 ZREVRANGE 命令
     \* 下标参数 start 和 stop 都以 0 为底，也就是说，以 0 表示有序集第一个成员，以 1 表示有序集第二个成员，以此类推
     \* 你也可以使用负数下标，以 -1 表示最后一个成员，-2 表示倒数第二个成员，以此类推
     \* <p>
     \* 超出范围的下标并不会引起错误。如果 start 的值比有序集的最大下标还要大
     \* 或是 start > stop 时，ZRANGE 命令只是简单地返回一个空列表
     \* 另一方面，假如 stop 参数的值比有序集的最大下标还要大，那么 Redis 将 stop 当作最大下标来处理
     \* <p>
     \* 使用 WITHSCORES 选项，来让成员和它的 score 值一起返回
     \* 返回列表以v alue1,score1, ..., valueN,scoreN 的格式表示，而不是 value1,...,valueN
     \* 客户端库可能会返回一些更复杂的数据类型，比如数组、元组等
     \*
     \* @param key
     \* @param start
     \* @param end
     \* @return 指定范围的元素列表(以元组集合的形式)。
     \*/
    Set<Tuple\> zrangeWithScores(String key, long start, long end);

    /\*\*
     \* 返回有序集key中，指定区间内的成员。其中成员的位置按score值递减(从大到小)来排列。具有相同score值的成员按字典序的反序排列。
     \* 除了成员按score值递减的次序排列这一点外，ZREVRANGE命令的其他方面和ZRANGE命令一样。
     \*
     \* @param key   缓存键
     \* @param start 起始索引
     \* @param end   结束索引
     \* @return 指定范围的元素列表(可选是否含有分数)
     \*/
    Set<Tuple\> zrevrangeWithScores(String key, long start, long end);

    /\*\*
     \* 返回 key 的有序集元素个数
     \*
     \* @param key 缓存键
     \* @return key存在的时候，返回有序集的元素个数，否则返回0
     \*/
    Long zcard(String key);

    /\*\*
     \* 返回有序集 key 中，成员 member 的 score 值
     \* 如果 member 元素不是有序集 key 的成员，或 key 不存在，返回nil
     \*
     \* @param key    缓存键
     \* @param member 待处理成员
     \* @return member 成员的 score 值（double 型浮点数）
     \*/
    Double zscore(String key, String member);

    /\*\*
     \* 对一个集合或者一个列表排序
     \* <p>
     \* 对集合，有序集合，或者列表的 value 进行排序，默认情况下排序只对数字排序，双精度浮点数
     \*
     \* @param key 缓存键
     \* @return 假设集合或列表包含的是数字元素，那么返回的将会是从小到大排列的一个列表
     \* @see #sort(String, String)
     \* @see #sort(String, SortingParams)
     \* @see #sort(String, SortingParams, String)
     \*/
    List<String\> sort(String key);

    /\*\*
     \* 根据指定参数来对列表或集合进行排序
     \* <p>
     \* <b>examples:</b>
     \* <p>
     \* 以下是一些例子列表或者key-value:
     \* <p>
     \* <pre>
     \* x = \[1, 2, 3\]
     \* y = \[a, b, c\]
     \*
     \* k1 = z
     \* k2 = y
     \* k3 = x
     \*
     \* w1 = 9
     \* w2 = 8
     \* w3 = 7
     \* </pre>
     \* <p>
     \* 排序:
     \* <p>
     \* <pre>
     \* sort(x) or sort(x, sp.asc())
     \* -> \[1, 2, 3\]
     \*
     \* sort(x, sp.desc())
     \* -> \[3, 2, 1\]
     \*
     \* sort(y)
     \* -> \[c, a, b\]
     \*
     \* sort(y, sp.alpha())
     \* -> \[a, b, c\]
     \*
     \* sort(y, sp.alpha().desc())
     \* -> \[c, b, a\]
     \* </pre>
     \* <p>
     \* Limit (e.g. for Pagination):
     \* <p>
     \* <pre>
     \* sort(x, sp.limit(0, 2))
     \* -> \[1, 2\]
     \*
     \* sort(y, sp.alpha().desc().limit(1, 2))
     \* -> \[b, a\]
     \* </pre>
     \* <p>
     \* 使用外部键来排序:
     \* <p>
     \* <pre>
     \* sort(x, sb.by(w\*))
     \* -> \[3, 2, 1\]
     \*
     \* sort(x, sb.by(w\*).desc())
     \* -> \[1, 2, 3\]
     \* </pre>
     \* <p>
     \* Getting external keys:
     \* <p>
     \* <pre>
     \* sort(x, sp.by(w\*).get(k\*))
     \* -> \[x, y, z\]
     \*
     \* sort(x, sp.by(w\*).get(#).get(k\*))
     \* -> \[3, x, 2, y, 1, z\]
     \* </pre>
     \*
     \* @param key               缓存键
     \* @param sortingParameters 排序参数
     \* @return 返回排序列表
     \* @see #sort(String)
     \* @see #sort(String, SortingParams, String)
     \*/
    List<String\> sort(String key, SortingParams sortingParameters);

    /\*\*
     \* 返回有序集 key 中，score 值在 min 和 max 之间(默认包括 score 值等于 min 或 max )的成员
     \*
     \* @param key 缓存键
     \* @param min 最小分数
     \* @param max 最大分数
     \* @return 指定分数范围的元素个数
     \*/
    Long zcount(String key, double min, double max);

    /\*\*
     \* 返回有序集 key 中，score 值在 min 和 max 之间(默认包括 score 值等于 min 或 max )的成员
     \*
     \* @param key 缓存键
     \* @param min 最小分数
     \* @param max 最大分数
     \* @return 指定分数范围的元素个数
     \*/
    Long zcount(String key, String min, String max);

    /\*\*
     \* 返回 key 的有序集合中的分数在 min 和 max 之间的所有元素（包括分数等于 max 或者 min 的元素）
     \* 元素被认为是从低分到高分排序的，具有相同分数的元素按字典序排列
     \*
     \* @param key 缓存键
     \* @param min 最小分数
     \* @param max 最大分数
     \* @return 指定分数范围的元素列表
     \*/
    Set<String\> zrangeByScore(String key, double min, double max);

    /\*\*
     \* 返回 key 的有序集合中的分数在 min 和 max 之间的所有元素（包括分数等于 max 或者 min 的元素）
     \* 元素被认为是从低分到高分排序的，具有相同分数的元素按字典序排列
     \*
     \* @param key 缓存键
     \* @param min 最小分数
     \* @param max 最大分数
     \* @return 指定分数范围的元素列表
     \*/
    Set<String\> zrangeByScore(String key, String min, String max);

    /\*\*
     \* 返回 key 的有序集合中的分数在 min 和 max 之间的所有元素（包括分数等于 max 或者 min 的元素）
     \* 元素被认为是从低分到高分排序的，具有相同分数的元素按字典序排列, 指定返回结果的数量及区间
     \*
     \* @param key    缓存键
     \* @param min    最小分数
     \* @param max    最大分数
     \* @param offset 偏移量
     \* @param count  数量
     \* @return 指定分数范围的元素列表
     \*/
    Set<String\> zrangeByScore(String key, double min, double max, int offset, int count);

    /\*\*
     \* 返回 key 的有序集合中的分数在 min 和 max 之间的所有元素（包括分数等于 max 或者 min 的元素）
     \* 元素被认为是从低分到高分排序的，具有相同分数的元素按字典序排列, 指定返回结果的数量及区间
     \*
     \* @param key    缓存键
     \* @param min    最小分数
     \* @param max    最大分数
     \* @param offset 偏移量
     \* @param count  数量
     \* @return 指定分数范围的元素列表
     \*/
    Set<String\> zrangeByScore(String key, String min, String max, int offset, int count);

    /\*\*
     \* 返回 key 的有序集合中的分数在 min 和 max 之间的所有元素（包括分数等于 max 或者 min 的元素）
     \* 元素被认为是从低分到高分排序的，具有相同分数的元素按字典序排列。返回元素和其分数，而不只是元素
     \*
     \* @param key 缓存键
     \* @param min 最小分数
     \* @param max 最大分数
     \* @return 指定分数范围的元素元组集合
     \*/
    Set<Tuple\> zrangeByScoreWithScores(String key, double min, double max);

    /\*\*
     \* 返回 key 的有序集合中的分数在 min 和 max 之间的所有元素（包括分数等于 max 或者 min 的元素）
     \* 元素被认为是从低分到高分排序的，指定返回结果的数量及区间，返回元素和其分数，而不只是元素
     \*
     \* @param key    缓存键
     \* @param min    最小分数
     \* @param max    最大分数
     \* @param offset 偏移量
     \* @param count  数量
     \* @return 指定分数范围的元素元组集合
     \*/
    Set<Tuple\> zrangeByScoreWithScores(String key, double min, double max, int offset, int count);

    /\*\*
     \* 返回 key 的有序集合中的分数在 min 和 max 之间的所有元素（包括分数等于 max 或者 min 的元素）
     \* 元素被认为是从低分到高分排序的，指定返回结果的数量及区间，返回元素和其分数，而不只是元素
     \*
     \* @param key 缓存键
     \* @param min 最小分数
     \* @param max 最大分数
     \* @return 指定分数范围的元素元组集合
     \*/
    Set<Tuple\> zrangeByScoreWithScores(String key, String min, String max);

    /\*\*
     \* 返回 key 的有序集合中的分数在 min 和 max 之间的所有元素（包括分数等于 max 或者 min 的元素）
     \* 元素被认为是从低分到高分排序的，指定返回结果的数量及区间，返回元素和其分数，而不只是元素
     \*
     \* @param key    缓存键
     \* @param min    最小分数
     \* @param max    最大分数
     \* @param offset 偏移量
     \* @param count  数量
     \* @return 指定分数范围的元素元组集合
     \*/
    Set<Tuple\> zrangeByScoreWithScores(String key, String min, String max, int offset, int count);

    /\*\*
     \* 机制与 zrangeByScore 一样，只是返回结果为降序排序
     \*
     \* @param key 缓存键
     \* @param min 最小分数
     \* @param max 最大分数
     \* @return 指定分数范围的元素列表
     \*/
    Set<String\> zrevrangeByScore(String key, double max, double min);

    /\*\*
     \* 机制与 zrangeByScore 一样，只是返回结果为降序排序
     \*
     \* @param key 缓存键
     \* @param min 最小分数
     \* @param max 最大分数
     \* @return 指定分数范围的元素列表
     \*/
    Set<String\> zrevrangeByScore(String key, String max, String min);

    /\*\*
     \* 机制与 zrangeByScore 一样，只是返回结果为降序排序
     \*
     \* @param key    缓存键
     \* @param min    最小分数
     \* @param max    最大分数
     \* @param offset 偏移量
     \* @param count  数量
     \* @return 指定分数范围的元素列表
     \*/
    Set<String\> zrevrangeByScore(String key, double max, double min, int offset, int count);

    /\*\*
     \* 机制与 zrangeByScoreWithScores 一样，只是返回结果为降序排序
     \*
     \* @param key 缓存键
     \* @param min 最小分数
     \* @param max 最大分数
     \* @return 指定分数范围的元素元组集合
     \*/
    Set<Tuple\> zrevrangeByScoreWithScores(String key, double max, double min);

    /\*\*
     \* 机制与 zrangeByScore 一样，只是返回结果为降序排序
     \*
     \* @param key    缓存键
     \* @param min    最小分数
     \* @param max    最大分数
     \* @param offset 偏移量
     \* @param count  数量
     \* @return 指定分数范围的元素列表
     \*/
    Set<String\> zrevrangeByScore(String key, String max, String min, int offset, int count);

    /\*\*
     \* 机制与 zrangeByScoreWithScores 一样，只是返回结果为降序排序
     \*
     \* @param key 缓存键
     \* @param min 最小分数
     \* @param max 最大分数
     \* @return 指定分数范围的元素元组集合
     \*/
    Set<Tuple\> zrevrangeByScoreWithScores(String key, String max, String min);

    /\*\*
     \* 机制与 zrangeByScoreWithScores 一样，只是返回结果为降序排序
     \*
     \* @param key    缓存键
     \* @param min    最小分数
     \* @param max    最大分数
     \* @param offset 偏移量
     \* @param count  数量
     \* @return 指定分数范围的元素元组集合
     \*/
    Set<Tuple\> zrevrangeByScoreWithScores(String key, double max, double min, int offset, int count);

    /\*\*
     \* 机制与 zrangeByScoreWithScores 一样，只是返回结果为降序排序
     \*
     \* @param key    缓存键
     \* @param min    最小分数
     \* @param max    最大分数
     \* @param offset 偏移量
     \* @param count  数量
     \* @return 指定分数范围的元素元组集合
     \*/
    Set<Tuple\> zrevrangeByScoreWithScores(String key, String max, String min, int offset, int count);

    /\*\*
     \* 移除有序集 key 中，指定排名(rank)区间内的所有成员
     \* 下标参数 start 和 stop 都以 0 为底，0 处是分数最小的那个元素
     \* 这些索引也可是负数，表示位移从最高分处开始数
     \* 例如，-1 是分数最高的元素，-2 是分数第二高的，依次类推
     \*
     \* @param key   缓存键
     \* @param start 起始分数
     \* @param end   结束分数
     \* @return 被移除成员的数量
     \*/
    Long zremrangeByRank(String key, long start, long end);

    /\*\*
     \* 移除有序集 key 中，所有 score 值介于 start 和 end 之间(包括等于 start 或 end)的成员
     \* <p>
     \* 自版本2.1.6开始，score 值等于 start 或 end 的成员也可以不包括在内，语法请参见 ZRANGEBYSCORE 命令
     \*
     \* @param key   缓存键
     \* @param start 起始分数
     \* @param end   结束分数
     \* @return 删除的元素的个数
     \*/
    Long zremrangeByScore(String key, double start, double end);

    /\*\*
     \* 移除有序集 key 中，所有 score 值介于 start 和 end 之间(包括等于 start 或 end)的成员
     \* <p>
     \* 自版本2.1.6开始，score 值等于 start 或 end 的成员也可以不包括在内，语法请参见 ZRANGEBYSCORE 命令
     \*
     \* @param key   缓存键
     \* @param start 起始分数
     \* @param end   结束分数
     \* @return 删除的元素的个数
     \*/
    Long zremrangeByScore(String key, String start, String end);

    /\*\*
     \* 当插入到有序集合中的元素都具有相同的分数时，这个命令可以返回 min 和 max 指定范围内的元素的数量
     \*
     \* @param key 缓存键
     \* @param min 最小分数
     \* @param max 最大分数
     \* @return
     \*/
    Long zlexcount(final String key, final String min, final String max);

    /\*\*
     \* 把 value 插入存于 key 的列表中在基准值 pivot 的前面或后面
     \* 当 key 不存在时，这个 list 会被看作是空 list，任何操作都不会发生
     \* 当 key 存在，但保存的不是一个 list 的时候，会返回错误
     \*
     \* @param key   缓存键
     \* @param where 位置
     \* @param pivot 前或后
     \* @param value 值
     \* @return 在 insert 操作后的 list 长度。
     \*/
    Long linsert(String key, Client.LIST\_POSITION where, String pivot, String value);

    /\*\*
     \* 只有当 key 已经存在并且存着一个 list 的时候，在这个 key 下面的 list 的头部插入 value
     \* 与 LPUSH 相反，当 key 不存在的时候不会进行任何操作
     \*
     \* @param key    缓存键
     \* @param string 待处理字符串
     \* @return 在 push 操作后的 list 长度
     \*/
    Long lpushx(String key, String... string);

    /\*\*
     \* 将值 value 插入到列表 key 的表尾，当且仅当 key 存在并且是一个列表
     \* 和 RPUSH 命令相反, 当 key 不存在时，RPUSHX 命令什么也不做
     \*
     \* @param key    缓存键
     \* @param string 待处理字符串
     \* @return 在 push 操作后 list 的长度
     \*/
    Long rpushx(String key, String... string);

    /\*\*
     \* @deprecated 不可用命令，将在 3.0.0 版本中移除
     \*/
    @Deprecated
    List<String\> blpop(String arg);

    /\*\*
     \* BLPOP 是阻塞式列表的弹出原语
     \* 它是命令 LPOP 的阻塞版本，这是因为当给定列表内没有任何元素可供弹出的时候，
     \* 连接将被 BLPOP 命令阻塞。 当给定多个 key 参数时，按参数 key 的先后顺序依次检查各个列表，弹出第一个非空列表的头元素
     \* {@link http://www.redis.cn/commands/blpop.html}
     \*
     \* @param timeout 超时时间
     \* @param key     缓存键
     \* @return
     \*/
    List<String\> blpop(int timeout, String key);

    /\*\*
     \* @deprecated 不可用命令，将在 3.0.0 版本中移除
     \*/
    @Deprecated
    List<String\> brpop(String arg);

    /\*\*
     \* BRPOP 是一个阻塞的列表弹出原语
     \* 它是 RPOP 的阻塞版本，因为这个命令会在给定 list 无法弹出任何元素的时候阻塞连接
     \* 该命令会按照给出的 key 顺序查看 list，并在找到的第一个非空 list 的尾部弹出一个元素
     \* <p>
     \* 请在 BLPOP 文档 中查看该命令的准确语义，因为 BRPOP 和 BLPOP 基本是完全一样的，
     \* 除了它们一个是从尾部弹出元素，而另一个是从头部弹出元素。
     \* {@link http://www.redis.cn/commands/brpop.html}
     \*
     \* @param timeout 超时时间
     \* @param key     缓存键
     \* @return
     \*/
    List<String\> brpop(int timeout, String key);

    /\*\*
     \* 删除一个 key,如果删除的 key 不存在，则直接忽略
     \*
     \* @param key 缓存键
     \* @return 被删除的 key 的数量
     \*/
    Long del(String key);

    /\*\*
     \* 回显
     \*
     \* @param string 输入字符串
     \* @return 回显输入的字符串
     \*/
    String echo(String string);

    /\*\*
     \* 将当前数据库的 key 移动到给定的数据库 db 当中
     \* <p>
     \* 如果当前数据库(源数据库)和给定数据库(目标数据库)有相同名字的给定 key
     \* 或者 key 不存在于当前数据库，那么 MOVE 没有任何效果
     \* <p>
     \* 因此，也可以利用这一特性，将 MOVE 当作锁原语
     \*
     \* @param key     缓存键
     \* @param dbIndex 数据库索引
     \* @return 移动成功返回 1 失败则返回 0
     \*/
    Long move(String key, int dbIndex);

    /\*\*
     \* 统计字符串的字节数
     \*
     \* @param key 缓存键
     \* @return 字节数
     \*/
    Long bitcount(final String key);

    /\*\*
     \* 统计字符串指定起始位置的字节数
     \*
     \* @param key   缓存键
     \* @param start 起始索引
     \* @param end   结束索引
     \* @return
     \*/
    Long bitcount(final String key, long start, long end);

    /\*\*
     \* 迭代 hash 里面的元素
     \*
     \* @param key    缓存键
     \* @param cursor 游标
     \* @return
     \*/
    ScanResult<Map.Entry<String, String\>> hscan(final String key, final String cursor);

    /\*\*
     \* 迭代 set 里面的元素
     \*
     \* @param key    缓存键
     \* @param cursor 游标
     \* @return
     \*/
    ScanResult<String\> sscan(final String key, final String cursor);

    /\*\*
     \* 迭代 zset 里面的元素
     \*
     \* @param key    缓存键
     \* @param cursor 游标
     \* @return
     \*/
    ScanResult<Tuple\> zscan(final String key, final String cursor);
}

原创声明，本文系作者授权云+社区发表，未经许可，不得转载。

如有侵权，请联系 yunjia\_community@tencent.com 删除。

[[# | 展开阅读全文]]

[[# | 举报]]

### 我来说两句

0 条评论

[[# | 登录]] 后参与评论

    Created at: 2020-09-01T16:03:29+08:00
    Updated at: 2020-09-01T16:03:29+08:00


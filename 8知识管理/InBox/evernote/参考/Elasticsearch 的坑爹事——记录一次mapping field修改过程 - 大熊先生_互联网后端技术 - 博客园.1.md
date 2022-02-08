
<https://www.cnblogs.com/Creator/>

# [大熊先生| 关注互联网后端技术](https://www.cnblogs.com/Creator/)

*   [首页](https://www.cnblogs.com/Creator/)

*   [联系](https://msg.cnblogs.com/send/%E5%A4%A7%E7%86%8A%E5%85%88%E7%94%9F%7C%E4%BA%92%E8%81%94%E7%BD%91%E5%90%8E%E7%AB%AF%E6%8A%80%E6%9C%AF)
*   [订阅](https://www.cnblogs.com/Creator/rss/)
*   [管理](https://i.cnblogs.com/)

随笔 - 82 文章 - 0 评论 - 618

# [Elasticsearch 的坑爹事——记录一次mapping field修改过程](https://www.cnblogs.com/Creator/p/3722408.html)

Elasticsearch 的坑爹事 

本文记录一次Elasticsearch mapping field修改过程
团队使用Elasticsearch做日志的分类检索分析服务,使用了类似如下的\_mapping

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14 | `{`<br> `"settings"` `: {`<br> `"number_of_shards"` `: 20`<br> `},`<br> `"mappings"` `: {`<br> `"client"` `: {`<br> `"properties"` `: {`<br> `"ip"` `: {`<br> `"type"` `:` `"long"`<br> `},`<br> `"cost"` `: {`<br> `"type"` `:` `"long"`<br> `},`<br>`}` |

 
现在问题来了,日志中输出的"127.0.0.1"这类的IP地址在Elasticsearch中是不能转化为long的(报错Java.lang.NumberFormatException)，所以我们必须将字段改为string型或者ip型(Elasticsearch支持， 数据类型可见[mapping-core-types](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/mapping-core-types.html))才能达到理想的效果.
目标明确了，就是改掉mapping的ip的field type即可.
elasticsearch.org找了一圈 嘿嘿, update一下即可

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8 | `curl -XPUT localhost:8301/store/client/_mapping -d '`<br>`{`<br> `"client"` `: {`<br> `"properties"` `: {`<br> `"local_ip"` `: {``"type"` `:` `"string"``,` `"store"` `:` `"yes"``}` <br> `}`<br> `}`<br>`}` |

报错结果

|     |     |
| --- | --- |
| 1   | `{``"error"``:``"MergeMappingException[Merge failed with failures {[mapper [local_ip] of different type, current_type [long], merged_type [string]]}]"``,``"status"``:400}` |

尼玛 真逗  我long想转一下string 居然失败（elasticsearch产品层面理应支持这种无损转化）  无果
Google了一下类似的案例 ([案例](http://elasticsearch-users.115913.n3.nabble.com/Update-mapping-td3952162.html))
在一个帖子中得到的elasticsearch开发人员的准确答复

　　"You can't change existing mapping type, you need to create a new index with the correct mapping and index the data again."
想想 略坑啊 我不管是因为elasticsearch还是因为底层Lucene的原因，修改一个field需要对所有已有数据的所有field进行reindex，这本身就是一个逆天的思路，但是elasticsearch的研发人员还觉得这没有什么不合理的.
在Elasticsearch上游逛了一圈，上面这样写到
(http://www.elasticsearch.org/blog/changing-mapping-with-zero-downtime/)
the problem — why you can’t change mappings
You can only find that which is stored in your index. In order to make your data searchable, your database needs to know what type of data each field contains and how it should be indexed. If you switch a field type from e.g. a string to a date, all of the data for that field that you already have indexed becomes useless. One way or another, you need to reindex that field.
...
OK，这一段话很合理，我改了一个field的类型 需要对这个field进行reindex，如论哪种数据库都需要这么做，没错.
我们再继续往下看看，reindexing your data, 尼玛一看，弱爆了，他的reindexing your data不是对修改的filed进行reindex，而是创建了一个新的index，对所有的filed进行reindexing, 太逆天了。
吐槽归吐槽，这个事情逃不了，那我就按他的来吧.
首先创建一个新的索引

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15 | `curl -XPUT localhost:8305/store_v2 -d '`<br>`{`<br> `"settings"` `: {`<br> `"number_of_shards"` `: 20`<br> `},`<br> `"mappings"` `: {`<br> `"client"` `: {`<br> `"properties"` `: {`<br> `"ip"` `: {`<br> `"type"` `:` `"string"`<br> `},`<br> `"cost"` `: {`<br> `"type"` `:` `"long"`<br> `},`<br>`}` |

等等，我创建了新索引,client往Elasticsearch的代码不会需要修改吧，瞅了一眼，有解决方案，建立一个alias（别名，和C++引用差不多），通过alias来实现对后面索引数据的解耦合，看到这，舒了一口气。
现在的问题是 这是一个线上服务，不能停服务，所以我需要一个倒数据到我的新索引的一个方案
Elasticsearch官网写到
　　pull the documents in from your old index, using a scrolled search and index them into the new index using the bulk API. Many of the client APIs provide a reindex() method which will do all of this for you. Once you are done, you can delete the old index.
第一句，看起来很美好，找了一圈，尼玛无图无真相，Google都没有例子，你让我怎么导数据？
第二句 client APIS, 看起来只有这个方法可搞了
python用起来比较熟，所以我就直接选 pyes了，装了一大堆破依赖库之后，终于可以run起来了

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8 | `import pyes`<br>`conn = pyes.es.ES(``"http://10.xx.xx.xx:8305/"``)`<br>`search = pyes.query.MatchAllQuery().search(bulk_read=1000)`<br>`hits = conn.search(search,` `'store_v1'``,` `'client'``, scan=True, scroll=``"30m"``, model=lambda _,hit: hit)`<br>`for` `hit` `in` `hits:`<br> `#print hit`<br> `conn.index(hit[``'_source'``],` `'store_v2'``,` `'client'``, hit[``'_id'``], bulk=True)`<br>`conn.flush()` |

 
花了大概一个多小时，新的索引基本和老索引数据一致了，对于线上完成瞬间的增量，这里没心思关注了，数据准确性要求没那么高，得过且过。
接下来修改alias别名的指向（如果你之前没有用alias来改mapping,纳尼就等着哭吧）

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14 | `curl -XPOST localhost:8305/_aliases -d '`<br>`{`<br> `"actions"``: [`<br> `{` `"remove"``: {`<br> `"alias"``:` `"store"``,`<br> `"index"``:` `"store_v1"`<br> `}},`<br> `{` `"add"``: {`<br> `"alias"``:` `"store"``,`<br> `"index"``:` `"store_v2"`<br> `}}`<br> `]`<br>`}`<br>`'` |

 
啷啷锵锵，正在追数据中

![[8知识管理/InBox/evernote/参考/_resources/Elasticsearch_的坑爹事——记录一次mapping_field修改过程_-_大熊先生_互联网后端技术_-_博客园.1.resources/112212593384735.png]]

等新索引的数据已经追上时

将老的索引删掉

|     |     |
| --- | --- |
| 1   | `curl -XDELETE localhost:8303/store_v1` |

至此完成！

一件如此简单的事情，Elasticsearch居然能让他变得如此复杂，真是牛逼啊...

* * *

**博客地址：**[**Zealot Yin**](http://www.cnblogs.com/creator)

****欢迎转载，转载请注明出处**\[**[**http://creator.cnblogs.com/**](http://creator.cnblogs.com/)**\]******

分类: [业务场景](https://www.cnblogs.com/Creator/category/309758.html), [调试](https://www.cnblogs.com/Creator/category/584336.html)
标签: [Elasticsearch](https://www.cnblogs.com/Creator/tag/Elasticsearch/)

[[# | 好文要顶]] [[# | 关注我]] [[# | 收藏该文]] [[# | ![[8知识管理/InBox/evernote/参考/_resources/Elasticsearch_的坑爹事——记录一次mapping_field修改过程_-_大熊先生_互联网后端技术_-_博客园.1.resources/icon_weibo_24.png]]]] [[# | ![[8知识管理/InBox/evernote/参考/_resources/Elasticsearch_的坑爹事——记录一次mapping_field修改过程_-_大熊先生_互联网后端技术_-_博客园.1.resources/wechat.png]]]]

[![[8知识管理/InBox/evernote/参考/_resources/Elasticsearch_的坑爹事——记录一次mapping_field修改过程_-_大熊先生_互联网后端技术_-_博客园.1.resources/u119471.gif]]](https://home.cnblogs.com/u/Creator/)
[大熊先生|互联网后端技术](https://home.cnblogs.com/u/Creator/)
[关注 - 53](https://home.cnblogs.com/u/Creator/followees/)
[粉丝 - 563](https://home.cnblogs.com/u/Creator/followers/)

推荐博客
[[# | +加关注]]

5
2

[«](https://www.cnblogs.com/Creator/p/3690180.html) 上一篇： [创业公司招php商城开发者](https://www.cnblogs.com/Creator/p/3690180.html)
[»](https://www.cnblogs.com/Creator/p/3762315.html) 下一篇： [分布式系统设计权衡之CAP](https://www.cnblogs.com/Creator/p/3762315.html)

posted @ 2014-05-11 22:17  [大熊先生|互联网后端技术](https://www.cnblogs.com/Creator/)  阅读(89689)  评论(11)  [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=3722408)  [[# | 收藏]]

评论列表

[#evernote](https://www.cnblogs.com/Creator/p/3722408.html#2943291) \[楼主\] 2014-05-21 12:13 [大熊先生|互联网后端技术](https://www.cnblogs.com/Creator/)
			
再补充一个坑爹的case
如果你之前没有设置\_ttl ,现在PUT mapping设置一下，只会对新数据进行过期，老的数据是不会应用这个规则的
[[# | 支持(0)]] [[# | 反对(0)]]

[#evernote](https://www.cnblogs.com/Creator/p/3722408.html#2947016) \[楼主\] 2014-05-24 10:14 [大熊先生|互联网后端技术](https://www.cnblogs.com/Creator/)
			
再补充一种方法 不过未经试验 谨慎使用
"ignore\_malformed": true,
<https://groups.google.com/forum/#!topic/elasticsearch/itYOhO1dIEw>
[[# | 支持(0)]] [[# | 反对(0)]]

[#evernote](https://www.cnblogs.com/Creator/p/3722408.html#3012239) 2014-08-20 13:58 [规格严格-功夫到家](https://www.cnblogs.com/diyunpeng/)
			
写的很好啊。~
[[# | 支持(0)]] [[# | 反对(0)]]

[#evernote](https://www.cnblogs.com/Creator/p/3722408.html#3079375) 2014-12-05 17:42 [Galen\_Z](https://www.cnblogs.com/Galen-Z/)
			
我想说的是，我也遇到了和你类似的情况，比如有一个字段是一个URI，es自动以/ 这个字符把整个URI给拆分成一个一个的小节，后来去修改mapping，无果，网上查，也是说没办法改，只能建立一个新的mapping，然后将数据迁移进去。
[[# | 支持(0)]] [[# | 反对(0)]]

[#evernote](https://www.cnblogs.com/Creator/p/3722408.html#3079378) 2014-12-05 17:44 [Galen\_Z](https://www.cnblogs.com/Galen-Z/)
			
我个人觉得ES这个地方做得真的有点不 太灵活。
[[# | 支持(0)]] [[# | 反对(0)]]

[#evernote](https://www.cnblogs.com/Creator/p/3722408.html#3119418) 2015-01-30 10:11 [游子善心](https://www.cnblogs.com/zhouyou/)
			
[@](https://www.cnblogs.com/Creator/p/3722408.html#3079375) Galen\_Z
兄弟 你好。我想问下，由于建Mapping的时候，不小心设定了不分词，几亿的数据已经导入了，现在需要修改怎么办了？新建一个maping 两个mapping之间能否数据转移？
[[# | 支持(4)]] [[# | 反对(0)]]

[#evernote](https://www.cnblogs.com/Creator/p/3722408.html#3160917) 2015-04-12 15:26 [tgis](https://www.cnblogs.com/tgis/)
			
使用之前要详细阅读手册，一知半解就动手，必然会反反复复。如果你自己考虑一下如何实现一个搜索引擎就不会这么吐糟了。
[[# | 支持(3)]] [[# | 反对(1)]]

[#evernote](https://www.cnblogs.com/Creator/p/3722408.html#3337324) 2015-12-29 17:46 [高少](https://home.cnblogs.com/u/675943/)
			
感谢大熊,很实用!
[[# | 支持(0)]] [[# | 反对(0)]]

[#evernote](https://www.cnblogs.com/Creator/p/3722408.html#3516359) 2016-09-21 18:20 [天涯逐梦](https://www.cnblogs.com/huanxiyun/)
			
新建索引之前，不是导过数据了嘛，为什么还有追数据这一说法
[[# | 支持(0)]] [[# | 反对(0)]]

[#evernote](https://www.cnblogs.com/Creator/p/3722408.html#3528378) 2016-10-11 17:28 [angelmom](https://home.cnblogs.com/u/801996/)
			
我想说，楼主，你索引的分片分布我看的也是醉了
[[# | 支持(0)]] [[# | 反对(0)]]

[#evernote](https://www.cnblogs.com/Creator/p/3722408.html#3982196) 2018-05-25 16:00 [wonderomg](https://www.cnblogs.com/liuzhilong/)
			
确实，创建索引的时候一定要设置好别名，才能不停服平滑地切换索引
curl -XPOST localhost:9200/\_aliases -d '
{
"actions": \[
{ "add": {
"alias": "my\_index",
"index": "my\_index\_v1"
}}
\]
}'
[[# | 支持(0)]] [[# | 反对(0)]]

[[# | 刷新评论]][刷新页面](https://www.cnblogs.com/Creator/p/3722408.html#)[返回顶部](https://www.cnblogs.com/Creator/p/3722408.html#top)

注册用户登录后才能发表评论，请 [[# | 登录]] 或 [[# | 注册]]， [访问](https://www.cnblogs.com/) 网站首页。

[【推荐】超50万行VC++源码: 大型组态工控、电力仿真CAD与GIS源码库](http://www.ucancode.com/index.htm)
[【推荐】合辑 | 学习python不可不知的开发者词条汇总！](https://developer.aliyun.com/article/744375?utm_content=g_1000104137)
[【推荐】96秒100亿！哪些“黑科技”支撑全球最大流量洪峰？](https://developer.aliyun.com/article/726591?utm_content=g_1000088942)

**相关博文：**
· [ELK学习总结（4-1）elasticsearch更改mapping(不停服务重建索引)](https://www.cnblogs.com/lexiaofei/p/6655343.html)
· [elasticsearch的mapping映射](https://www.cnblogs.com/klsw/p/5567465.html)
· [ElasticSearch踩坑记录](https://www.cnblogs.com/janes/p/8796516.html)
· [Elasticsearch 搜索不到数据问题（\_mapping 设置）](https://www.cnblogs.com/licongyu/p/5315700.html)
· [ES12-配置使用Elasticsearch的动态映射（dynamicmapping）](https://www.cnblogs.com/shoufeng/p/10655797.html)
» [更多推荐...](https://recomm.cnblogs.com/blogpost/3722408)
[开放下载！《阿里巴巴大数据及AI实战》深度解析典型场景实践](https://developer.aliyun.com/article/741282?utm_content=g_1000104141)

**最新 IT 新闻**:
· [福州给盒马又上了一课](https://news.cnblogs.com/n/661627/)
· [车载大屏就只是一个摆设吗？](https://news.cnblogs.com/n/661626/)
· [PS4国区商店关闭，玩家“邀功”举报成功：真是这样么？](https://news.cnblogs.com/n/661625/)
· [是的，GuiLite 收费了](https://news.cnblogs.com/n/661624/)
· [科学家解释北磁极漂移原因](https://news.cnblogs.com/n/661623/)
» [更多新闻...](https://news.cnblogs.com/)

### 公告

鄙人中文名：大熊（先生）

* * *

[![[8知识管理/InBox/evernote/参考/_resources/Elasticsearch_的坑爹事——记录一次mapping_field修改过程_-_大熊先生_互联网后端技术_-_博客园.1.resources/1.2.png]]](http://weibo.com/u/2139273303?s=6uyXnP)  

**微信：** 

![[8知识管理/InBox/evernote/参考/_resources/Elasticsearch_的坑爹事——记录一次mapping_field修改过程_-_大熊先生_互联网后端技术_-_博客园.1.resources/119471-20160303211741784-676532088.jpg]]

前百度研发

混迹于互联网行业的后端码农

关注高并发，分布式 ，海量数据处理等Topic

低谷积累，高峰爆发！

Email：[zealotyin@qq.com](https://www.cnblogs.com/Creator/p/3722408.htmlmailto:zealotyin@hotmail.com)

熟悉C,C++,C# 

热爱算法，数据结构

崇尚简单，快乐 

喜欢尝试新技术,不愿墨守成规的技术狂热者**.**
**\----------推荐阅读---------**
[Google C++ 风格指南](http://hxraid.iteye.com/blog/614070)

[从B树、B+树、B\*树谈到R 树](http://blog.csdn.net/v_july_v/article/details/6530142)

**\---------------------------**

昵称： [大熊先生|互联网后端技术](https://home.cnblogs.com/u/Creator/)
园龄： [10年1个月](https://home.cnblogs.com/u/Creator/)
荣誉： [推荐博客](https://www.cnblogs.com/expert/)
粉丝： [563](https://home.cnblogs.com/u/Creator/followers/)
关注： [53](https://home.cnblogs.com/u/Creator/followees/)
[[# | +加关注]]

### 随笔分类 (123)

*   [C#/.Net(14)](https://www.cnblogs.com/Creator/category/584342.html)
*   [C++(16)](https://www.cnblogs.com/Creator/category/368357.html)
*   [Freamework(7)](https://www.cnblogs.com/Creator/category/288841.html)
*   [MongoDB(4)](https://www.cnblogs.com/Creator/category/369618.html)
*   [MS信息化(sharepoint|Office)(27)](https://www.cnblogs.com/Creator/category/288835.html)
*   [professional(7)](https://www.cnblogs.com/Creator/category/288840.html)
*   [UI/JS/HTML(1)](https://www.cnblogs.com/Creator/category/584343.html)
*   [Unix/Linux(7)](https://www.cnblogs.com/Creator/category/369619.html)
*   [产品(1)](https://www.cnblogs.com/Creator/category/1006773.html)
*   [调试(8)](https://www.cnblogs.com/Creator/category/584336.html)
*   [基础技术(8)](https://www.cnblogs.com/Creator/category/584340.html)
*   [架构设计(5)](https://www.cnblogs.com/Creator/category/584334.html)
*   [算法系列(9)](https://www.cnblogs.com/Creator/category/299831.html)
*   [业务场景(6)](https://www.cnblogs.com/Creator/category/309758.html)
*   [招聘面试(3)](https://www.cnblogs.com/Creator/category/584339.html)

### 阅读排行榜

*   [1\. Elasticsearch 的坑爹事——记录一次mapping field修改过程(89689)](https://www.cnblogs.com/Creator/p/3722408.html)
*   [2\. 如何正确的终止正在运行的子线程(28190)](https://www.cnblogs.com/Creator/archive/2012/03/21/2408413.html)
*   [3\. Mysql在大型网站的应用架构演变(23664)](https://www.cnblogs.com/Creator/p/3776110.html)
*   [4\. HTTP文件断点续传的原理(22976)](https://www.cnblogs.com/Creator/p/5490929.html)
*   [5\. 算法系列总结：分而治之——分治算法(20211)](https://www.cnblogs.com/Creator/archive/2011/06/18/2084267.html)
*   [6\. APP热更新方案(17609)](https://www.cnblogs.com/Creator/p/7007694.html)
*   [7\. 如何实现文件增量同步——算法(15310)](https://www.cnblogs.com/Creator/archive/2012/03/30/2426070.html)
*   [8\. 探究操作系统的内存分配（malloc）对齐策略(12622)](https://www.cnblogs.com/Creator/archive/2012/04/05/2433386.html)
*   [9\. 基础算法系列总结：回溯算法（解火力网问题）(11937)](https://www.cnblogs.com/Creator/archive/2011/05/20/2052341.html)
*   [10\. 用.net自己动手开发【操作系统】(11235)](https://www.cnblogs.com/Creator/archive/2011/06/09/2076315.html)
*   [11\. .net研发工程师面试题，在线交流答案(9731)](https://www.cnblogs.com/Creator/archive/2011/06/07/2074607.html)
*   [12\. failover机制的小讨论(9254)](https://www.cnblogs.com/Creator/p/3189758.html)
*   [13\. C/C++ 字符串模糊匹配(9141)](https://www.cnblogs.com/Creator/archive/2013/03/25/2981186.html)
*   [14\. MongoDB源码概述——内存管理和存储引擎(9127)](https://www.cnblogs.com/Creator/archive/2012/11/04/2754110.html)
*   [15\. 使用VS开发基于Oracle程序的严重问题(8808)](https://www.cnblogs.com/Creator/archive/2010/11/26/1885657.html)

### 评论排行榜

*   [1\. .net研发工程师面试题，在线交流答案(132)](https://www.cnblogs.com/Creator/archive/2011/06/07/2074607.html)
*   [2\. 用.net自己动手开发【操作系统】(96)](https://www.cnblogs.com/Creator/archive/2011/06/09/2076315.html)
*   [3\. 我为什么经常加班到深夜(62)](https://www.cnblogs.com/Creator/p/5246824.html)
*   [4\. 装箱和拆箱 深度理解(38)](https://www.cnblogs.com/Creator/archive/2011/03/20/1989220.html)
*   [5\. 算法系列总结：分而治之——分治算法(21)](https://www.cnblogs.com/Creator/archive/2011/06/18/2084267.html)
*   [6\. WebService的安全性讨论【身份识别】(20)](https://www.cnblogs.com/Creator/archive/2011/03/23/1992019.html)
*   [7\. 内存池技术畅想(19)](https://www.cnblogs.com/Creator/archive/2012/04/11/2430592.html)
*   [8\. 基础算法系列总结：贪心算法(17)](https://www.cnblogs.com/Creator/archive/2011/06/07/2074227.html)
*   [9\. 抛弃ConfigurationManager , 实现面向对象读写配置文件(16)](https://www.cnblogs.com/Creator/archive/2010/10/26/1861509.html)
*   [10\. 离线应用——业务数据同步方案探讨(15)](https://www.cnblogs.com/Creator/archive/2011/07/13/2105477.html)

Copyright © 2020 大熊先生|互联网后端技术
Powered by .NET Core on Kubernetes

    Created at: 2020-05-11T10:41:13+08:00
    Updated at: 2020-05-11T10:41:13+08:00


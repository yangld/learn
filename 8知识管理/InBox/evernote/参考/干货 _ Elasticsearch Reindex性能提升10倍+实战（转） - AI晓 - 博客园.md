
[![[logo.gif]]](https://www.cnblogs.com/libin2015/)

# [AI晓](https://www.cnblogs.com/libin2015/)

*   [博客园](https://www.cnblogs.com/)
*   [首页](https://www.cnblogs.com/libin2015/)
*   [新随笔](https://i.cnblogs.com/EditPosts.aspx?opt=1)
*   [联系](https://msg.cnblogs.com/send/AI%E6%99%93)
*   [订阅](https://www.cnblogs.com/libin2015/rss/)
*   [管理](https://i.cnblogs.com/)

随笔 - 63 文章 - 0 评论 - 0

# [干货 | Elasticsearch Reindex性能提升10倍+实战（转）](https://www.cnblogs.com/libin2015/p/10411546.html)

_转自 [ https://blog.csdn.net/laoyang360/article/details/81589459](https://blog.csdn.net/laoyang360/article/details/81589459)_

1、reindex的速率极慢，是否有办法改善？
以下问题来自社区：https://elasticsearch.cn/question/3782

问题1：reindex和snapshot的速率极慢，是否有办法改善？
reindex和snapshot的速率比用filebeat或者kafka到es的写入速率慢好几个数量级（集群写入性能不存在瓶颈），reindex/snapshot的时候CPU还是IO使用率都很低，是不是集群受什么参数限制了reindex和snapshot的速率？
reindex不管是跨集群还是同集群上都很慢，大约3~5M/s的索引速率，会是什么原因导致的？

问题2：数据量几十个G的场景下，elasticsearch reindex速度太慢，从旧索引导数据到新索引，当前最佳方案是什么？
2、Reindex简介
5.X版本后新增Reindex。Reindex可以直接在Elasticsearch集群里面对数据进行重建，如果你的mapping因为修改而需要重建，又或者索引设置修改需要重建的时候，借助Reindex可以很方便的异步进行重建，并且支持跨集群间的数据迁移。比如按天创建的索引可以定期重建合并到以月为单位的索引里面去。当然索引里面要启用\_source。

POST \_reindex
{
"source": {
"index": "twitter"
},
"dest": {
"index": "new\_twitter"
}
}
3、原因分析
reindex的核心做跨索引、跨集群的数据迁移。
慢的原因及优化思路无非包括：

1）批量大小值可能太小。
需要结合堆内存、线程池调整大小；
2）reindex的底层是scroll实现，借助scroll并行优化方式，提升效率；
3）跨索引、跨集群的核心是写入数据，考虑写入优化角度提升效率。
4、Reindex提升迁移效率的方案
4.1 提升批量写入大小值
默认情况下，\_reindex使用1000进行批量操作，您可以在source中调整batch\_size。

POST \_reindex
{
"source": {
"index": "source",
"size": 5000
},
"dest": {
"index": "dest",
"routing": "=cat"
}
}
批量大小设置的依据：

（1）使用批量索引请求以获得最佳性能。
批量大小取决于数据、分析和集群配置，但一个好的起点是每批处理5-15 MB。
注意，这是物理大小。文档数量不是度量批量大小的好指标。例如，如果每批索引1000个文档，:
1）每个1kb的1000个文档是1mb。
2）每个100kb的1000个文档是100 MB。
这些是完全不同的体积大小。
（2）逐步递增文档容量大小的方式调优。
1）从大约5-15 MB的大容量开始，慢慢增加，直到你看不到性能的提升。然后开始增加批量写入的并发性(多线程等等)。
2）使用kibana、cerebro或iostat、top和ps等工具监视节点，以查看资源何时开始出现瓶颈。如果您开始接收EsRejectedExecutionException，您的集群就不能再跟上了:至少有一个资源达到了容量。要么减少并发性，或者提供更多有限的资源(例如从机械硬盘切换到ssd固态硬盘)，要么添加更多节点。
4.2 借助scroll的sliced提升写入效率
Reindex支持Sliced Scroll以并行化重建索引过程。 这种并行化可以提高效率，并提供一种方便的方法将请求分解为更小的部分。

sliced原理（from medcl）
1）用过Scroll接口吧，很慢？如果你数据量很大，用Scroll遍历数据那确实是接受不了，现在Scroll接口可以并发来进行数据遍历了。
2）每个Scroll请求，可以分成多个Slice请求，可以理解为切片，各Slice独立并行，利用Scroll重建或者遍历要快很多倍。

slicing使用举例
slicing的设定分为两种方式：手动设置分片、自动设置分片。
手动设置分片参见官网。
自动设置分片如下：

POST \_reindex?slices=5&refresh
{
"source": {
"index": "twitter"
},
"dest": {
"index": "new\_twitter"
}
}
slices大小设置注意事项：
1）slices大小的设置可以手动指定，或者设置slices设置为auto，auto的含义是：针对单索引，slices大小=分片数；针对多索引，slices=分片的最小值。
2）当slices的数量等于索引中的分片数量时，查询性能最高效。slices大小大于分片数，非但不会提升效率，反而会增加开销。
3）如果这个slices数字很大(例如500)，建议选择一个较低的数字，因为过大的slices 会影响性能。

4.3 ES副本数设置为0
如果要进行大量批量导入，请考虑通过设置index.number\_of\_replicas来禁用副本：0。
主要原因在于：复制文档时，将整个文档发送到副本节点，并逐字重复索引过程。 这意味着每个副本都将执行分析，索引和潜在合并过程。
相反，如果您使用零副本进行索引，然后在提取完成时启用副本，则恢复过程本质上是逐字节的网络传输。 这比复制索引过程更有效。

PUT /my\_logs/\_settings
{
"number\_of\_replicas": 1
}
4.4 增加refresh间隔
如果你的搜索结果不需要接近实时的准确性，考虑先不要急于索引刷新refresh。可以将每个索引的refresh\_interval到30s。
如果正在进行大量数据导入，可以通过在导入期间将此值设置为-1来禁用刷新。完成后不要忘记重新启用它!
设置方法：

PUT /my\_logs/\_settings
{ "refresh\_interval": -1 }
5、小结
实践证明，比默认设置reindex速度能提升10倍+。
遇到类似问题，多从官网、原理甚至源码的角度思考，逐步拆解分析。
只要思维不滑坡，办法总比问题多！

参考：
\[1\] Jest Reindex参考：http://t.cn/RDOyIc8
\[2\] 官网性能优化：http://t.cn/RDOyJqr
\[3\] 论坛讨论：http://t.cn/RDOya3a

\[4\] 官网reindex介绍： <https://www.elastic.co/guide/en/elasticsearch/reference/5.6/docs-reindex.html>
\---------------------
作者：铭毅天下（公众号同名）
来源：CSDN
原文：https://blog.csdn.net/laoyang360/article/details/81589459
版权声明：本文为博主原创文章，转载请附上博文链接！

分类: [Elastic Stack](https://www.cnblogs.com/libin2015/category/1165593.html)

[[# | 好文要顶]] [[# | 关注我]] [[# | 收藏该文]] [[# | ![[8知识管理/InBox/evernote/参考/_resources/干货___Elasticsearch_Reindex性能提升10倍+实战（转）_-_AI晓_-_博客园.resources/icon_weibo_24.png]]]] [[# | ![[8知识管理/InBox/evernote/参考/_resources/干货___Elasticsearch_Reindex性能提升10倍+实战（转）_-_AI晓_-_博客园.resources/wechat.png]]]]

[AI晓](https://home.cnblogs.com/u/libin2015/)
[关注 - 5](https://home.cnblogs.com/u/libin2015/followees/)
[粉丝 - 4](https://home.cnblogs.com/u/libin2015/followers/)

[[# | +加关注]]

0
0

[«](https://www.cnblogs.com/libin2015/p/10401585.html) 上一篇： [HBase 内部探险（转）](https://www.cnblogs.com/libin2015/p/10401585.html)
[»](https://www.cnblogs.com/libin2015/p/10371356.html) 下一篇： [Elasticsearch技术解析与实战-索引](https://www.cnblogs.com/libin2015/p/10371356.html)

posted @ 2019-02-21 11:54  [AI晓](https://www.cnblogs.com/libin2015/)  阅读(1275)  评论(0)  [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=10411546)  [[# | 收藏]]

[[# | 刷新评论]][刷新页面](https://www.cnblogs.com/libin2015/p/10411546.html#)[返回顶部](https://www.cnblogs.com/libin2015/p/10411546.html#top)

注册用户登录后才能发表评论，请 [[# | 登录]] 或 [[# | 注册]]， [访问](https://www.cnblogs.com/) 网站首页。

[【推荐】超50万行VC++源码: 大型组态工控、电力仿真CAD与GIS源码库](http://www.ucancode.com/index.htm)
[【推荐】精品问答：Java 技术 1000 问](https://developer.aliyun.com/ask/257905?utm_content=g_1000088947)
[【推荐】斩获阿里offer的必看12篇面试合辑](https://developer.aliyun.com/group/interview?utm_content=g_1000088932)

**相关博文：**
· [Elasticsearch\_reindexAlias使用](https://www.cnblogs.com/hyhy904/p/11098546.html)
· [ES数据库重建索引——Reindex(数据迁移)](https://www.cnblogs.com/Ace-suiyuan008/p/9985249.html)
· [让Elasticsearch飞起来!——性能优化实践干货](https://www.cnblogs.com/lonelyxmas/p/11612502.html)
· [ElasticSearch性能优化](https://www.cnblogs.com/smile361/p/9230995.html)
· [工作随笔—Elasticsearch大量数据提交优化](https://www.cnblogs.com/ZWOLF/p/10480403.html)
» [更多推荐...](https://recomm.cnblogs.com/blogpost/10411546)
[精品问答：微服务架构 Spring 核心知识 50 问](https://developer.aliyun.com/ask/257857?utm_content=g_1000088950)

**最新 IT 新闻**:
· [贫困人群可每年从京东领1000元购药补助](https://news.cnblogs.com/n/661530/)
· [马斯克访谈精华：巴菲特这样的人还是少些好 我有火星还要什么房子](https://news.cnblogs.com/n/661529/)
· [专访雷军：没有向死而生的勇气做不了金山云](https://news.cnblogs.com/n/661528/)
· [做直播带货被“坑”百万！深扒直播4大“割韭菜”套路](https://news.cnblogs.com/n/661527/)
· [悲凉魅族 落地无声](https://news.cnblogs.com/n/661526/)
» [更多新闻...](https://news.cnblogs.com/)

### 公告

昵称： [AI晓](https://home.cnblogs.com/u/libin2015/)
园龄： [4年6个月](https://home.cnblogs.com/u/libin2015/)
粉丝： [4](https://home.cnblogs.com/u/libin2015/followers/)
关注： [5](https://home.cnblogs.com/u/libin2015/followees/)
[[# | +加关注]]

|     |     |     |
| --- | --- | --- |
| [[# \| <]] | 2020年5月 | [[# \| \>]] |

日一二三四五六262728293012345678910111213141516171819202122232425262728293031123456

### 搜索

### 常用链接

*   [我的随笔](https://www.cnblogs.com/libin2015/p/)
*   [我的评论](https://www.cnblogs.com/libin2015/MyComments.html)
*   [我的参与](https://www.cnblogs.com/libin2015/OtherPosts.html)
*   [最新评论](https://www.cnblogs.com/libin2015/RecentComments.html)
*   [我的标签](https://www.cnblogs.com/libin2015/tag/)

### 随笔分类

*   [Elastic Stack(25)](https://www.cnblogs.com/libin2015/category/1165593.html)
*   [hbase(8)](https://www.cnblogs.com/libin2015/category/1216089.html)
*   [hive(3)](https://www.cnblogs.com/libin2015/category/1060470.html)
*   [java(5)](https://www.cnblogs.com/libin2015/category/1207717.html)
*   [kafka(1)](https://www.cnblogs.com/libin2015/category/1526851.html)
*   [linux(3)](https://www.cnblogs.com/libin2015/category/990983.html)
*   [python(1)](https://www.cnblogs.com/libin2015/category/1534745.html)
*   [scala(1)](https://www.cnblogs.com/libin2015/category/1051270.html)
*   [spark(9)](https://www.cnblogs.com/libin2015/category/991050.html)
*   [大数据(2)](https://www.cnblogs.com/libin2015/category/990982.html)
*   [算法与数据结构(4)](https://www.cnblogs.com/libin2015/category/990980.html)

### 随笔档案

*   [2020年4月(7)](https://www.cnblogs.com/libin2015/archive/2020/04.html)
*   [2020年3月(3)](https://www.cnblogs.com/libin2015/archive/2020/03.html)
*   [2019年12月(2)](https://www.cnblogs.com/libin2015/archive/2019/12.html)
*   [2019年10月(1)](https://www.cnblogs.com/libin2015/archive/2019/10.html)
*   [2019年8月(2)](https://www.cnblogs.com/libin2015/archive/2019/08.html)
*   [2019年7月(1)](https://www.cnblogs.com/libin2015/archive/2019/07.html)
*   [2019年4月(6)](https://www.cnblogs.com/libin2015/archive/2019/04.html)
*   [2019年3月(3)](https://www.cnblogs.com/libin2015/archive/2019/03.html)
*   [2019年2月(4)](https://www.cnblogs.com/libin2015/archive/2019/02.html)
*   [2018年9月(4)](https://www.cnblogs.com/libin2015/archive/2018/09.html)
*   [2018年8月(3)](https://www.cnblogs.com/libin2015/archive/2018/08.html)
*   [2018年7月(4)](https://www.cnblogs.com/libin2015/archive/2018/07.html)
*   [2018年5月(2)](https://www.cnblogs.com/libin2015/archive/2018/05.html)
*   [2018年4月(1)](https://www.cnblogs.com/libin2015/archive/2018/04.html)
*   [2018年2月(3)](https://www.cnblogs.com/libin2015/archive/2018/02.html)
*   [2017年12月(1)](https://www.cnblogs.com/libin2015/archive/2017/12.html)
*   [2017年8月(5)](https://www.cnblogs.com/libin2015/archive/2017/08.html)
*   [2017年7月(1)](https://www.cnblogs.com/libin2015/archive/2017/07.html)
*   [2017年6月(1)](https://www.cnblogs.com/libin2015/archive/2017/06.html)
*   [2017年5月(3)](https://www.cnblogs.com/libin2015/archive/2017/05.html)
*   [2017年4月(2)](https://www.cnblogs.com/libin2015/archive/2017/04.html)
*   [2016年2月(1)](https://www.cnblogs.com/libin2015/archive/2016/02.html)
*   [2015年12月(3)](https://www.cnblogs.com/libin2015/archive/2015/12.html)

### 阅读排行榜

*   [1\. Elasticsearch 日期时间处理(19412)](https://www.cnblogs.com/libin2015/p/9394995.html)
*   [2\. Elasticsearch模糊查询(11336)](https://www.cnblogs.com/libin2015/p/10510705.html)
*   [3\. spark idea项目打jar包的两种方式(5109)](https://www.cnblogs.com/libin2015/p/6963562.html)
*   [4\. Spark2.x 与 Spark1.x 关系(4479)](https://www.cnblogs.com/libin2015/p/7250046.html)
*   [5\. 创建DataFrame的两个途径(4011)](https://www.cnblogs.com/libin2015/p/6782667.html)

### 推荐排行榜

*   [1\. SparkStreaming 对Window的reduce的方法解析（转载）(1)](https://www.cnblogs.com/libin2015/p/6841177.html)

Copyright © 2020 AI晓
Powered by .NET Core on Kubernetes

    Created at: 2020-05-09T19:05:16+08:00
    Updated at: 2020-05-09T19:05:16+08:00


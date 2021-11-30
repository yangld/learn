
**请注意:**
本书基于 Elasticsearch 2.x 版本，有些内容可能已经过时。

[Elasticsearch: 权威指南](https://www.elastic.co/guide/cn/elasticsearch/guide/current/index.html) » [前言](https://www.elastic.co/guide/cn/elasticsearch/guide/current/preface.html) » 如何读这本书
[« Elasticsearch 版本](https://www.elastic.co/guide/cn/elasticsearch/guide/current/_elasticsearch_version.html) [本书导航 »](https://www.elastic.co/guide/cn/elasticsearch/guide/current/_navigating_this_book.html)

## <https://www.elastic.co/guide/cn/elasticsearch/guide/current/_how_to_read_this_book.html#_how_to_read_this_book>如何读这本书

Elasticsearch 做了很多努力和尝试来让复杂的事情变得简单，很大程度上来说 Elasticsearch 的成功来源于此。 换句话说，搜索以及分布式系统是非常复杂的，不过为了充分利用 Elasticsearch，迟早你也需要掌握它们。

恩，是有点复杂，但不是魔法。我们倾向于认为复杂系统如同神奇的黑盒子，能响应外部的咒语，但是通常里面的工作逻辑很简单。 理解了这些逻辑过程你就能驱散魔法，理解内在能够让你更加明确和清晰，而不是寄托于黑盒子做你想要做的。

这本权威指南不仅会帮助你学习 Elasticsearch，而且希望能够带你接触一些更深入、更有趣的话题，如 [_集群内的原理_](https://www.elastic.co/guide/cn/elasticsearch/guide/current/distributed-cluster.html) 、 [_分布式文档存储_](https://www.elastic.co/guide/cn/elasticsearch/guide/current/distributed-docs.html) 、 [_执行分布式检索_](https://www.elastic.co/guide/cn/elasticsearch/guide/current/distributed-search.html) 和 [_分片内部原理_](https://www.elastic.co/guide/cn/elasticsearch/guide/current/inside-a-shard.html) ，这些虽然不是必要的阅读却能让你深入理解其内在机制。

本书的第一部分应该按章节顺序阅读，因为每一章建立在上一章的基础上（尽管你也可以浏览刚才提到的章节）。 后续各章节如 [_近似匹配_](https://www.elastic.co/guide/cn/elasticsearch/guide/current/proximity-matching.html) 和 [_部分匹配_](https://www.elastic.co/guide/cn/elasticsearch/guide/current/partial-matching.html) 相对独立，你可以按需选择性参阅。

[« Elasticsearch 版本](https://www.elastic.co/guide/cn/elasticsearch/guide/current/_elasticsearch_version.html) [本书导航 »](https://www.elastic.co/guide/cn/elasticsearch/guide/current/_navigating_this_book.html)

# **跨集群复制(CCR)深度解析**

将数据从一个 Elasticsearch 集群原生复制到另一个 Elasticsearch 集群的功能是备受期待的功能，也是我们用户渴望已久的一项功能。
[马上观看](https://www.elastic.co/cn/webinars/cross-cluster-replication?baymax=rtp&elektra=docs&rogue=cn&iesrc=ctr)

*   [序言](https://www.elastic.co/guide/cn/elasticsearch/guide/current/foreword_id.html)
    *   [谁应该读这本书](https://www.elastic.co/guide/cn/elasticsearch/guide/current/_who_should_read_this_book.html)
    *   [为什么我们要写这本书](https://www.elastic.co/guide/cn/elasticsearch/guide/current/_why_we_wrote_this_book.html)
    *   [Elasticsearch 版本](https://www.elastic.co/guide/cn/elasticsearch/guide/current/_elasticsearch_version.html)
    *   [如何读这本书](https://www.elastic.co/guide/cn/elasticsearch/guide/current/_how_to_read_this_book.html)
    *   [本书导航](https://www.elastic.co/guide/cn/elasticsearch/guide/current/_navigating_this_book.html)
    *   [在线资源](https://www.elastic.co/guide/cn/elasticsearch/guide/current/_online_resources.html)
    *   [本书协议约定](https://www.elastic.co/guide/cn/elasticsearch/guide/current/_conventions_used_in_this_book.html)
    *   [使用代码示例](https://www.elastic.co/guide/cn/elasticsearch/guide/current/_using_code_examples.html)
    *   [鸣谢](https://www.elastic.co/guide/cn/elasticsearch/guide/current/_acknowledgments.html)
*   [基础入门](https://www.elastic.co/guide/cn/elasticsearch/guide/current/getting-started.html)
*   [深入搜索](https://www.elastic.co/guide/cn/elasticsearch/guide/current/search-in-depth.html)
*   [处理人类语言](https://www.elastic.co/guide/cn/elasticsearch/guide/current/languages.html)
*   [聚合](https://www.elastic.co/guide/cn/elasticsearch/guide/current/aggregations.html)
*   [地理位置](https://www.elastic.co/guide/cn/elasticsearch/guide/current/geoloc.html)
*   [数据建模](https://www.elastic.co/guide/cn/elasticsearch/guide/current/modeling-your-data.html)
*   [管理、监控和部署](https://www.elastic.co/guide/cn/elasticsearch/guide/current/administration.html)

##### Subscribe to our newsletter

Follow Us

*   [![[./_resources/如何读这本书___Elasticsearch__权威指南___Elastic.resources/footer-icon-twitter.png]]](https://www.twitter.com/elastic)
*   [![[./_resources/如何读这本书___Elasticsearch__权威指南___Elastic.resources/footer-icon-facebook.png]]](https://www.facebook.com/elastic.co)
*   [![[./_resources/如何读这本书___Elasticsearch__权威指南___Elastic.resources/footer-icon-youtube.png]]](https://www.youtube.com/user/elasticsearch)
*   [![[./_resources/如何读这本书___Elasticsearch__权威指南___Elastic.resources/footer-icon-linkedin.png]]](https://www.linkedin.com/company/elastic-co)

### Products & Solutions

*   [Enterprise Search](https://www.elastic.co/enterprise-search)
*   [Observability](https://www.elastic.co/observability)
*   [Security](https://www.elastic.co/security)
*   [Elastic Stack](https://www.elastic.co/elastic-stack)
*   [Elasticsearch](https://www.elastic.co/elasticsearch)
*   [Kibana](https://www.elastic.co/kibana)
*   [Logstash](https://www.elastic.co/logstash)
*   [Beats](https://www.elastic.co/beats)
*   [Subscriptions](https://www.elastic.co/subscriptions)
*   [Pricing](https://www.elastic.co/pricing)

### Company

*   [Careers](https://www.elastic.co/about/careers/)
*   [Board of Directors](https://www.elastic.co/about/teams/board)
*   [Contact](https://www.elastic.co/contact)

### Resources

*   [Documentation](https://www.elastic.co/guide/index.html)
*   [What is the ELK Stack?](https://www.elastic.co/what-is/elk-stack)
*   [What is Elasticsearch?](https://www.elastic.co/what-is/elasticsearch)
*   [Migrating from Splunk](https://www.elastic.co/splunk-replacement)
*   [Compare AWS Elasticsearch](https://www.elastic.co/aws-elasticsearch-service)
*   [US Public Sector](https://www.elastic.co/federal)

*   [Trademarks](https://www.elastic.co/legal/trademarks)|
*   [Terms of Use](https://www.elastic.co/legal/terms-of-use)|
*   [Privacy](https://www.elastic.co/legal/privacy-statement)|
*   [Brand](https://www.elastic.co/brand)|
*   [Sitemap](https://www.elastic.co/sitemap)

© 2020. Elasticsearch B.V. All Rights Reserved

Elasticsearch is a trademark of Elasticsearch B.V., registered in the U.S. and in other countries.

Apache, Apache Lucene, Apache Hadoop, Hadoop, HDFS and the yellow elephant logo are trademarks of the [Apache Software Foundation](https://www.apache.org/) in the United States and/or other countries.

[![[./_resources/如何读这本书___Elasticsearch__权威指南___Elastic.resources/logo-elastic-vertical-reverse.png]]](https://www.elastic.co/)

    Created at: 2020-08-25T11:34:15+08:00
    Updated at: 2020-08-25T11:34:15+08:00


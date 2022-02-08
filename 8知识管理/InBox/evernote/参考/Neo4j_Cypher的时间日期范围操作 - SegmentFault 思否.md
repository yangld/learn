
# [Neo4j:Cypher的时间日期范围操作](https://segmentfault.com/a/1190000018369052)

[![[2460837133-5c7b409710cdf_big64.jpeg]]
**天天写bug**](https://segmentfault.com/u/dddbug)发布于 2019-03-03

![[lg.php]]

> 原文链接：[https://markhneedham.com/blog...](https://markhneedham.com/blog/2019/01/13/neo4j-cypher-date-ranges/)

本周我工作中有一项任务，是使用Cypher查询语言去创建一个日期范围的数据集。
我之前使用过duration函数，它能够对指定时期进行增加或删除操作，所以，我想我可以从这个函数开始。如果我想查找2019年1月1号之后一天的日期，可以通过下面的查询语句：

    neo4j> WITH date("2019-01-01") AS startDate
         RETURN startDate + duration({days: 1}) AS date;
    +------------+
    | date       |
    +------------+
    | 2019-01-02 |
    +------------+

下面我们扩展下这个代码，我们要得到2019年1月1号后5天的数据集，这时我们可以使用range函数。

    neo4j> WITH date("2019-01-01") AS startDate
         RETURN [day in range(0, 5) | startDate + duration({days: day})]
         AS dates;
    +--------------------------------------------------------------------------+
    | dates                                                                    |
    +--------------------------------------------------------------------------+
    | [2019-01-01, 2019-01-02, 2019-01-03, 2019-01-04, 2019-01-05, 2019-01-06] |
    +--------------------------------------------------------------------------+

如果你知道想要的天数，你会发现，通过上面的示例可以很容易获取这些天的集合。但是，如果我们仅知道开始日期和结束日期，要如何获取这中间天数的集合呢？这时我们就可以试试duration.inDays函数了，它能计算两个日期之间的范围。

    neo4j> RETURN duration.inDays(date("2019-01-01"), date("2019-01-06")) AS difference;
    +------------+
    | difference |
    +------------+
    | P0M5DT0S   |
    +------------+

这是什么鬼？别急，inDays返回的是一个对象，可以通过days属性得到天数。

    neo4j> RETURN duration.inDays(date("2019-01-01"), date("2019-01-06")).days AS days;
    +------+
    | days |
    +------+
    | 5    |
    +------+

下面我们更新一下最开始的示例，用开始日期和结束日期去替换到Cypher查询语句中硬编码的天数。

    neo4j> WITH date("2019-01-01") AS startDate, date("2019-01-06") AS endDate
           WITH startDate, duration.inDays(startDate, endDate).days AS days
           RETURN [day in range(0, days) | startDate + duration({days: day})]
           AS dates;
    +--------------------------------------------------------------------------+
    | dates                                                                    |
    +--------------------------------------------------------------------------+
    | [2019-01-01, 2019-01-02, 2019-01-03, 2019-01-04, 2019-01-05, 2019-01-06] |
    +--------------------------------------------------------------------------+

OK,关于Cypher日期范围的操作就是这么简单，希望对你有用。

[数据库](https://segmentfault.com/t/%E6%95%B0%E6%8D%AE%E5%BA%93)

[__

本文系翻译，阅读原文
https://markhneedham.com/blog/2019/01/13/neo4j-cypher-date-ranges/](https://markhneedham.com/blog/2019/01/13/neo4j-cypher-date-ranges/)

[![[passback_728x90.png]]](https://integralads.com/capabilities/brand-safety/?utm_campaign=GLB-g&utm_medium=gdisplay&utm_source=gsites)

![[lg.php]]

阅读 1.4k发布于 2019-03-03

<https://segmentfault.com/a/1190000018369052?utm_source=tag-newest#>

    Created at: 2021-01-29T16:44:22+08:00
    Updated at: 2021-01-29T16:44:22+08:00


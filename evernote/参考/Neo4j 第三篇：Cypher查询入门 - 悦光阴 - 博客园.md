
# [Neo4j 第三篇：Cypher查询入门](https://www.cnblogs.com/ljhdo/p/5516793.html)

Neo4j使用Cypher查询图形数据，Cypher是描述性的图形查询语言，语法简单，功能强大，由于Neo4j在图形数据库家族中处于绝对领先的地位，拥有众多的用户基数，使得Cypher成为图形查询语言的事实上的标准。本文作为入门级的教程，我不会试图分析Cypher语言的全部内容，本文的目标是循序渐进地使用Cypher语言执行简单的CRUD操作，为了便于演示，本文在Neo4j Browser中执行Cypher示例代码。以下图形包含三个节点和两个关系，本文会一步一步讲解如何利用Cypher语言创建以下图形。

![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/628084-20170519164108432-1746174343.png]]

我的Neo4j系列的文章收录在：[Neo4j](http://www.cnblogs.com/ljhdo/category/998219.html)

## **一，easy，热热身**

和SQL很相似，Cypher语言的关键字不区分大小写，但是属性值，标签，关系类型和变量是区分大小写的。

**1，变量（Variable）**

变量用于对搜索模式的部分进行命名，并在同一个查询中引用，在小括号()中命名变量，**变量名是区分大小写的**，示例代码创建了两个变量：n和b，通过return子句返回变量b；

MATCH (n)-->(b)
RETURN b

在Cypher查询中，变量用于引用搜索模式（Pattern），但是变量不是必需的，如果不需要引用，那么可以忽略变量。

**2，访问属性**

在Cypher查询中，通过逗号来访问属性，格式是：Variable.PropertyKey，通过id函数来访问实体的ID，格式是id(Variable)。

match (n)-->(b) where id(n)=5 and b.age=18
return b;

## **二，创建节点**

节点模式的构成：(Variable:Lable1:Lable2{Key1:Value1,Key2,Value2})，实际上，每个节点都有一个整数ID，在创建新的节点时，Neo4j自动为节点设置ID值，在整个数据库中，节点的ID值是递增的和唯一的。

下面的Cypher查询创建一个节点，标签是Person，具有两个属性name和born，通过RETURN子句，返回新建的节点：

create (n:Person { name: 'Tom Hanks', born: 1956 }) return n;

![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/628084-20170519164410228-217751375.png]]

继续创建其他节点：

create (n:Person { name: 'Robert Zemeckis', born: 1951 }) return n;
create (n:Movie { title: 'Forrest Gump', released: 1951 }) return n;

## **三，查询节点**

通过match子句查询数据库，match子句用于指定搜索的模式（Pattern），where子句为match模式增加谓词（Predicate），用于对Pattern进行约束；

1，查询整个图形数据库

match(n) return n;

在图形数据库中，有三个节点，Person标签有连个节点，Movie有1个节点

![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/628084-20170519164808260-281608105.png]]

点击节点，查看节点的属性，如图，Neo4j自动为节点设置ID值，本例中，Forrest Gump节点的ID值是5，

![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/628084-20170519164934416-1792994304.png]]

**2，查询born属性小于1955的节点**

match(n) where n.born<1955 
return n;

![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/628084-20170519165246369-1977734334.png]]

**3，查询具有指定Lable的节点**

match(n:Movie) return n;

![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/628084-20170519165345447-1527377171.png]]

**4，查询具有指定属性的节点**

match(n{name:'Tom Hanks'}) return n;

![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/628084-20170519165553353-1221761470.png]]

## **四，创建关系**

关系的构成：StartNode **\-** \[Variable:RelationshipType{Key1:Value1,Key2:Value2}\] **\->** EndNode，在创建关系时，必须指定关系类型。

**1，创建没有任何属性的关系**

MATCH (a:Person),(b:Movie)
WHERE a.name \= 'Robert Zemeckis' AND b.title = 'Forrest Gump' CREATE (a)\-\[r:DIRECTED\]->(b)
RETURN r;

![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/628084-20170519170338713-1562983462.png]]

**2，创建关系，并设置关系的属性**

MATCH (a:Person),(b:Movie)
WHERE a.name \= 'Tom Hanks' AND b.title = 'Forrest Gump' CREATE (a)\-\[r:ACTED\_IN { roles:\['Forrest'\] }\]->(b)
RETURN r;

![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/628084-20170519170129228-858101407.png]]

## **五，查询关系**

在Cypher中，关系分为三种：符号“--”，表示有关系，忽略关系的类型和方向；符号“-->”和“<--”，表示有方向的关系；

**1，查询整个数据图形**

![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/628084-20170519170741463-1455419525.png]]

**2，查询跟指定节点有关系的节点**

示例脚本返回跟Movie标签有关系的所有节点

match(n)--(m:Movie) return n;

![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/628084-20170519170937275-1539723581.png]]

**2，查询有向关系的节点**

MATCH (:Person { name: 'Tom Hanks' })-->(movie)
RETURN movie;

![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/628084-20170519171232978-1077893210.png]]

**3，为关系命名，通过\[r\]为关系定义一个变量名，通过函数type获取关系的类型**

MATCH (:Person { name: 'Tom Hanks' })-\[r\]->(movie)
RETURN r,type(r);

![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/628084-20170519171440650-613518319.png]]

**4，查询特定的关系类型，通过\[Variable:RelationshipType{Key:Value}\]指定关系的类型和属性**

MATCH (:Person { name: 'Tom Hanks' })-\[r:ACTED\_IN{roles:'Forrest'}\]->(movie)
RETURN r,type(r);

![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/628084-20170519171720932-1997305387.png]]

## **六，更新图形**

set子句，用于对更新节点的标签和实体的属性；remove子句用于移除实体的属性和节点的标签；

**1，创建一个完整的Path**

由于Path是由节点和关系构成的，当路径中的关系或节点不存在时，Neo4j会自动创建；

CREATE p =(vic:Worker:Person{ name:'vic',title:"Developer" })-\[:WORKS\_AT\]->(neo)<-\[:WORKS\_AT\]-(michael:Worker:Person { name: 'Michael',title:"Manager" })
RETURN p

变量neo代表的节点没有任何属性，但是，其有一个ID值，通过ID值为该节点设置属性和标签

![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/628084-20170519172644525-1538391137.png]]

**2，为节点增加属性**

通过节点的ID获取节点，Neo4j推荐通过where子句和ID函数来实现。

match (n) where id(n)=7
set n.name = 'neo'
return n;

**3，为节点增加标签**

match (n) where id(n)=7
set n:Company return n;

![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/628084-20170519173517119-1418894728.png]]

**4，为关系增加属性**

match (n)<-\[r\]-(m) where id(n)=7 and id(m)=8
set r.team='Azure'
return n;

![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/628084-20170519174113244-662479972.png]]

## 七，跟实体相关的函数

跟实体相关的函数，主要是获取节点或关系的ID，关系类型，标签和属性等函数。

**1，通过id函数，返回节点或关系的ID**

MATCH (:Person { name: 'Oliver Stone' })-\[r\]->(movie)
RETURN id(r);

**2，通过type函数，查询关系的类型**

MATCH (:Person { name: 'Oliver Stone' })-\[r\]->(movie)
RETURN type(r);

**3，通过lables函数，查询节点的标签**

MATCH (:Person { name: 'Oliver Stone' })-\[r\]->(movie)
RETURN lables(movie);

**4，通过keys函数，查看节点或关系的属性键**

MATCH (a)
WHERE a.name \= 'Alice' RETURN keys(a)

**5，通过properties()函数，查看节点或关系的属性**

CREATE (p:Person { name: 'Stefan', city: 'Berlin' })
RETURN properties(p)

## 八，模式

模式，用于描述如何搜索数据，模式的格式是：使用()标识节点，使用\[\]标识关系，为了更有效地使用Cypher查询，必须深入理解模式。 

**1，节点模式**

节点具有标签和属性，Cypher为了引用节点，需要给节点命名：

*   (n) ：该模式用于描述节点，节点的变量名是n；匿名节点是()；
*   (n:lable)：该模式用于描述节点，节点具有特定的标签lable；也可以指定多个标签；
*   (n{name:"Vic"})：该模式用于描述节点，节点具有name属性，并且name属性值是“Vic”；也可以指定多个属性；
*   (n:lablle{name:"Vic"})：该模式用于描述节点，节点具有特定的标签和name属性，并且name属性值是“Vic”；

**2，关系模式**

在属性图中，节点之间存在关系，关系通过\[\]表示，节点之间的关系通过箭头()-\[\]->()表示，例如：

*   \[r\]：该模式用于描述关系，关系的变量名是r；匿名关系是\[\]
*   \[r:type\]：该模式用于描述关系，关系类型是type；每一个关系必须有且仅有一个类型；
*   \[r:type{name:"Friend"}\]：该模式用于描述关系，关系的类型是type，关系具有属性name，并且name属性值是“Friend”；

**3，关联节点模式**

节点之间通过关系联系在一下，由于关系具有方向性，因此，-->表示存在有向的关系，--表示存在关联，不指定关系的方向，例如：

*   (a)-\[r\]->(b) ：该模式用于描述节点a和b之间存在有向的关系r，
*   (a)-->(b)：该模式用于描述a和b之间存在有向关系；

**4，变长路径的模式**

从一个节点，通过直接关系，连接到另外一个节点，这个过程叫遍历，经过的节点和关系的组合叫做路径（Path），路径是由节点和关系的有序组合。

*   (a)-->(b)：是步长为1的路径，节点a和b之间有关系直接关联；
*   (a)-->()-->(b)：是步长为2的路径，从节点a，经过两个关系和一个节点，到达节点b；

Cypher语言支持变长路径的模式，变长路径的表示方式是：\[\*N..M\]，N和M表示路径长度的最小值和最大值。

*   (a)-\[\*2\]->(b)：表示路径长度为2，起始节点是a，终止节点是b；
*   (a)-\[\*3..5\]->(b)：表示路径长度的最小值是3，最大值是5，起始节点是a，终止节点是b；
*   (a)-\[\*..5\]->(b)：表示路径长度的最大值是5，起始节点是a，终止节点是b；
*   (a)-\[\*3..\]->(b)：表示路径长度的最小值是3，起始节点是a，终止节点是b；
*   (a)-\[\*\]->(b)：表示不限制路径长度，起始节点是a，终止节点是b；

**5，路径变量**

路径可以指定（assign）给一个变量，该变量是路径变量，用于引用查询路径。

p = (a)-\[\*3..5\]->(b)

**6，示例**

以下示例图有6个节点，每个节点都有一个属性name，节点之间存在关系，关系类型是KNOWS，如图：

![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/628084-20170527172242263-445991598.png]]

查询模式是：查找跟Filipa有关系的人，路径长度为1或2，查询的结果是："Dilshad"和"Anders"

MATCH (me)-\[:KNOWS\*1..2\]-(remote\_friend)
WHERE me.name = 'Filipa'
RETURN remote\_friend.name

参考文档：

[Chapter 3. Cypher](http://neo4j.com/docs/developer-manual/current/cypher/)

[3.3.16. MERGE](http://neo4j.com/docs/developer-manual/current/cypher/clauses/merge/)

[3.2.7. Patterns](https://neo4j.com/docs/developer-manual/3.2/cypher/syntax/patterns/)

**作者**：[悦光阴](http://www.cnblogs.com/ljhdo/)
**出处**：<http://www.cnblogs.com/ljhdo/>
本文版权归作者和博客园所有，欢迎转载，但未经作者同意，必须保留此段声明，且在文章页面醒目位置显示原文连接，否则保留追究法律责任的权利。

标签: [Neo4j](https://www.cnblogs.com/ljhdo/tag/Neo4j/), [Cypher查询](https://www.cnblogs.com/ljhdo/tag/Cypher%E6%9F%A5%E8%AF%A2/)

[[# | 好文要顶]] [[# | 关注我]] [[# | 收藏该文]] [[# | ![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/icon_weibo_24.png]]]] [[# | ![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/wechat.png]]]]

[![[./_resources/Neo4j_第三篇：Cypher查询入门_-_悦光阴_-_博客园.resources/20180515145355.png]]](https://home.cnblogs.com/u/ljhdo/)
[悦光阴](https://home.cnblogs.com/u/ljhdo/)
[关注 - 12](https://home.cnblogs.com/u/ljhdo/followees/)
[粉丝 - 942](https://home.cnblogs.com/u/ljhdo/followers/)

推荐博客
[[# | +加关注]]

[«](https://www.cnblogs.com/ljhdo/p/5178225.html) 上一篇： [Neo4j 第二篇：图形数据库](https://www.cnblogs.com/ljhdo/p/5178225.html)
[»](https://www.cnblogs.com/ljhdo/p/5531467.html) 下一篇： [Neo4j 第四篇：使用.NET驱动访问Neo4j](https://www.cnblogs.com/ljhdo/p/5531467.html)

posted @ 2017-05-24 09:37  [悦光阴](https://www.cnblogs.com/ljhdo/)  阅读(73996)  评论(4)  [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=5516793)  [[# | 收藏]]

    Created at: 2021-01-29T15:17:44+08:00
    Updated at: 2021-01-29T15:17:44+08:00


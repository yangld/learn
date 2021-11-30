
# Neo4j基本入门

Javaneo4j

`Neo4j`是一个高性能的,`NOSQL`图形数据库，它将结构化数据存储在网络上而不是表中。它是一个**嵌入式的**、**基于磁盘的**、具备**完全的事务**特性的`Java`持久化引擎，但是它将结构化数据存储在网络(从数学角度叫做图)上而不是表中。`Neo4j`也可以被看作是一个高性能的图引擎，该引擎具有成熟数据库的所有特性。程序员工作在一个面向对象的、灵活的网络结构下而不是严格、静态的表中——但是他们可以享受到具备完全的事务特性、企业级的数据库的所有好处。

## 

一、基本概念

![[./_resources/Neo4j基本入门_-_浩子同学_-_博客园.resources/1552657220501.png]]
neo4j存储节点

### 

1\. 标签(Label)

在`Neo4j`中，一个节点可以有一个以上的标签，从现实世界的角度去看，一个标签可以认为节点的某个类别，比如`BOOK`、`MOVIE`等等。

### 

2\. 节点(Node)

节点是指一个实实在在的对象，这个对象可以有好多的标签，表示对象的种类，也可以有好多的属性，描述其特征，节点与节点之间还可以形成多个有方向（或者没有方向）的关系。

### 

3\. 关系(Relationship)

用来描述节点与节点之间的关系，这也是图数据与与普通数据库最大的区别，正是因为有这些关系的存在，才可以描述那些我们普通行列数据库所很难表示的网状关系，比如我们复杂的人际关系网，所谓的六度理论，就可以很方便的用图数据库进行模拟，比如我们大脑神经元之间的连接方式，都是一张复杂的网。

有一点需要重点注意，关系可以拥有属性。

### 

4\. 属性(Property)

描述节点的特性，采用的是`Key-Value`结构，可以随意设定来描述节点的特征。

## 

二、查询语法(CQL)

| 序号  | 关键字 | 关键字作用 |
| --- | --- | --- |
| 1   | CREATE | 创建  |
| 2   | MATCH | 匹配  |
| 3   | RETURN | 加载  |
| 4   | WHERE | 过滤检索条件 |
| 5   | DELETE | 删除节点和关系 |
| 6   | REMOVE | 删除节点和关系的属性 |
| 7   | ORDER BY | 排序  |
| 8   | SET | 添加或更新属性 |

### 

1\. 基本查找match return

`neo4j`使用的查询语法是`Cypher`语法与我们常用的SQL查询语法不一样，但是在初步的学习之后，觉得他们之间使用的思路有很多重叠的地方，整个语句的执行流程也和SQL有比较多相似的地方。

    # 创建两个节点，一个子节点（Mask），一个父节点(Old_mask)，他们之间是属于父子关系
    # 其中create表示新建
    # p 表示这个节点的别名
    # PERSON 表示节点p的标签PERSON的属性
    # {} 大括号中间的键值对，表示p这个节点作为PERSON这个标签类别所拥有的属性
    # -[r:SON_OF]-> 表示节点p指向节点f，他们之间的关系是SON_OF，这个关系的别名是r，r可以拥有属于自己的属性
    # return 表示执行这段语句之后，需要返回的对象，return p,r,f 表示返回 节点p,节点f，以及他们之间的关系r
    create(p:PERSON {name:"Mask",age:30,heigh:180,weight:80})-[r:SON_OF]->(f:PERSON {name:"OLD_Mask",age:55,heigh:160,weight:60}) return p,r,f

![[./_resources/Neo4j基本入门_-_浩子同学_-_博客园.resources/1552651102917.png]]
两个带有关系的节点

返回数据：

![[./_resources/Neo4j基本入门_-_浩子同学_-_博客园.resources/1552651154031.png]]
返回数据列表

### 

2\. 查找指定节点、指定属性、指定关系的节点、关系

    # MATCH 匹配命令
    # return 后面的别名p还可以利用as 设置指定的返回值名称，如 p as userName
    
    match (p:PERSON {name:"Mask"})-[r]-(n) return p,r,n

命令执行结果：

![[./_resources/Neo4j基本入门_-_浩子同学_-_博客园.resources/1552658429136.png]]
查找结果

![[./_resources/Neo4j基本入门_-_浩子同学_-_博客园.resources/1552658472996.png]]
查找结果

`where`关键字类似于`SQL`里面的`where`关键字，可以通过运算符`== >= ...`来过滤一些查询条件。

### 

3\. 对查找结果进行排序order by，并限制返回条数 limit

`order by`关键字与`SQL`里面是一样的操作，后面跟上需要根据排序的关键字，`limit`的操作是指定输出前几条

    # 这里利用order by来指定返回按照Person.name来排序
    # limit 表示只返回前3条数据
    match(p:Person) return p order by p.name limit 3

查找结果：

![[./_resources/Neo4j基本入门_-_浩子同学_-_博客园.resources/1552702849208.png]]
返回排序后前3条结果

### 

4\. 删除节点delete命令

删除节点的操作也是通过dlete来操作，如果被删除的节点存在Relationship，那么单独删除该节点的操作会不成功，所以如果想删除一个已经存在关系的节点，需要同时将关系进行删除。

删除一个不存在Relationship节点，会报错：

![[./_resources/Neo4j基本入门_-_浩子同学_-_博客园.resources/1552703616296.png]]
删除一个存在relationship的节点不成功

删除一个节点记忆与他有关的关系，成功：

![[./_resources/Neo4j基本入门_-_浩子同学_-_博客园.resources/1552703680319.png]]
删除节点以及与它有关的关系

    # 删除指定条件的节点
    # 先通过匹配关键字match找到匹配元素，然后通过delete关键字指定删除
    match(p:PERSON {name:"teacher_wange"}) delete p
    
    # 删除节点和节点相关的关系
    match (p:Person {name:"lisi"})-[r]-() delete p,r

### 

5\. 删除属性remove命令

remove命令是用来删除节点或者关系的属性

删除属性前的节点：

![[./_resources/Neo4j基本入门_-_浩子同学_-_博客园.resources/1552704239359.png]]
删除属性前的节点

删除`birthday`属性后的节点：

![[./_resources/Neo4j基本入门_-_浩子同学_-_博客园.resources/1552704272349.png]]
删除birthday属性后的节点

### 

6\. neo4j的字符串函数

`upper`,`lower`,`substring`,`replac`四种字符串的操作，其中`upper`与`lower`在将来的版本中会被修改为`toupper`/`tolower`

大写转换操作结果：

![[./_resources/Neo4j基本入门_-_浩子同学_-_博客园.resources/1552704944362.png]]
大小写转换

### 

7\. 聚合函数AGGREGATION

常用的聚合函数有`COUNT`、`MAX`、`MIN`、`AVG`、`SUM`等五种。

    match(p:Person) return p.name as name,p.age as age,count(p) as count,max(p.age) as maxAge,min(p.age) as minAge,avg(p.age) as avgAge,sum(p.age) as sumAge

聚合函数操作结果：

![[./_resources/Neo4j基本入门_-_浩子同学_-_博客园.resources/1552705898287.png]]
聚合函数

### 

8\. 关系函数

| 序号  | 函数名 | 函数功能描述 |
| --- | --- | --- |
| 1   | STARTNODE | 查找关系的起始点 |
| 2   | ENDNODE | 查找关系的终点 |
| 3   | ID  | 查找关系的ID |
| 4   | TYPE | 查找关系的类型，也就是我们在图表中看到的名称 |

    # 先获取关系，然后通过关系函数来获取关系的id、type、起始节点、终止节点等等信息
    
    match ()-[r:SON_OF]-() return startnode(r).name as start_node, endnode(r).name as end_node,id(r) as relationship_id ,type(r) as realtionship_type

关系查询结果：

![[./_resources/Neo4j基本入门_-_浩子同学_-_博客园.resources/1552706801319.png]]
关系查询结果

## 

在Java中使用

### 

1\. 原生的Neo4j Java API

`Neo4j Java API`的设计思路及基本概念：

1.  Label接口，表示标签，实现这个接口的类，就可以当标签使用；
2.  Relationship接口，别是关系，实现这个接口的类，就可以表示关系；
3.  通过`GraphDatabaseFactory`这个类的实例化对象可以获取`GraphDatabaseService`实例；
4.  `GraphDatabaseService`实例对象，可以获取一个操作事务，通过这个事务可以实现任何操作异常的回滚，操作成功需要调用`tx.success()`方法；
5.  `GraphDatabaseService` 对象可以创建节点`node`;
6.  节点`node`可以设置属性`setProperty(key,value)`;
7.  节点`node`可以创建关系`Relationship`,`Relationship`也可以通过`setProperty(key,value)`来设置属性；

#### 

枚举标签Label

    package com.tp.ne4oj.java.examples;
    import org.neo4j.graphdb.Label;
    public enum Tutorials implements Label {
        JAVA,SCALA,SQL,NEO4J;
    }

#### 

枚举关系Realationship

    package com.tp.neo4j.java.examples;
    import org.neo4j.graphdb.RelationshipType;
    public enum TutorialRelationships implements RelationshipType{
        JVM_LANGIAGES,NON_JVM_LANGIAGES;
    }

#### 

获取操作对象

    GraphDatabaseFactory dbFactory = new GraphDatabaseFactory();
    GraphDatabaseService db= dbFactory.newEmbeddedDatabase("C:/TPNeo4jDB");

#### 

启动neo4j数据库事务

    try (Transaction tx = graphDb.beginTx()) {
        // Perform DB operations				
        tx.success();
    }

#### 

整体代码

    package com.tp.neo4j.java.examples;
    
    import org.neo4j.graphdb.GraphDatabaseService;
    import org.neo4j.graphdb.Node;
    import org.neo4j.graphdb.Relationship;
    import org.neo4j.graphdb.Transaction;
    import org.neo4j.graphdb.factory.GraphDatabaseFactory;
    
    public class Neo4jJavaAPIDBOperation {
    public static void main(String[] args) {
        GraphDatabaseFactory dbFactory = new GraphDatabaseFactory();
        GraphDatabaseService db= dbFactory.newEmbeddedDatabase("C:/TPNeo4jDB");
        try (Transaction tx = db.beginTx()) {
    
            Node javaNode = db.createNode(Tutorials.JAVA);
            javaNode.setProperty("TutorialID", "JAVA001");
            javaNode.setProperty("Title", "Learn Java");
            javaNode.setProperty("NoOfChapters", "25");
            javaNode.setProperty("Status", "Completed");				
            
            Node scalaNode = db.createNode(Tutorials.SCALA);
            scalaNode.setProperty("TutorialID", "SCALA001");
            scalaNode.setProperty("Title", "Learn Scala");
            scalaNode.setProperty("NoOfChapters", "20");
            scalaNode.setProperty("Status", "Completed");
            
            Relationship relationship = javaNode.createRelationshipTo
            (scalaNode,TutorialRelationships.JVM_LANGIAGES);
            relationship.setProperty("Id","1234");
            relationship.setProperty("OOPS","YES");
            relationship.setProperty("FP","YES");
            
            tx.success();
        }
           System.out.println("Done successfully");
    }
    }

### 

Cypher执行引擎，让Java执行原生CQL语句

    package com.tp.neo4j.java.cql.examples;
    
    import org.neo4j.cypher.javacompat.ExecutionEngine;
    import org.neo4j.cypher.javacompat.ExecutionResult;
    import org.neo4j.graphdb.GraphDatabaseService;
    import org.neo4j.graphdb.factory.GraphDatabaseFactory;
    
    public class JavaNeo4jCQLRetrivalTest {
       public static void main(String[] args) {
          // 1. 获取graphDB
          GraphDatabaseFactory graphDbFactory = new GraphDatabaseFactory();
          GraphDatabaseService graphDb = graphDbFactory.newEmbeddedDatabase("C:/TPNeo4jDB");
          // 2. 获取Cypher执行引擎
          ExecutionEngine execEngine = new ExecutionEngine(graphDb);
          ExecutionResult execResult = execEngine.execute("MATCH (java:JAVA) RETURN java");
          // 3. 获取执行结果
          String results = execResult.dumpToString();
          System.out.println(results);
       }
    }

### 

Spring Data neo4j 的操作

操作思路：

1.  创建一个与图数据库存储数据对应的实体类`entity`，并进行必要的注解;
2.  `dao`层接口继承`Spring data Neo4j`类`GraphRepository`、`GraphTemplate`、`CrudRepository`、`PaginationAndSortingRepository`，这个和springDataJPA也比较类似;

#### 

基本导包操作，pom.xml

    <project xmlns="http://maven.apache.org/POM/4.0.0" 
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
       xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
       http://maven.apache.org/xsd/maven-4.0.0.xsd">
       
       <modelVersion> 4.0.0 </modelVersion>
       <groupId> com.tp.neo4j </groupId>
       <artifactId> springdata-neo4j </artifactId>
       <version> 1.0 </version>  
       
       <dependencies>
          <dependency>   
             <groupId> org.springframework.data </groupId>
             <artifactId> spring-data-neo4j </artifactId>
             <version> 3.1.2.RELEASE </version>
          </dependency>
          
          <dependency>
             <groupId> org.neo4j </groupId>
             <artifactId> neo4j-kernel </artifactId>
             <version> 2.1.3 </version>
          </dependency>  
          
          <dependency>
             <groupId> javax.transaction </groupId>
             <artifactId> jta </artifactId>
             <version> 1.1 </version>
          </dependency>
          
          <dependency>
             <groupId>javax.validation</groupId>
             <artifactId>validation-api</artifactId>
             <version>1.0.0.GA</version>
          </dependency>
          
       </dependencies>   
    </project>

### 

最后

neo4j与java的结合有很多的方式，据目前我所知道的就有`原生api`、`driver方式`、`springData neo4j`等三种方式。

    Created at: 2021-01-28T13:46:05+08:00
    Updated at: 2021-01-28T13:46:05+08:00


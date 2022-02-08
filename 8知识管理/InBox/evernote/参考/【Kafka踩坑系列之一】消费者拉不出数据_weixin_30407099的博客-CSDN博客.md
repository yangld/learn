
# 【Kafka踩坑系列之一】消费者拉不出数据

![[8知识管理/InBox/evernote/参考/_resources/【Kafka踩坑系列之一】消费者拉不出数据_weixin_30407099的博客-CSDN博客.resources/reprint.png]]
[weixin\_30407099](https://blog.csdn.net/weixin_30407099) 2017-09-30 17:50:00 ![[8知识管理/InBox/evernote/参考/_resources/【Kafka踩坑系列之一】消费者拉不出数据_weixin_30407099的博客-CSDN博客.resources/articleReadEyes.png]] 877  

		
文章标签： [大数据](https://www.csdn.net/tags/MtTaYg5sNzg2NS1ibG9n.html) [java](https://www.csdn.net/tags/NtTaIg5sMzYyLWJsb2cO0O0O.html) [python](https://www.csdn.net/tags/MtjaQg4sNDk0LWJsb2cO0O0O.html)

### 一、Bug背景

      因业务需要，我们部署了两个Kafka集群。Kafka集群A的版本号为：0.11.0.1，Kafka集群B的版本号为0.9.0.1。

      因两个Kafka集群的版本号不一致，尝试了多种解决方案，发现总有一个集群出不来数据，无法互相兼容。

### 二、Kafka的客户端版本号必须与服务端版本号一致

*   客户端v0.11.0.1的Maven配置

`<` `dependency` `>`
  `<` `groupId` `>org.apache.kafka</` `groupId` `>`
  `<` `artifactId` `>kafka-clients</` `artifactId` `>`
  `<` `version` `>0.11.0.1</` `version` `>`
`</` `dependency` `>`

*   客户端v0.9.0.1的Maven配置

`<` `dependency` `>`
  `<` `groupId` `>org.apache.kafka</` `groupId` `>`
  `<` `artifactId` `>kafka-clients</` `artifactId` `>`
  `<` `version` `>0.9.0.1</` `version` `>`
`</` `dependency` `>`

先尝试使用客户端v0.11.0.1，发现集群B的消费者程序无法拉出数据。再尝试使用客户端v0.9.0.1，发现集群A无法拉取出数据。
显然， **同一个Maven工程无法依赖同一个组件不同版本的JAR包。**
WTF，先泪奔一会儿。泪奔完还得想办法填这个坑。
首先脑洞一个办法， **先从官网下载v0.9.0.1版本的Kafka源码，再修改其包名和groupId，再编译打包**。但最终没有选择这个方案。
 1. Kafka源码使用Gradle管理，我的本机没有Gradle环境，不想折腾下去了。就是懒！( ╯□╰ )
 2. 包名不同，类名相同，很容易混用。说不定未来就坑到自己或同事了！
集群B是个老集群了，上面有很多业务。短期内升级是不可能了，那只能选择 **将集群A降级为v0.9.0.1**。

### 三、降级前要清空老数据，升级时参考官方文档的数据兼容方案

集群A降级后，消费者程序一直拉不出数据，新建topic也不行。查问题，各种猜测，折腾了一整天仍未解决。。

后来干脆通知我司的运维GG清空所有老数据，再重装Kafka。竟然成功了！

所以，问题出在不同版本的数据不兼容。降级前要清数据，升级前务必参考官方文档。否则坑死你不偿命~

转载于:https://www.cnblogs.com/sea-horse/p/7615765.html

    Created at: 2021-01-27T19:13:58+08:00
    Updated at: 2021-01-27T19:13:58+08:00


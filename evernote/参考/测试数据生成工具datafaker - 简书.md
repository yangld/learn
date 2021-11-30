
# 测试数据生成工具datafaker

[![[./_resources/测试数据生成工具datafaker_-_简书.resources/webp.webp]]](https://www.jianshu.com/u/747ebf0aaa4b)

[叫我小名](https://www.jianshu.com/u/747ebf0aaa4b)
_![[./_resources/测试数据生成工具datafaker_-_简书.resources/embedded.svg]]_0.0752019.03.27 13:14:03字数 1,080阅读 7,364

## 一、开源情况

datafaker是一个大批量测试数据和流测试数据生成工具，兼容python2.7和python3.4+，欢迎下载使用。github地址为：

[https://github.com/gangly/datafaker](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fgangly%2Fdatafaker)

文档同步更新在github

## 二、工具产生背景

在软件开发测试过程，经常需要测试数据。这些场景包括：

*   后端开发
    新建表后，需要构造数据库测试数据，生成接口数据提供给前端使用。
*   数据库性能测试
    生成大量测试数据，测试数据库性能
*   流数据测试
    针对kafka流数据，需要不断定时生成测试数据写入kafka

常用方法是人工手动造几条数据写入数据库，这种方法带来的弊端是

*   浪费工时
    针对表的不同数据类型的字段，需要构造不同数据
*   数据量小
    如果需要构造大量数据，手动造数据无能为力
*   不够准确
    比如需要构造邮箱（满足一定格式），电话号码（确定的数字位数），ip地址（固定格式），年龄（不能为负数，有大小范围）等。这些测试数据有一定的限制或规律，手工构造可能不能满足数据范围或一些格式要求而导致后端程序报错
*   多表关联
    手动造的数据量较小，在多个表中用主键不一定能关联上，或者关联出来没数据
*   动态随机写入
    比如针对流数据，需要随机每隔几秒钟写入kafka。或者动态随机插入mysql，手工操作相对麻烦，而且不好统计写入数据条数

**datafaker是一个多数据源测试数据构造工具，可以模拟产生大部分常用数据类型，具有以下功能：**

*   多种数据类型
    包括常见数据库字段类型（整型、浮点型、字符型）、自定义类型（IP地址，邮箱，身份证号码等）
*   模拟多表关联数据
    通过制定某些字段为枚举类型（从指定的数据列表里面随机选择），这样在数据量多的情况下能保证多表Join能关联上，查询到数据
*   支持批数据和流数据生成，可指定数据产生间隔时间
*   支持多种数据输出方式，包括屏幕打印、文件和远程数据源
*   支持多种数据源。目前支持关系型数据库、Hive、Kafka、Hbase、ES。后面将扩展到Mongo，Kudu等数据源
*   可指定输出格式，目前支持text，json

## 三、软件架构

datafaker是用python编写，支持python2.7，python3.4+。已经发布在pypi上，[https://pypi.org/search/?q=datafaker](https://links.jianshu.com/go?to=https%3A%2F%2Fpypi.org%2Fsearch%2F%3Fq%3Ddatafaker)。

![[./_resources/测试数据生成工具datafaker_-_简书.resources/webp.1.webp]]

datafaker.png

架构图完整的画出了工具的执行过程，从图可知工具经历了5个模块：

*   参数解析器。解析用户从终端命令行输入的命令。
*   元数据解析器。用户可以指定元数据来自本地文件或者远程数据库表。解析器获取到文件内容后按照规则将文本内容解析成表字段元数据和数据构造规则。
*   数据构造引擎。构造引擎根据元数据解析器产生的数据构造规则，模拟产生不同类型的数据。
*   数据路由。根据不同的数据输出类型，分成批量数据和流数据生成。流数据可指定产生频率。然后将数据转换成用户指定的格式输出到不同数据源中。
*   数据源适配器。适配不同数据源，将数据导入到数据源中。

## 四、安装流程

首先确保已经安装python和pip
有两种安装方法：

方法1.下载安装
下载源码压缩包，解压后，到datafaker目录里面执行：

    python setup.py install
    1

方法2.直接安装（此方法使用若有问题，请用方法1安装）

    pip install datafaker
    1

_![[./_resources/测试数据生成工具datafaker_-_简书.resources/embedded.1.svg]]_
1人点赞_![[./_resources/测试数据生成工具datafaker_-_简书.resources/embedded.2.svg]]_

_![[./_resources/测试数据生成工具datafaker_-_简书.resources/embedded.3.svg]]_

[_![[./_resources/测试数据生成工具datafaker_-_简书.resources/embedded.4.svg]]_工具](https://www.jianshu.com/nb/6458893)

_![[./_resources/测试数据生成工具datafaker_-_简书.resources/embedded.5.svg]]_

"谢谢赞赏！"
还没有人赞赏，支持一下
[![[./_resources/测试数据生成工具datafaker_-_简书.resources/webp.2.webp]]](https://www.jianshu.com/u/747ebf0aaa4b)

[叫我小名](https://www.jianshu.com/u/747ebf0aaa4b)关注互联网技术，聚焦大数据、人工智能
总资产1 (约0.12元)共写了7548字获得17个赞共12个粉丝

    Created at: 2020-10-16T11:19:07+08:00
    Updated at: 2020-10-16T11:19:07+08:00


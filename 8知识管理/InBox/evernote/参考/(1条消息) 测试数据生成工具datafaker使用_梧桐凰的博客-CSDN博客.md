
# 测试数据生成工具datafaker使用

![[8知识管理/InBox/evernote/参考/_resources/(1条消息)_测试数据生成工具datafaker使用_梧桐凰的博客-CSDN博客.resources/original.png]]
[梧桐凰](https://me.csdn.net/weixin_43613890) 2020-05-18 10:59:06 ![[8知识管理/InBox/evernote/参考/_resources/(1条消息)_测试数据生成工具datafaker使用_梧桐凰的博客-CSDN博客.resources/articleReadEyes.png]] 362  

		
分类专栏： [知识](https://blog.csdn.net/weixin_43613890/category_8526893.html) 文章标签： [python](https://www.csdn.net/gather_24/MtjaQg4sNDk0LWJsb2cO0O0O.html) [mysql](https://www.csdn.net/gather_25/MtTaEg5sOTYwNC1ibG9n.html)

![[8知识管理/InBox/evernote/参考/_resources/(1条消息)_测试数据生成工具datafaker使用_梧桐凰的博客-CSDN博客.resources/embedded.svg]]

1、工具使用场景

在软件开发测试过程，经常需要测试数据。这些场景包括：

1.1 后端开发
新建表后，需要构造数据库测试数据，生成接口数据提供给前端使用。

1.2数据库性能测试
生成大量测试数据，测试数据库性能

1.3流数据测试
针对kafka流数据，需要不断定时生成测试数据写入kafka

2、安装流程

*   安装python
*   安装pip install datafaker
*   更新到最新版本：pip install datafaker --upgrade
*   卸载工具：pip uninstall datafaker

如果是python2,需要安装MySQLdb

如果是python3,则安装pymysql,并在datafaker目录下init.py中添加以下两行

    import pymysql
    pymysql.install_as_MySQLdb() 
    

3、datafaker使用

3.1 新建meta.txt文件，将对应的表元数据写入

    id||int||自增id[:inc(id,1)]
    name||varchar(20)||学生名字
    school||varchar(20)||学校名字[:enum(file://names.txt)]
    nickname||varchar(20)||学生小名[:enum(鬼泣, 高小王子, 歌神, 逗比)]
    age||int||学生年龄[:age]
    class_num||int||班级人数[:int(10, 100)]
    score||decimal(4,2)||成绩[:decimal(4,2,1)]
    phone||bigint||电话号码[:phone_number]
    email||varchar(64)||家庭网络邮箱[:email]
    ip||varchar(32)||IP地址[:ipv4]
    address||text||家庭地址[:address]
    

3.2命令行输入

    datafaker rdb mysql+mysqldb://user:password@localhost:3306/dw?charset=utf8 user 500  --meta meta.txt
    #user是测试数据导入的表 需事先创建好
    #500是测试数据生成量，可配置
    

3.3从本地文件meta.txt中读取元数据，以,分隔符构造10条数据，打印在屏幕上不会在数据插入

    $ datafaker rdb mysql+mysqldb://root:root@localhost:3600/test?charset=utf8 stu 10 --outprint --meta meta.txt --outspliter ,,
    

3.4 写hive：产生1000条数据写入hive的test库，stu表中

其中yarn为用户名，需要hive版本支持acid，不然请生成本地文件，然后上传到hdfs

    datafaker hive hive://yarn@localhost:10000/test stu 1000 --meta data/hive_meta.txt
    

3.5 写文件：产生10条json格式数据写入到/home目录out.txt中

* * *

    datafaker file /home out.txt 10 --meta meta.txt --format json
    

3.6 写kafka：从本地meta.txt参数数据，以1秒间隔输出到kafka的topic hello中

* * *

    $ datafaker kafka localhost:9092 hello 1 --meta meta.txt --interval 1
    {"school": "\u4eba\u548c\u4e2d\u5fc3", "name": "\u5218\u91d1\u51e4", "ip": "192.20.103.235", "age": 9, "email": "chaokang@gang.cn", "phone": "13256316424", "score": 3.45, "address": "\u5e7f\u4e1c\u7701\u5b81\u5fb7\u5e02\u6d54\u9633\u5468\u8defu\u5ea7 990262", "class_num": 24, "nickname": "\u9017\u6bd4", "id": 1}
    {"school": "\u4eba\u548c\u4e2d\u5fc3", "name": "\u6768\u4e3d", "ip": "101.129.18.230", "age": 3, "email": "min60@hv.net", "phone": "18183286767", "score": 22.16, "address": "\u8fbd\u5b81\u7701\u592a\u539f\u5e02\u53cb\u597d\u6c55\u5c3e\u8defG\u5ea7 382777", "class_num": 30, "nickname": "\u6b4c\u795e", "id": 2}
    {"school": "\u6e05\u534e\u4e2d\u5b66", "name": "\u8d75\u7ea2", "ip": "192.0.3.34", "age": 9, "email": "fxiao@gmail.com", "phone": "18002235094", "score": 48.32, "address": "\u5e7f\u897f\u58ee\u65cf\u81ea\u6cbb\u533a\u65ed\u5e02\u6c88\u5317\u65b0\u6731\u8defc\u5ea7 684262", "class_num": 63, "nickname": "\u6b4c\u795e", "id": 3}
    {"school": "\u6e05\u534e\u4e2d\u5b66", "name": "\u5f20\u7389\u6885", "ip": "198.20.50.222", "age": 3, "email": "xiulanlei@cw.net", "phone": "15518698519", "score": 85.96, "address": "\u5b81\u590f\u56de\u65cf\u81ea\u6cbb\u533a\u6d69\u53bf\u767d\u4e91\u4e4c\u9c81\u6728\u9f50\u8857s\u5ea7 184967", "class_num": 18, "nickname": "\u9017\u6bd4", "id": 4}
    {"school": "\u732a\u573a", "name": "\u674e\u6842\u5170", "ip": "192.52.195.184", "age": 8, "email": "fxiao@konggu.cn", "phone": "18051928254", "score": 97.87, "address": "\u9ed1\u9f8d\u6c5f\u7701\u54c8\u5c14\u6ee8\u53bf\u6c38\u5ddd\u6d2a\u8857E\u5ea7 335135", "class_num": 46, "nickname": "\u9ad8\u5c0f\u738b\u5b50", "id": 5}
    {"school": "\u4eba\u548c\u4e2d\u5fc3", "name": "\u5434\u60f3", "ip": "192.42.234.178", "age": 3, "email": "uliang@yahoo.com", "phone": "14560810465", "score": 6.32, "address": "\u5b81\u590f\u56de\u65cf\u81ea\u6cbb\u533a\u516d\u76d8\u6c34\u5e02\u5357\u6eaa\u7f57\u8857M\u5ea7 852408", "class_num": 12, "nickname": "\u9b3c\u6ce3", "id": 6}
    ^Cgenerated records : 6
    insert records : 6
    time used: 6.285 s
    

json嵌套或任意数据结构(可不是jon)

    datafaker kafka localhost:9092 hello 10 --metaj meta.txt
    

请使用–metaj指定元数据文件meta.txt：

    {
        "name": [:name],
        "age": [:age],
        "school": {
            "sch_name": [:enum(file://../data/names.txt)],
            "sch_address": [:address],
            "scores": [
                {
                    "class": [:enum(Math, English)],
                    "score": [:decimal(4,2,1)]
                },
                {
                    "class": [:enum(Chinese, Computer)],
                    "score": [:decimal(4,2,1)]
                }
            ]
        }
    }
    

datafaker会替换meta.txt内容中带标记的字符串，并保留原格式，包括tab和空格，产生如下结果：

    {
        "name": 驷俊,
        "age": 95,
        "school": {
            "sch_name": 旧大院,
            "sch_address": 湖北省济南市上街宁德路I座 557270,
            "scores": [
                {
                    "class": Math,
                    "score": 83.28
                },
                {
                    "class": Computer,
                    "score": 52.37
                }
            ]
        }
    }
    

如果要使用正确格式的json,将元数据文件内容压缩

    {"name":[:name],"age":[:age],"school":{"sch_name":[:enum(file://../data/names.txt)],"sch_address":[:address],"scores":[{"class":[:enum(Math,English)],"score":[:decimal(4,2,1)]},{"class":[:enum(Chinese,Computer)],"score":[:decimal(4,2,1)]}]}}
    

3.7 写hbase

* * *

    datafaker hbase localhost:9090 test-table 10 --meta data/hbase.txt
    复制

需要开启hbase thrift服务,不能为thrift2
例子中，创建一张表test-table, 列族为Cf
元数据文件hbase.txt内容为

    rowkey||varchar(20)||sdflll
    Cf:name||varchar(20)||学生名字
    Cf:age||int||学生年龄[:age]
    

其中第一行必须为rowkey, 可带参数，rowkey(0,1,4)表示将rowkey值和后面第一列，第五列值用\_连接

后面行为列族中的列名，可以创建多个列族

3.8 写入ES

* * *

    datafaker es localhost:9200 example1/tp1 100 --auth elastic:elastic --meta meta.txt
    

其中localhost:9200为es的连接方式，多个host用逗号分隔。如host1:9200,host2:9200

example1/tp1为index和type，以/分隔

elastic:elastic为账号和密码，若没有，则可不带该参数

3.9 数据写入oracle

* * *

    datafaker rdb oracle://root:root@127.0.0.1:1521/helowin stu 10 --meta meta.txt
    

sqlalchemy连接串必须为oracle:形式

    Created at: 2020-10-16T10:01:23+08:00
    Updated at: 2020-10-16T10:01:23+08:00


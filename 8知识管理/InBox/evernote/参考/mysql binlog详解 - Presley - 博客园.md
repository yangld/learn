
# [mysql binlog详解](https://www.cnblogs.com/Presley-lpc/p/9619571.html)

一、初步了解binlog

　　1、MySQL的二进制日志binlog可以说是MySQL最重要的日志，它记录了所有的DDL和DML语句（除了数据查询语句select）,以事件形式记录，还包含语句所执行的消耗的时间，MySQL的二进制日志是事务安全型的。

　　　　a、DDL

　　　　　　----Data Definition Language 数据库定义语言 

　　　　　　主要的命令有create、alter、drop等，ddl主要是用在定义或改变表(table)的结构,数据类型，表之间的连接和约束等初始工作上，他们大多在建表时候使用。

　　　　b、DML

　　　　　　----Data Manipulation Language 数据操纵语言

　　　　　　主要命令是slect,update,insert,delete,就像它的名字一样，这4条命令是用来对数据库里的数据进行操作的语言

　　2、mysqlbinlog常见的选项有一下几个：

　　　　a、--start-datetime：从二进制日志中读取指定等于时间戳或者晚于本地计算机的时间

　　　　b、--stop-datetime：从二进制日志中读取指定小于时间戳或者等于本地计算机的时间 取值和上述一样

　　　　c、--start-position：从二进制日志中读取指定position 事件位置作为开始。

　　　　d、--stop-position：从二进制日志中读取指定position 事件位置作为事件截至

　　3、一般来说开启binlog日志大概会有1%的性能损耗。

　　4、binlog日志有两个最重要的使用场景。

　　　　a、mysql主从复制：mysql replication在master端开启binlog,master把它的二进制日志传递给slaves来达到master-slave数据一致的目的。

　　　　b、数据恢复：通过mysqlbinlog工具来恢复数据。

　　　　　　binlog日志包括两类文件：

　　　　　　1)、二进制日志索引文件(文件名后缀为.index)用于记录所有的二进制文件。

　　　　　　2)、二进制日志文件(文件名后缀为.00000\*)记录数据库所有的DDL和DML(除了数据查询语句select)语句事件。

二、开启binlog日志

　　1、编辑打开mysql配置文件/application/mysql3307/my.cnf在

　　　　\[mysqld\]区块添加

　　　　log-bin=mysql-bin(也可指定二进制日志生成的路径，如：log-bin=/opt/Data/mysql-bin)
　　　　server-id=1

　　　　binlog\_format=MIXED(加入此参数才能记录到insert语句)

　　2、重启mysqld服务

　　　　/application/mysql3307/bin/mysqladmin -uroot -S /application/mysql3307/logs/mysql.sock -p shutdown

　　　　nohup /application/mysql3307/bin/mysqld\_safe --defaults-file=/application/mysql3307/my.cnf --user=mysql &

　　3、查看binlog日志是否开启

　　　　mysql> show variables like 'log\_%'; 

　　　　![[1414258-20180910150727415-1015390112.png]]

三、常用的binlog日志操作命令

　　1、查看所有binlog日志列表

　　　　show master logs;

　　　　![[1414258-20180910150911389-1398860498.png]]

　　2、查看master状态，即最后（最新）一个binlog日志的编号名称，及其最后一个操作事件pos结束点(Position)值。

　　　　show master status;

　　　　![[1414258-20180910171026280-1049764479.png]]

　　3、flush 刷新log日志，自此刻开始产生一个新编号的binlog日志文件;

　　　　flush logs;

　　　　　　注意：每当mysqld服务重启时，会自动执行此命令，刷新binlog日志；在mysqlddump备份数据时加-F选项也会刷新binlog日志；

　　4、重置（清空）所有binlog日志

　　　　reset master;

四、查看binlog日志内容，常用有两种方式：

　　1、使用mysqlbinlog自带查看命令法

　　　　注意：

　　　　　　a、binlog是二进制文件，普通文件查看器cat、more、vim等都无法打开，必须使用自带的mysqlbinlog命令查看。

　　　　　　b、binlog日志与数据库文件在同目录中。

　　　　　　c、在Mysql5.5以下版本使用mysqlbinlog命令时如果报错，就加上"--no-defaults"选项

　　　　　　d、使用mysqlbinlog命令查看binlog日志内容，下面截取其中的一个片段分析分析：

　　　　　　　　![[1414258-20180910173629464-1243321061.png]]

　　　　　　　　解释：

　　　　　　　　　　server id 1:数据库主机的服务号

　　　　　　　　　　end\_log\_pos 796 :sql结束时的pos节点

　　　　　　　　　　thread\_id=11:线程号

　　　　　　e、也可根据时间点查看

　　　　　　　　/home/software/mysql-5.1.72-linux-x86\_64-glibc23/bin/mysqlbinlog --no-defaults mysql-bin.000720 --start-datetime="2018-09-12 18:45:00" --stop-datetime="2018-09-12:18:47:00"

　　2、上面这种办法读取出binlog日志的全文内容比较多，不容易分辨查看到pos点信息，下面介绍一种更为方便的查询命令：

　　　　mysql> show binlog events \[IN 'log\_name'\] \[FROM pos\] \[LIMIT \[offset,\] row\_count\];

　　　　参数解释：

　　　　　　a、IN 'log\_name':指定要查询的binlog文件名（不指定就是第一个binlog文件）

　　　　　　b、FROM pos:指定从哪个pos起始点开始查起（不指定就是从整个文件首个pos点开始算）

　　　　　　c、LIMIT【offset】：偏移量(不指定就是0)

　　　　　　d、row\_count :查询总条数（不指定就是所有行）

　　　　　　![[1414258-20180911102458325-913289497.png]]

　　2、上面这条语句可以将指定的binlog日志文件，分成有效事件行的方式返回，并可使用limit指定pos点的起始偏移，查询条数！

　　　　a、查询第一个最早的binlog日志：

　　　　　　show binlog events\\G;

　　　　b、指定查询mysql-bin.000002这个文件

　　　　　　show binlog events in 'mysql-bin.000002'\\G;

　　　　c、指定查询mysql-bin.000002这个文件，从pos点:624开始查起：

　　　　　　show binlog events in 'mysql-bin.000002' from 624\\G;

　　　　d、指定查询mysql-bin.000002这个文件，从pos点:624开始查起，查询10条（即10条语句）

　　　　　　show binlog events in 'mysql-bin.000002' from 624 limit 10\\G;

　　　　e、指定查询 mysql-bin.000002这个文件，从pos点:624开始查起，偏移2行（即中间跳过2个）查询10条（即10条语句）。

　　　　　　show binlog events in 'mysql-bin.000002' from 624 limit 2,10\\G;

五、利用binlog日志恢复mysql数据

　　1、以下对ops库的member表进行操作，并且再创建一个库ops1

　　　　create database ops;　

　　　　create database ops1;

　　　　use ops;

　　　　CREATE TABLE IF NOT EXISTS \`member\` (\`id\` int(10) unsigned NOT NULL AUTO\_INCREMENT,\`name\` varchar(16) NOT NULL,\`sex\` enum('m','w') NOT NULL DEFAULT 'm',\`age\` tinyint(3) unsigned NOT NULL,\`classid\` char(6) DEFAULT NULL,PRIMARY KEY (\`id\`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

　　　　show tables;

　　　　use ops1;

　　　　CREATE TABLE IF NOT EXISTS \`member\` (\`id\` int(10) unsigned NOT NULL AUTO\_INCREMENT,\`name\` varchar(16) NOT NULL,\`sex\` enum('m','w') NOT NULL DEFAULT 'm',\`age\` tinyint(3) unsigned NOT NULL,\`classid\` char(6) DEFAULT NULL,PRIMARY KEY (\`id\`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

　　　　show tables;

　　　　事先插入两条数据：

　　　　use ops;

　　　　insert into member(\`name\`,\`sex\`,\`age\`,\`classid\`) values('wangshibo','m',27,'cls1'),('guohuihui','w',27,'cls2');

　　　　use ops1;

　　　　insert into member(\`name\`,\`sex\`,\`age\`,\`classid\`) values('wangshibo','m',27,'cls1'),('guohuihui','w',27,'cls2');

　　2、下面开始进行场景模拟：

　　　　a、ops库会在每天凌晨四点进行一次完全备份的定时计划任务，如下：

　　　　　　0 4 \* \* \* /application/mysql3306/bin/mysqldump -uroot -S  /application/mysql3306/logs/mysql.sock -p123456 -B -F -R -x --master-data=2 ops ops1|gzip >/application/data/backup/ops\_$(date +%F).sql.gz这里我们可以手动执行一下

　　　　b、参数说明：

　　　　　　-B:指定数据库

　　　　　　-F:刷新日志

　　　　　　-R:备份存储过程等

　　　　　　-x:锁表

　　　　　　--master-data:在备份语句里添加CHANGE MASTER语句以及binlog文件及位置点信息。

　　　　　　待到数据库备份完成，就不用担心数据丢失了，因为有完全备份数据在,由于上面在全备份的时候使用了-F选项，那么当数据备份操作刚开始的时候系统就会自动刷新log,这样就会自动产生一个新的binlog日志，这个新的binlog日志就会用来记录备份之后的数据库'增删改操作'。

　　　　　查看一下：

　　　　　　　　![[1414258-20180911135224229-1320069744.png]]

　　　　　　也就是说，mysql-bin.000003是用来记录4:00之后对数据库的所有'增删改操作'。

　　3、早上九点上班了，由于业务的需求会对数据库进行各种'增删改'操作。

　　　　比如：在ops库下和ops1库下member表内插入、修改了数据等等：

　　　　先是早上进行插入数据：

　　　　　　insert into ops.member(\`name\`,\`sex\`,\`age\`,\`classid\`) values('yiyi','w',20,'cls1'),('xiaoer','m',22,'cls3'),('zhangsan','w',21,'cls5'),('lisi','m',20,'cls4'),('wangwu','w',26,'cls6');

　　　　　　insert into ops1.member(\`name\`,\`sex\`,\`age\`,\`classid\`) values('yiyi','w',20,'cls1'),('xiaoer','m',22,'cls3'),('zhangsan','w',21,'cls5'),('lisi','m',20,'cls4'),('wangwu','w',26,'cls6');

　　　　　　![[1414258-20180911141101996-1609260607.png]]

 　　4、中午又执行了修改数据库操作：

　　　　update ops.member set name='李四' where id=4;

　　　　update ops1.member set name='李四' where id=4;

　　　　update ops.member set name='小二' where id=2;

　　　　update ops1.member set name='小二' where id=2;

　　　　　　![[1414258-20180911141204845-2076829866.png]]

　　5、在下午18:00的时候，悲剧莫名其妙的出现了！

　　　　手贱执行了drop语句，直接删除了ops1库！吓尿！

　　　　　　drop database ops;

　　　　　　drop database ops1;

　　　　再手残又创建了一个数据库ops2并插入数据

　　　　　　create database ops2;

　　　　　　use ops2;

　　　　　　CREATE TABLE IF NOT EXISTS \`member\` (\`id\` int(10) unsigned NOT NULL AUTO\_INCREMENT,\`name\` varchar(16) NOT NULL,\`sex\` enum('m','w') NOT NULL DEFAULT 'm',\`age\` tinyint(3) unsigned NOT NULL,\`classid\` char(6) DEFAULT NULL,PRIMARY KEY (\`id\`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

　　　　　　insert into ops2.member(\`name\`,\`sex\`,\`age\`,\`classid\`) values('yiyi','w',20,'cls1'),('xiaoer','m',22,'cls3'),('zhangsan','w',21,'cls5'),('lisi','m',20,'cls4'),('wangwu','w',26,'cls6');

　　6、这种时候，一定不要慌张!!!

　　　　先仔细查看最后一个binlog日志，并记录下关键的pos点，到底是哪个pos点的操作导致了数据库的破坏（通常在最后几步）；

　　　　a、先备份一下最后一个binlog日志文件：

　　　　　　cd /application/mysql3306/mysql\_data

　　　　　　cp -v mysql-bin.000004  /application/data/backup/

　　　　　　ls  /application/data/backup/

　　　　　　　　![[1414258-20180911142934034-925087939.png]]

　　　　b、接着执行一次刷新日志索引操作，重新开始新的binlog日志记录文件。按理说mysql-bin.000004这个文件不会再有后续写入了，因为便于我们分析原因及查找ops节点，以后所有数据库操作都会写入到下一个日志文件。

　　　　　　flush logs;

　　　　　　show master status;

　　　　　　　　![[1414258-20180911143432140-1488427468.png]]

　　7、读取binlog日志的方法上面已经说到。

　　　　a、方法一：使用mysqlbinlog读取binlog日志：

　　　　　　/application/mysql3306/bin/mysqlbinlog /application/mysql3306/mysql\_data/mysql-bin.000004

　　　　b、登录服务器，并查看（推荐此种方法）

　　　　　　show binlog events in 'mysql-bin.000003';

　　　　　　![[1414258-20180912112238857-1157387333.png]]

　　　　c、或者:

　　　　　　show binlog events in 'mysql-bin.000004'\\G;

　　　　　　![[1414258-20180912112403168-1057829085.png]]

　　　　　　通过分析，造成库ops数据破坏的pos点区间是介于3064-3153之间（这是按照日志区间的pos节点算的），造成库ops1库破坏的pos区间是介于3218-3310之间，只要恢复到相应pos点之前就可以了。

　　8、先把凌晨4点全备的数据恢复（建议另起一个库，等恢复成功后再替换掉当前库即可）

　　　　cd  /application/data/backup/

　　　　gzip -d ops\_2018-09-11.sql.gz

　　　　/application/mysql3307/bin/mysql -uroot -S /application/mysql3307/logs/mysql.sock -p123456 <ops\_2018-09-11.sql

　　　　这样就恢复了截止凌晨4:00前的备份数据了

　　　　![[1414258-20180911150414881-412984360.png]]

　　　　但是这仅仅只是恢复了当天凌晨4点之前的数据，在4:00--18:00之间的数据还没有恢复回来！！怎么办呢？莫慌！这可以根据前面提到的mysql-bin.000004的新binlog日志进行恢复。

　　9、从binlog日志恢复数据

　　　　a、恢复命令的语法格式：

　　　　　　mysqlbinlog mysql-bin.0000xx | mysql -u用户名 -p密码 数据库名

　　　　b、常用参数选项解释：

　　　　　　--start-position=875 起始pos点
　　　　　　--stop-position=954 结束pos点
　　　　　　--start-datetime="2016-9-25 22:01:08" 起始时间点
　　　　　　--stop-datetime="2019-9-25 22:09:46" 结束时间点
　　　　　　--database=ops指定只恢复ops数据库(一台主机上往往有多个数据库，只限本地log日志)

　　　　c、不常用选项：

　　　　　　-u --user=name 连接到远程主机的用户名

　　　　　　-p --password\[=name\]连接到远程主机的密码

　　　　　　-h --host=name 从远程主机上获取binlog日志

　　　　　　--read-from-remote-server从某个Mysql服务器上读取binlog日志

　　　　d、小结：实际是将读出的binlog日志内容，通过管道符传递给myslq命令。这些命令，文件尽量写成绝对路径；

　　　　e、完全恢复（需要手动vim编辑mysql-bin.000003，将那条drop语句剔除掉）(此方法测试未通过)

　　　　　　/application/mysql3306/bin/mysqlbinlog /application/mysql3306/mysql\_data/mysql-bin.000004 | /application/mysql3307/bin/mysql -uroot -S /application/mysql3307/logs/mysql.sock -p123456 -v ops

　　　　f、指定pos结束点恢复（部分恢复）：

　　　　　　/application/mysql3306/bin/mysqlbinlog --stop-position=3064 --database=ops  /application/mysql3306/mysql\_data/mysql-bin.000002 | /application/mysql3307/bin/mysql -uroot -S /application/mysql3307/logs/mysql.sock -p123456 -v(因为加了--database=ops因此不会恢复二进制日志中关于ops1库的相应操作，若也需要恢复ops1库的相应操作，则再加上--database=ops1即可)

　　　　g、指定pos点区间恢复（部分恢复）

　　　　　　在f环节我们已经恢复到了删库之前的时刻，在删库后我们还做了创建ops2库并创建了member表和增加了数据的操作，此时我们要跳过删库并且恢复到创建ops2库和创建member表的时刻可以采用区间pos点恢复：

　　　　　　![[1414258-20180912162802602-39919970.png]]

　　　　　　/application/mysql3306/bin/mysqlbinlog --start-position=3153 --stop-position=3880 /application/mysql3306/mysql\_data/mysql-bin.000002 | /application/mysql3307/bin/mysql -uroot -S /application/mysql3307/logs/mysql.sock -p123456 -v

　　　　　　h、此时后面创建的表member恢复回来了但是库ops1被删除了，因为在这中间有删除ops1库的操作，若想继续恢复后面表中插入的数据只需要以建表后的pos点为开始点即可恢复除删库之外的所有数据。　　　　　　　

　　　　　　　/application/mysql3306/bin/mysqlbinlog --start-position=3880 /application/mysql3306/mysql\_data/mysql-bin.000002 | /application/mysql3307/bin/mysql -uroot -S /application/mysql3307/logs/mysql.sock -p123456 -v

　　10、另外：也可指定时间节点区间恢复（部分恢复）：按时间恢复需要mysqlbinlog命令读binlog日志内容，找时间节点。

　　　　　　a、/application/mysql3306/bin/mysqlbinlog /application/mysql3306/mysql\_data/mysql-bin.000002　　　　　　　　![[1414258-20180912172307359-1902487854.png]]

　　　　　　　　可以看到图中每个红框下的时间两个时间点都分别为事件的开始事件和结束时间

　　　　　　　　/application/mysql3306/bin/mysqlbinlog --stop-datetime="2018-09-12 10:37:58"  /application/data/backup/mysql-bin.000002 | /application/mysql3307/bin/mysql -uroot -S /application/mysql3307/logs/mysql.sock -p123456 -v(此时stopdatetime不能写到2018-09-12 10:38:01否则会更新到drop database ops这个操作，其它时间点同此步骤)

　　　　　　　　b、跳过删库环节恢复后面数据，可以从2018-09-12 10:38:45时间开始恢复，因为删除ops1库的时间不足一秒因此可以这样干，这样干的话库ops1不会被删，不过建议最好还是从下一个时间节点为开始进行恢复,即2018-09-12 11:11:22

　　　　　　　　![[1414258-20180912184400948-574971170.png]]

　　　　　　　　/application/mysql3306/bin/mysqlbinlog --start-datetime="2018-09-12 10:38:45" /application/data/backup/mysql-bin.000002 | /application/mysql3307/bin/mysql -uroot -S /application/mysql3307/logs/mysql.sock -p123456 -v

　　　　　　c、基本原理和通过pos点恢复差不多。

六、总结：

　　所谓恢复，就是让mysql将保存在binlog日志中指定段落区间的sql语句逐个重新执行一次而已。

分类: [Mysql](https://www.cnblogs.com/Presley-lpc/category/1235213.html)

[[# | 好文要顶]] [[# | 关注我]] [[# | 收藏该文]] [[# | ![[8知识管理/InBox/evernote/参考/_resources/mysql_binlog详解_-_Presley_-_博客园.resources/icon_weibo_24.png]]]] [[# | ![[8知识管理/InBox/evernote/参考/_resources/mysql_binlog详解_-_Presley_-_博客园.resources/wechat.png]]]]

[![[20180804164525.png]]](https://home.cnblogs.com/u/Presley-lpc/)
[Presley](https://home.cnblogs.com/u/Presley-lpc/)
[关注 - 5](https://home.cnblogs.com/u/Presley-lpc/followees/)
[粉丝 - 27](https://home.cnblogs.com/u/Presley-lpc/followers/)

[[# | +加关注]]

2
0

[«](https://www.cnblogs.com/Presley-lpc/p/9549162.html) 上一篇： [Nginx 关键字详解](https://www.cnblogs.com/Presley-lpc/p/9549162.html)
[»](https://www.cnblogs.com/Presley-lpc/p/9622683.html) 下一篇： [Python hashlib、hmac加密模块](https://www.cnblogs.com/Presley-lpc/p/9622683.html)

posted @ 2018-09-10 14:45  [Presley](https://www.cnblogs.com/Presley-lpc/)  阅读(28094)  评论(3)  [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=9619571)  [[# | 收藏]]

    Created at: 2021-01-11T13:56:44+08:00
    Updated at: 2021-01-11T13:56:44+08:00


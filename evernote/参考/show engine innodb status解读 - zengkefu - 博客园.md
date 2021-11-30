
# xiaoboluo768

**注：以下内容为根据《高性能mysql第三版》和《mysql技术内幕innodb存储引擎》的innodb status部分的个人理解，如果有错误，还望指正！！**
innodb存储引擎在show engine innodb status（老版本对应的是show innodb status）输出中，显示除了大量的内部信息，它输出就是一个单独的字符串，没有行和列，内容分为很多小段，每一段对应innodb存储引擎不同部分的信息，其中有一些信息对于innodb开发者来说非常有用，但是，许多信息，如果你尝试去理解，并且应用到高性能innodb调优的时候，你会发现它们非常有趣，甚至是非常有必要的。
输出内容中包含了一些平均值的统计信息，这些平均值是自上次输出结果生成以来的统计数，因此，如果你正在检查这些值，那就要确保已经等待了至少30s的时间，使两次采样之间的积累足够长的统计时间并多次采样，检查计数器变化从而弄清其行为，并不是所有的输出都会在一个时间点上生成，因而也不是所有的显示出来的平均值会在同一时间间隔里重新再计算。而且，innodb有一个内部复位间隔，而它是不可预知的，各个版本也不一样。
这些输出信息足够提供给手工计算出大多数你想要的统计信息，有一款监控工具innotop可以帮你计算出增量差值和平均值。下面，在你的mysql命令行敲下show engine innodb status;看着输出跟着下面的步骤一步一步理解输出信息是什么含义：
**注意：以下使用mysql5.5.24版本做解读，mysql5.6.x和5.7.x输出内容有些地方有调整。**
1.第一段是头部信息，它仅仅声明了输出的开始，其内容包括当前的日期和时间，以及自上次输出以来经过的时长。
\=====================================
160129 12:07:26 INNODB MONITOR OUTPUT **#第二行是当前日期和时间**
\=====================================
Per second averages calculated from the last 24 seconds **#第四行显示的是计算出这一平均值的时间间隔，即自上次输出以来的时间，或者是距上次内部复位的时长**
2.从innodb1.0.x开始，可以使用命令show engine innodb status;来查看master thread的状态信息:
\-----------------
BACKGROUND THREAD
\-----------------
srv\_master\_thread loops: 30977173 1\_second, 30975685 sleeps, 3090359 10\_second, 166112 background, 165988 flush **#这行显示主循环进行了30977173 1\_second次，每秒挂起的操作进行了30975685 sleeps次（说明负载不是很大），10秒一次的活动进行了3090359 10\_second次，1秒循环和10秒循环比值符合1：10，backgroup loop进行了166112 background次，flush loop进行了165988 flush次，如果在一台很大压力的mysql上，可能看到每秒运行次数和挂起次数比例小于1很多，这是因为innodb对内部进行了一些优化，当压力大时间隔时间并不总是等待1秒，因此，不能认为每秒循环和挂起的值总是相等，在某些情况下，可以通过两者之间的差值来比较反映当前数据库的负载压力。**
srv\_master\_thread log flush and writes: 31160103
3.如果有高并发的工作负载，你就要关注下接下来的段（SEMAPHORES信号量）,它包含了两种数据：事件计数器以及可选的当前等待线程的列表，如果有性能上的瓶颈，可以使用这些信息来找出瓶颈，不幸的是，想知道怎么使用这些信息还是有一点复杂，下面先给出一些解释：
\----------
SEMAPHORES
\----------
OS WAIT ARRAY INFO: reservation count 68581015, signal count 218437328 
\--Thread 140653057947392 has waited at btr0pcur.c line 437 for 0.00 seconds the semaphore:
S-lock on RW-latch at 0x7ff536c7d3c0 created in file buf0buf.c line 916
a writer (thread id 140653057947392) has reserved it in mode exclusive
number of readers 0, waiters flag 1, lock\_word: 0
Last time read locked in file row0sel.c line 3097
Last time write locked in file /usr/local/src/soft/mysql-5.5.24/storage/innobase/buf/buf0buf.c line 3151
\--Thread 140653677291264 has waited at btr0pcur.c line 437 for 0.00 seconds the semaphore:
S-lock on RW-latch at 0x7ff53945b240 created in file buf0buf.c line 916
a writer (thread id 140653677291264) has reserved it in mode exclusive
number of readers 0, waiters flag 1, lock\_word: 0
Last time read locked in file row0sel.c line 3097
Last time write locked in file /usr/local/src/soft/mysql-5.5.24/storage/innobase/buf/buf0buf.c line 3151
Mutex spin waits 1157217380, rounds 1783981614, OS waits 10610359
RW-shared spins 103830012, rounds 1982690277, OS waits 52051891
RW-excl spins 43730722, rounds 602114981, OS waits 3495769
Spin rounds per wait: 1.54 mutex, 19.10 RW-shared, 13.77 RW-excl
内容比较多，下面分段依次解释：
3.1.
OS WAIT ARRAY INFO: reservation count 68581015, signal count 218437328 **#这行给出了关于操作系统等待数组的信息，它是一个插槽数组，innodb在数组里为信号量保留了一些插槽，操作系统用这些信号量给线程发送信号，使线程可以继续运行，以完成它们等着做的事情，这一行还显示出innodb使用了多少次操作系统的等待：保留统计（reservation count）显示了innodb分配插槽的频度，而信号****计数（signal count）衡量的是线程通过数组得到信号的频度，操作系统的等待相对于空转等待（spin wait）要昂贵些。**
3.2.
\--Thread 140653057947392 has waited at btr0pcur.c line 437 for 0.00 seconds the semaphore:
S-lock on RW-latch at 0x7ff536c7d3c0 created in file buf0buf.c line 916
a writer (thread id 140653057947392) has reserved it in mode exclusive
number of readers 0, waiters flag 1, lock\_word: 0
Last time read locked in file row0sel.c line 3097
Last time write locked in file /usr/local/src/soft/mysql-5.5.24/storage/innobase/buf/buf0buf.c line 3151
\--Thread 140653677291264 has waited at btr0pcur.c line 437 for 0.00 seconds the semaphore:
S-lock on RW-latch at 0x7ff53945b240 created in file buf0buf.c line 916
a writer (thread id 140653677291264) has reserved it in mode exclusive
number of readers 0, waiters flag 1, lock\_word: 0
Last time read locked in file row0sel.c line 3097
Last time write locked in file /usr/local/src/soft/mysql-5.5.24/storage/innobase/buf/buf0buf.c line 3151
**这部分显示的是当前正在等待互斥量的innodb线程，在这里可以看到有两个线程正在等待，每一个都是以--Thread <数字> has waited...开始，这一段内容在正常情况下应该是空的（即查看的时候没有这部分内容），除非服务器运行着高并发的工作负载，促使innodb采取让操作系统等待的措施，除非你对innodb源码熟悉，否则这里看到的最有用的信息就是发生线程等待的代码文件名 /usr/local/src/soft/mysql-5.5.24/storage/innobase/buf/buf0buf.c line 3151。**
在innodb内部哪里才是热点？举例来说，如果看到许多线程都在一个名为buf0buf.c的文件上等待，那就意味着你的系统里存在着
缓冲池竞争，这个输出信息还显示了这些线程等待了多少时间，其中waiters flag显示了有多少个等待着正在等待同一个互斥量。 如果waiters flag为0那就表示没有线程在等待同一个互斥量（此时在waiters flag 0后面可能可以看到wait is ending，表示这个互斥量已经被释放了，但操作系统还没有把线程调度过来运行）。
你可能想知道innodb真正等待的是什么，innodb使用了互斥量和信号量来保护代码的临界区，如：限定每次只能有一个线程进入临界区，或者是当有活动的读时，就限制写入等。在innodb代码里有很多临界区，在合适的条件下，它们都可能出现在那里，常常能见到的一种情形是：获取缓冲池分页的访问权的时候。
3.3.
在等待线程之后的部分信息如下，这部分显示了更多的事件计数器，在每一个情形中，都能看到innodb依靠操作系统等待的频度：
Mutex spin waits 1157217380, rounds 1783981614, OS waits 10610359 **#这行显示的是跟互斥量相关的几个计数器**
RW-shared spins 103830012, rounds 1982690277, OS waits 52051891 **#这行显示读写的共享锁的计数器**
RW-excl spins 43730722, rounds 602114981, OS waits 3495769 **#这行显示读写的排他锁的计数器**
Spin rounds per wait: 1.54 mutex, 19.10 RW-shared, 13.77 RW-excl
innodb有着一个多阶段等待的策略，首先，它会试着对锁进行空转等待，如果经历了一个预设的空转等待周期（设置innodb\_sync\_spin\_loops配置变量命令）之后还没有成功，那就会退到更昂贵更复杂的等待数组中。
空转等待的成本相对较低，但是它们要不停地检查一个资源能否被锁定，这种方式会消耗CPU周期，但是，这没有听起来那么糟糕，因为当处理器在等待IO时，一般都有一些空闲的CPU周期可用，即使是没有空闲的CPU周期，空等也要比其他方式更加廉价一些。然而，当另外一个线程能做一些事情的时候，空转等待也还会把CPU独占着。
空转等待的替代方案就是让操作系统做上下文切换，这样，当一个线程在等待时，另外一个线程就可以被运行，然后，通过等待数组里的信号量发出信号，唤醒那个沉睡的线程，通过信号量来发送信号是比较有效的，但是上下文切换就很昂贵，这很快就会积少成多，每秒钟几千次的切换会引发大量的系统开销。
你可以通过修改innodb\_sync\_spin\_loops的值，试着在空转等待与操作系统等待之间达成平衡，不要担心空转等待，除非你在一秒里看到几十万个空转等待。此时，你可以考虑performance\_schema库或者show engine innodb mutex;查看下相关信息。
4.下面这一段外键错误的信息一般不会出现，除非你服务器上发生了外键错误，有时问题在于事务在插入，更新或删除一条记录时要寻找父表或子表，还有时候是当innodb尝试增加或删除一个外键或者修改一个已经存在的外键时，发现表之间类型不匹配，这部分输出对于调试与innodb不明确的外键错误发生的准确原因非常有帮助，下面搞一个示例来看看：
4.1 创建父表：
mysql> create table parent(parent\_id int not null,primary key(parent\_id)) engine=innodb;
4.2 创建子表：
mysql> create table child(child\_id int not null,key child\_id(child\_id),constraint i\_child foreign key(child\_id) references parent(parent\_id)) engine=innodb;
4.3 插入数据：
mysql> insert into parent(parent\_id) values(1);
mysql> insert into child(child\_id) values(1);
4.5 有两种基本的外键错误：
第一种：以某种可能违反外键约束关系的方法增加，更新，删除数据，将导致第一类错误，如，在父表中删除行时发生如下错误：
mysql> delete from parent;
ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (\`xiaoboluo\`.\`child\`, CONSTRAINT \`i\_child\` FOREIGN KEY (\`child\_id\`) REFERENCES \`parent\` (\`parent\_id\`))
错误信息相当明了，对所有由增加，删除，更新不匹配的行导致的错误都会看到相似的信息，下面是show engine innodb status的输出：
\------------------------
LATEST FOREIGN KEY ERROR
\------------------------
160128 1:17:06 Transaction: **#这行显示了最近一次外键错误的日期和时间**
TRANSACTION D203D6, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
4 lock struct(s), heap size 1248, 2 row lock(s), undo log entries 1
MySQL thread id 20027, OS thread handle 0x7f0a4c0f8700, query id 1813996 localhost root updating
delete from parent
Foreign key constraint fails for table \`xiaoboluo\`.\`child\`:
, **#上面部分显示了关于破坏外键约束的事务详情。后边部分显示了发现错误时innodb正尝试修改的准确数据，输出中有许多是转换成可打印格式的行数据**。
CONSTRAINT \`i\_child\` FOREIGN KEY (\`child\_id\`) REFERENCES \`parent\` (\`parent\_id\`)
Trying to delete or update in parent table, in index \`PRIMARY\` tuple:
DATA TUPLE: 3 fields;
0: len 4; hex 80000001; asc ;;
1: len 6; hex 000000d203d6; asc ;;
2: len 7; hex 1e000001ca0110; asc ;;
But in child table \`xiaoboluo\`.\`child\`, in index \`child\_id\`, there is a record:
PHYSICAL RECORD: n\_fields 2; compact format; info bits 0
0: len 4; hex 80000001; asc ;;
1: len 6; hex 000013a99b3e; asc >;;
4.6 第二种：尝试修改父表的表结构时发生的错误，这种错误就没有那么清楚了，这可能会让调试更困难：
mysql> alter table parent modify parent\_id int unsigned not null;
ERROR 1025 (HY000): Error on rename of './xiaoboluo/#sql-b695\_4e3b' to './xiaoboluo/parent' (errno: 150)
查看show engine innodb status输出信息：
\------------------------
LATEST FOREIGN KEY ERROR
\------------------------
160128 1:32:33 Error in foreign key constraint of table xiaoboluo/child:
there is no index in referenced table which would contain
the columns as the first columns, or the data types in the
referenced table do not match the ones in table. Constraint:
,
CONSTRAINT "i\_child" FOREIGN KEY ("child\_id") REFERENCES "parent" ("parent\_id")
The index in the foreign key in table is "child\_id"
See <http://dev.mysql.com/doc/refman/5.5/en/innodb-foreign-key-constraints.html>
for correct foreign key definition.
InnoDB: Renaming table \`xiaoboluo\`.<result 2 when explaining filename '#sql-b695\_4e3b'> to \`xiaoboluo\`.\`parent\` failed!
上面的错误是数据类型不匹配，外键列必须有完全相同的数据类型，包括任何的修饰符（如这里父表多加了一个unsigned，这也是问题所在），当看到1025错误并不理解为什么时，最好查看下innodb status。在每次看到有新错误时，外键错误信息都会被重写，percona toolkit中的pt-fk-error-logger工具可以用表保存这些信息以供后续分析。
5.与外键错误一样，这部分只有当服务器产生死锁时才会出现，死锁信息同样在每次有新的死锁错误时被重写，percona toolkit中的pt-deadlock-logger工具可以用表保存这些信息以供后续分析
死锁在等待关系图里是一个循环，就是一个锁定了行的数据结构又在等待别的锁，这个循环可以任意地大，innodb会立即检测到死锁，因为每当有事务等待行锁的时候，它都会去检查等待关系图里是否有循环，死锁的情况可能会比较复杂，但是，这一部分只显示了最近的两个死锁的情况，它们在各自的事务里执行的最后一条语句，以及它们在等待关系图里形成环锁的信息。在这个循环里你看不到其他事务，也可能看不到在事务里早先真正获得了锁的语句，尽管如此，通常还是可以通过查看这些输出结果来确定到底是什么引起了死锁。
在innodb里实际上有两种死锁，第一种就是常常碰到的那种，它在等待关系图里是一个真正的循环，另外一种就是在一个等待关系图里，因代价昂贵而无法检测它是不是包含了循环，如果innodb要在关系图里检查超过100W个锁，或者在检查过程中，innodb要重做200个以上的事务，那它会放弃，并宣布这里有一个死锁，这些数值都是硬编码在innodb代码里的常量，无法配置（如果你NB可以修改代码然后重新编译）。第二种死锁报错你可以在输出里看到一条信息：TOO DEEP OR LONG SEARCH IN THE LOCK TABLE WAITS-FOR GRAPH
innodb不仅会打印出事务和事务持有和等待的锁，而且还有记录本身，不幸的是，它至于可能超过为输出结果预留的长度（只能打印1M的内容且只能保留最近一次的死锁信息），如果你无法看到完整的输出，此时可以在任意库下创建innodb\_monitor或innodb\_lock\_monitor表，这样innodb status信息会完整且每15s一次被记录到错误日志中。如：create table innodb\_monitor(a int)engine=innodb;，不需要记录到错误日志中时就删掉这个表即可。
5.1 下面也搞一个示例来看看：
5.1.1 建表：
mysql> create table test\_deadlock(id int unsigned not null primary key auto\_increment,test int unsigned not null);
Query OK, 0 rows affected (0.02 sec)
5.1.2 插入测试数据：
mysql> insert into test\_deadlock(test) values(1),(2),(3),(4),(5);
Query OK, 5 rows affected (0.00 sec)
Records: 5 Duplicates: 0 Warnings: 0
打开两个会话终端：
5.1.3 会话1执行下面的SQL：
mysql> set autocommit=0;
Query OK, 0 rows affected (0.00 sec)
mysql> select \* from test\_deadlock where id=1 for update;
+----+------+
| id | test |
+----+------+
| 1 | 1 |
+----+------+
1 row in set (0.00 sec)
5.1.4 接着会话2执行下面的SQL：
mysql> set autocommit=0;
Query OK, 0 rows affected (0.00 sec)
mysql> select \* from test\_deadlock where id=2 for update;
+----+------+
| id | test |
+----+------+
| 2 | 2 |
+----+------+
1 row in set (0.00 sec)
5.1.5 回到会话1执行下面的SQL，会发生等待：
mysql> select \* from test\_deadlock where id=2 for update;
5.1.6 回到会话2执行下面的SQL，产生死锁，会话2被回滚：
mysql> select \* from test\_deadlock where id=1 for update;
ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
5.2 查看innodb status信息：
\------------------------
LATEST DETECTED DEADLOCK
\------------------------
160128 1:51:53 **#这里显示了最近一次发生死锁的日期和时间**
\*\*\* (1) TRANSACTION:
TRANSACTION D20847, ACTIVE 141 sec starting index read
mysql tables in use 1, locked 1
LOCK WAIT 3 lock struct(s), heap size 376, 2 row lock(s)
MySQL thread id 20027, OS thread handle 0x7f0a4c0f8700, query id 1818124 localhost root statistics
select \* from test\_deadlock where id=2 for update
\*\*\* (1) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 441 page no 3 n bits 72 index \`PRIMARY\` of table \`xiaoboluo\`.\`test\_deadlock\` trx id D20847 lock\_mode X locks rec but not gap waiting
Record lock, heap no 3 PHYSICAL RECORD: n\_fields 4; compact format; info bits 0
0: len 4; hex 00000002; asc ;;
1: len 6; hex 000000d20808; asc ;;
2: len 7; hex ad000001ab011d; asc ;;
3: len 4; hex 00000002; asc ;;
\*\*\* (2) TRANSACTION:
TRANSACTION D20853, ACTIVE 119 sec starting index read
mysql tables in use 1, locked 1
3 lock struct(s), heap size 1248, 2 row lock(s)
MySQL thread id 20081, OS thread handle 0x7f0a0f020700, query id 1818204 localhost root statistics
select \* from test\_deadlock where id=1 for update
\*\*\* (2) HOLDS THE LOCK(S):
RECORD LOCKS space id 441 page no 3 n bits 72 index \`PRIMARY\` of table \`xiaoboluo\`.\`test\_deadlock\` trx id D20853 lock\_mode X locks rec but not gap
Record lock, heap no 3 PHYSICAL RECORD: n\_fields 4; compact format; info bits 0
0: len 4; hex 00000002; asc ;;
1: len 6; hex 000000d20808; asc ;;
2: len 7; hex ad000001ab011d; asc ;;
3: len 4; hex 00000002; asc ;;
\*\*\* (2) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 441 page no 3 n bits 72 index \`PRIMARY\` of table \`xiaoboluo\`.\`test\_deadlock\` trx id D20853 lock\_mode X locks rec but not gap waiting
Record lock, heap no 2 PHYSICAL RECORD: n\_fields 4; compact format; info bits 0
0: len 4; hex 00000001; asc ;;
1: len 6; hex 000000d20808; asc ;;
2: len 7; hex ad000001ab0110; asc ;;
3: len 4; hex 00000001; asc ;;
\*\*\* WE ROLL BACK TRANSACTION (2)
这部分内容比较多，下面分段逐一进行解释：
5.2.1 下面这部分显示的是死锁的第一个事务的信息：
\*\*\* (1) TRANSACTION:
TRANSACTION D20847, ACTIVE 141 sec starting index read
mysql tables in use 1, locked 1
LOCK WAIT 3 lock struct(s), heap size 376, 2 row lock(s)
MySQL thread id 20027, OS thread handle 0x7f0a4c0f8700, query id 1818124 localhost root statistics
select \* from test\_deadlock where id=2 for update
TRANSACTION D20847, ACTIVE 141 sec starting index read：**这行表示事务D20847，ACTIVE 141 sec表示事务处于活跃状态141s，starting index read表示正在使用索引读取数据行**
mysql tables in use 1, locked 1**#这行表示事务D20847正在使用1个表，且涉及锁的表有1个**
LOCK WAIT 3 lock struct(s), heap size 376, 2 row lock(s) **#这行表示在等待3把锁，占用内存376字节，涉及2行记录，如果事务已经锁定了几行数据，这里将会有一行信息显示出锁定结构的数目（注意，这跟行锁是两回事）和堆大小，堆的大小指的是为了持有这些行锁而占用的内存大小，Innodb是用一种特殊的位图表来实现行锁的，从理论上讲，它可将每一个锁定的行表示为一个比特，经测试显示，每个锁通常不超过4比特**
MySQL thread id 20027, OS thread handle 0x7f0a4c0f8700, query id 1818124 localhost root statistics **#这行表示该事务的线程ID信息，操作系统句柄信息，连接来源、用户**
select \* from test\_deadlock where id=2 for update **#这行表示事务涉及的SQL**
5.2.2 下面这一部分显示的是当死锁发生时，第一个事务正在等待的锁等信息：
\*\*\* (1) WAITING FOR THIS LOCK TO BE GRANTED: **#这行信息表示第一个事务正在等待锁被授予**
RECORD LOCKS space id 441 page no 3 n bits 72 index \`PRIMARY\` of table \`xiaoboluo\`.\`test\_deadlock\` trx id D20847 lock\_mode X locks rec but not gap waiting
Record lock, heap no 3 PHYSICAL RECORD: n\_fields 4; compact format; info bits 0
0: len 4; hex 00000002; asc ;;
1: len 6; hex 000000d20808; asc ;;
2: len 7; hex ad000001ab011d; asc ;;
3: len 4; hex 00000002; asc ;;
RECORD LOCKS space id 441 page no 3 n bits 72 index \`PRIMARY\` of table \`xiaoboluo\`.\`test\_deadlock\` trx id D20847 lock\_mode X locks rec but not gap waiting**#这行信息表示等待的锁是一个record lock，空间id是441，页编号为3，大概位置在页的72位处，锁发生在表xiaoboluo.test\_deadlock的主键上，是一个X锁，但是不是gap lock。 waiting表示正在等待锁**
Record lock, heap no 3 PHYSICAL RECORD: n\_fields 4; compact format; info bits 0 **#这行表示record lock的heap no 位置**
**#这部分剩下的内容只对调试才有用。**
0: len 4; hex 00000002; asc ;;
1: len 6; hex 000000d20808; asc ;;
2: len 7; hex ad000001ab011d; asc ;;
3: len 4; hex 00000002; asc ;;
5.2.3 下面这部分是事务二的状态：
\*\*\* (2) TRANSACTION:
TRANSACTION D20853, ACTIVE 119 sec starting index read **#事务2处于活跃状态119s**
mysql tables in use 1, locked 1 **#正在使用1个表，涉及锁的表有1个**
3 lock struct(s), heap size 1248, 2 row lock(s) **#涉及3把锁，2行记录**
MySQL thread id 20081, OS thread handle 0x7f0a0f020700, query id 1818204 localhost root statistics
select \* from test\_deadlock where id=1 for update **#第二个事务的SQL**
5.2.4 下面这部分是事务二的持有锁信息：
\*\*\* (2) HOLDS THE LOCK(S):
RECORD LOCKS space id 441 page no 3 n bits 72 index \`PRIMARY\` of table \`xiaoboluo\`.\`test\_deadlock\` trx id D20853 lock\_mode X locks rec but not gap
Record lock, heap no 3 PHYSICAL RECORD: n\_fields 4; compact format; info bits 0
0: len 4; hex 00000002; asc ;;
1: len 6; hex 000000d20808; asc ;;
2: len 7; hex ad000001ab011d; asc ;;
3: len 4; hex 00000002; asc ;;
RECORD LOCKS space id 441 page no 3 n bits 72 index \`PRIMARY\` of table \`xiaoboluo\`.\`test\_deadlock\` trx id D20853 lock\_mode X locks rec but not gap
Record lock, heap no 3 PHYSICAL RECORD: n\_fields 4; compact format; info bits 0 **#从这两行持有锁信息计息后面几行调试信息上看，就是事务1正在等待的锁。**
5.2.5 下面这部分是事务二正在等待的锁，从下面的信息上看，等待的是同一个表，同一个索引，同一个page上的record lock X锁，但是heap no位置不同，即不同的行上的锁：
\*\*\* (2) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 441 page no 3 n bits 72 index \`PRIMARY\` of table \`xiaoboluo\`.\`test\_deadlock\` trx id D20853 lock\_mode X locks rec but not gap waiting
Record lock, heap no 2 PHYSICAL RECORD: n\_fields 4; compact format; info bits 0 
0: len 4; hex 00000001; asc ;;
1: len 6; hex 000000d20808; asc ;;
2: len 7; hex ad000001ab0110; asc ;;
3: len 4; hex 00000001; asc ;;
\*\*\* WE ROLL BACK TRANSACTION (2) #这个表示事务2被回滚，因为两个事务的回滚开销一样，所以选择了后提交的事务进行回滚，如果两个事务回滚的开销不同(undo 数量不同)，那么就回滚开销最小的那个事务。
当一个事务持有了其他事务需要的锁，同时又想获得其他事务持有的锁时，等待关系图上就会产生循环，Innodb不会显示所有持有和等待的锁，但是，它显示了足够的信息来帮你确定，查询操作正在使用哪些索引，这对于你确定能否避免死锁有极大的价值。
如果能使两个查询对同一个索引朝同一个方向进行扫描，就能降低死锁的数目，因为，查询在同一个顺序上请求锁的时候不会创建循环，有时候，这是很容易做到的，如：要在一个事务里更新许多条记录，就可以在应用程序的内存里把它们按照主键进行排序，然后，再用同样的顺序更新到数据库里，这样就不会有死锁发生，但是在另一些时候，这个方法也是行不通的（如果有两个进程使用了不同的索引区间操作同一张表的时候）。
6\. 下面这部分包含了一些关于innodb事务的总结信息，紧随其后的是当前活跃事务列表，如：
\------------
TRANSACTIONS
\------------
Trx id counter 4E0132AD
Purge done for trx's n:o < 4E01090B undo n:o < 0
History list length 1853
LIST OF TRANSACTIONS FOR EACH SESSION:
\---TRANSACTION 4E0131D3, not started
MySQL thread id 26208218, OS thread handle 0x7fec7c582700, query id 5274800318 10.207.162.69 gdsser
\---TRANSACTION 4E01323F, not started
MySQL thread id 26208217, OS thread handle 0x7fec7c1b3700, query id 5274800938 10.207.162.69 gdsser
....................
\---TRANSACTION 4E0132AC, ACTIVE 0 sec preparing
2 lock struct(s), heap size 376, 1 row lock(s), undo log entries 1
MySQL thread id 26208200, OS thread handle 0x7fec567e0700, query id 5274801557 10.207.162.69 gdsser
commit
\---TRANSACTION 4E0110E7, ACTIVE 188 sec
mysql tables in use 1, locked 0
MySQL thread id 26208154, OS thread handle 0x7fec7c235700, query id 5274800671 10.143.90.228 root Sending data
SELECT /\*!40001 SQL\_NO\_CACHE \*/ \* FROM \`m\_flowskillpoint\`
Trx read view will not see trx with id >= 4E0110E8, sees < 4E0108EE
\---TRANSACTION 4E0108EF, ACTIVE 233 sec fetching rows
mysql tables in use 1, locked 0
MySQL thread id 26208131, OS thread handle 0x7fec578e3700, query id 5274801341 10.143.90.228 root Sending data
SELECT /\*!40001 SQL\_NO\_CACHE \*/ \* FROM \`m\_flowsilver\`
Trx read view will not see trx with id >= 4E0108F0, sees < 4E0108EC
\---TRANSACTION 4E0108EE, ACTIVE 233 sec fetching rows
mysql tables in use 1, locked 0
MySQL thread id 26208132, OS thread handle 0x7fec7c78a700, query id 5274797797 10.143.90.228 root Sending data
SELECT /\*!40001 SQL\_NO\_CACHE \*/ \* FROM \`m\_flowmail\`
Trx read view will not see trx with id >= 4E0108EF, sees < 4E0108EC
这部分内容比较多，下面分段逐一进行解释：
6.1.
Trx id counter 4E0132AD **#这行表示当前事务ID，这是一个系统变量，每创建一个新事务都会增加**
Purge done for trx's n:o < 4E01090B undo n:o < 0 **#这是innodb清除旧MVCC行时所用的事务ID，将这个值和当前事务ID进行比较，就可以知道有多少老版本的数据未被清除。这个数字多大才可以安全的取值没有硬性和速成的规定，如果数据没做过任何更新，那么一个巨大的数字也不意味着有未清除的数据，因为实际上所有事务在数据库里查看的都是同一个版本的数据（此时只是事务ID在增加，而数据没有变更），另一方面，如果有很多行被更新，那每一行就会有一个或多个版本留在内存里，减少此类开销的最好办法就是确保事务已完成就立即提交，不要让它长时间地处于打开状态，因为一个打开的事务即使不做任何操作，也会影响到innodb清理旧版本的行数据。 undo n:o < 0这个是innodb清理进程正在使用的撤销日志编号，为0 0时说明清理进程处于空闲状态。**
History list length 1853 **#历史记录的长度，即位于innodb数据文件的撤销空间里的页面的数目，如果事务执行了更新并提交，这个数字就会增加，而当清理进程移除旧版本数据时，它就会减少，清理进程也会更新Purge done for.....这行中的数值。**
6.2.
头部信息之后就是一个事务列表，当前版本的mysql还不支持嵌套事务，因此，在某个时间点上，每个客户端连接能够拥有的事务数量是有一个上限的，而且每一个事务只能属于单一连接（即一个事务只能使用单个线程执行，不能使用多个线程）。在输出信息里，每一个事务至少占有两行内容，如：
\---TRANSACTION 4E0131D3, not started **#每个事务的第一行以事务的ID和状态开始，not started表示这个事务已经提交并且没有再发起影响事务的语句，可能刚好空闲**
MySQL thread id 26208218, OS thread handle 0x7fec7c582700, query id 5274800318 10.207.162.69 gdsser**#然后每个事务的第二行是一些线程等信息，MySQL thread id <数字>部分和是hi用show full processlist;命令看到的id列相同。紧随其后的是一个内部查询id和一些连接信息，这些信息同样与show full processlist中的输出相同。**
\---TRANSACTION 4E01323F, not started
MySQL thread id 26208217, OS thread handle 0x7fec7c1b3700, query id 5274800938 10.207.162.69 gdsser
6.3.
上面是not started状态的事务信息，下面来看看为ACTIVE状态的事务信息：
\---TRANSACTION 4E0110E7, ACTIVE 188 sec **#这行显示次事务处于活跃状态已经188s，可能的所有状态有not started，active，prepared和committed in memory，一旦事务日志落盘了就会变成not started状态。在时间后面会显示出当前事务正在做什么（在这里为空没有显示出来），在源代码中有超过30个字符串常量可以显示在时间后面，如：fetching，preparing，rows，adding foreign keys等等**
mysql tables in use 1, locked 0 **#该事务用到的表数和涉及表锁的表数，Innodb一般不会锁定表，但对有些语句会锁定，如果mysql服务器在高于innodb层之上将表锁定，这里也是能够显示出来的，如果事务已经锁定了几行数据，这里将会有一行信息显示出锁定结构的数目（注意，这跟行锁是两回事）和和堆大小，如：2 lock struct(s), heap size 376, 1 row lock(s), undo log entries 1，堆的大小指的是为了持有这些行锁而占用的内存大小，Innodb是用一种特殊的位图表来实现行锁的，从理论上讲，它可将每一个锁定的行表示为一个比特，经测试显示，每个锁通常不超过4比特。**
MySQL thread id 26208154, OS thread handle 0x7fec7c235700, query id 5274800671 10.143.90.228 root Sending data **#与show processlist输出结果大部分相同**
SELECT /\*!40001 SQL\_NO\_CACHE \*/ \* FROM \`m\_flowskillpoint\` **#如果事务正在运行一个查询，那么这里就会显示事务涉及的SQL，注意：有些版本可能只显示其中一小段，而不是完整的SQL**
Trx read view will not see trx with id >= 4E0110E8, sees < 4E0108EE **#这行显示了事务的读视图，它表明了因为版本关系而产生的对于事务可见和不可见两种类型的事务ID的范围，在这里，两个数字之间有一个事务的间隙，这个间隙里的事务可能是不可见的，innodb在执行查询时，对于那些事务ID正好在这个间隙的行，还会检查其可见性。**
注：如果事务正在等待一个锁，那么在查询SQL文本后面将可以看到这个锁的信息，在上文的死锁例子里，这样的信息看到过很多了，不幸的是，输出信息并没有说出这个锁正被其他哪个事务持有，不过可以通过information\_schema库下的innodb\_trx，innodb\_lock\_waits，innodb\_locks三个表来查明这一点。如果输出信息里有很多个事务，innodb可能会限制要打印出来的事务数目，以免输出信息增长得太大，这时就会看到...truncated...提示。
7.FILE I/O部分显示的是I/O辅助线程的状态，还有性能计数器的状态，如下：
\--------
FILE I/O
\--------
I/O thread 0 state: waiting for i/o request (insert buffer thread) **#insert buffer thread**
I/O thread 1 state: waiting for i/o request (log thread) **#log thread**
I/O thread 2 state: waiting for i/o request (read thread)
I/O thread 3 state: waiting for i/o request (read thread)
I/O thread 4 state: waiting for i/o request (read thread)
I/O thread 5 state: doing file i/o (read thread) ev set **#以上为默认的4个read thread**
I/O thread 6 state: waiting for i/o request (write thread)
I/O thread 7 state: waiting for i/o request (write thread)
I/O thread 8 state: waiting for i/o request (write thread)
I/O thread 9 state: waiting for i/o request (write thread) **#以上为默认的4个write thread**
Pending normal aio reads: 128 \[0, 0, 0, 128\] , aio writes: 0 \[0, 0, 0, 0\] , **#读线程和写线程挂起操作的数目等，aio的意思是异步I/O**
ibuf aio reads: 0, log i/o's: 0, sync i/o's: 0 **#insert buffer thread挂起的fsync()操作数目等**
Pending flushes (fsync) log: 0; buffer pool: 0 **#log thread挂起的fsync()操作数目等**
146246831 OS file reads, 760501349 OS file writes, 247143684 OS fsyncs **#这行显示了读，写和fsync()调用执行的数目，在你的机器环境负载下这些绝对值可能会有所不同，因此更重要的是监控它们过去一段时间内是如何改变的。**
1 pending preads, 0 pending pwrites **#这行显示了当前被挂起的读和写操作数**
145.49 reads/s, 783677 avg bytes/read, 28.75 writes/s, 10.67 fsyncs/s **#这行显示了在头部显示的时间（指的是第1部分的时间）段内的每秒平均值。**
注：三行挂起读写线程、缓冲池线程、日志线程的统计信息的值是检测I/O受限的应用的一个好方法，如果这些I/O大部分有挂起操作，那么负载可能I/O受限。在linux系统下使用参数：innodb\_read\_io\_threads和innodb\_write\_io\_threads两个变量来配置读写线程的数量，默认为各4个线程。
insert buffer thread：负责插入缓冲合并，如：记录被从插入缓冲合并到表空间中
log thread：负责异步刷事务日志
read thread：执行预读操作以尝试预先读取innodb预感需要的数据
write thread：刷新脏页缓冲
8.这部分显示了insert buffer和adaptive hash index两个部分的结构的状态
\-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
\-------------------------------------
Ibuf: size 12, free list len 27559, seg size 27572, 18074934 merges **#这行显示了关于size（size 12代表了已经合并记录页的数量）、free list（代表了插入缓冲中空闲列表长度）和seg size大小（seg size 27572显示了当前insert buffer的长度，大小为27572\*16K=440M左右）的信息。18074934 merges代表合并插入的次数**
merged operations: **#这个标签****下的一行信息insert，delete mark，delete分别表示merge操作合并了多少个insert buffer，delete buffer，purge buffer**
insert 81340470, delete mark 8893610, delete 818579
discarded operations: **#这个标签下的一行信息表示当change buffer发生merge时表已经被删除了，就不需要再将记录合并到辅助索引中了**
insert 0, delete mark 0, delete 0
Hash table size 87709057, node heap has 10228 buffer(s) **#这行显示了自使用哈希索引的状态，其中，Hash table size 87709057表示AHI的大小，node heap has 10228 buffer(s)表示AHI的使用情况**
1741.05 hash searches/s, 539.48 non-hash searches/s **#这行显示了在头部第1部分提及的时间内Innodb每秒完成了多少哈希索引操作，1741.05 hash searches/s表示每秒使用AHI搜索的情况，539.48 non-hash searches/s表示每秒没有使用AHI搜索的情况(因为哈希索引只能用于等值查询，而范围查询，模糊查询是不能使用哈希索引的。)，通过hash searches: non-hash searches的比例大概可以了解使用哈希索引后的效率，哈希索引查找与非哈希索引查找的比例仅供参考，自适应哈希索引无法配置，但是可以通过innodb\_adaptive\_hash\_index=ON|OFF参数来选择是否需要这个特性。**
注：
innodb从1.0.x开始引入change buffer，可以视为insert buffer的升级，从这个版本开始，innodb可以对DML操作(insert,delete,update)都进行缓冲，他们分别是insert buffer,delete buffer,purge buffer，当然和之前insert buffer一样，change buffer适用对象仍然是非唯一索引的辅助索引，因为没有update buffer，所以对一条记录进行update的操作可以分为两个过程：
A：将记录标记为删除
B：真正将记录删除
因此，delete buffer对应update 操作的第一个过程，即将记录标记为删除，purge buffer对应update的第二个过程，即将记录真正地删除
9.这部分显示了关于innodb事务日志（重做日志）子系统的统计：
\---
LOG
\---
Log sequence number 1351392990515 **#这行显示了当前最新数据产生的日志序列号**
Log flushed up to 1351392989504 **#这行显示了日志已经刷新到哪个位置了（已经落盘到事务日志中的日志序列号）**
Last checkpoint at 1351373900020 **#这行显示了上一次检查点的位置（一个检查点表示一个数据和日志文件都处于一致状态的时刻，并且能用于恢复数据），如果上一次检查点落后与上一行太多，并且差异接近于事务日志文件的大小，Innodb会触发“疯狂刷”，这对性能而言非常糟糕。**
0 pending log writes, 0 pending chkp writes **#这行显示了当前挂起的日志读写操作，可以将这行的值与第7部分FILE I/O对应的值做比较，以了解你的I/O有多少是由于日志系统引起的。**
286879989 log i/o's done, 15.92 log i/o's/second **#这行显示了日志操作的统计和每秒日志I/O数，可以将这行的值与第7部分FILE I/O对应的值做比较，以了解你的I/O有多少是由于日志系统引起的。**
9.这部分显示了关于innodb缓冲池及其如何使用内存的统计：
9.1.
\----------------------
BUFFER POOL AND MEMORY
\----------------------
Total memory allocated 45357793280; in additional pool allocated 0 **#这行显示了由innodb分配的总内存，以及其中多少是额外内存池分配，额外内存池仅分配了其中很小一部分内存，由内部内存分配器分配，现在的innodb版本一般使用操作系统的内存分配器，但老版本使用自己的，这是由于在那个时代有些操作系统并未提供一个非常好的内存分配实现。**
Dictionary memory allocated 12681573
Buffer pool size 2705015 **#从这行开始的下面4行显示缓冲池度量值，以页为单位，度量值有总的缓冲池大小，空闲页数，分配用来存储数据库页的页数，以及脏数据库页数。这行显示了缓冲池总共有多少个页，即即2705015\*16K，共有43G的缓冲池**
Free buffers 5 **#这行显示了缓冲池空闲页数**
Database pages 2694782 **#这行显示了分配用来存储数据库页的页数，即，表示LRU列表中页的数量,包含young sublist和old sublist**
Old database pages 994651 **#这行显示了LRU中的old sublist部分页的数量**
Modified db pages 10610 **#这行显示脏数据库页数**
Pending reads 128 **#这行显示了挂起读的数量**
Pending writes: LRU 0, flush list 0, single page 0 **#这行显示了挂起写的数量**
**#注意，这里挂起的读和写操作并不与FILE I/O部分的值匹配，因为Innodb可能合并许多的逻辑读写操作到一个物理I/O操作中，LRU代表最近使用到的被挂起数量，它是通过冲刷缓冲中不经常使用的页来释放空间以供给经常使用的页的一种方法，冲刷列表flush list存放着检查点处理需要冲刷的旧页被挂起的数量，单页single page被挂起的数量（single page写是独立的页面写，不会被合并)。**
Pages made young 3014373561, not young 0 **#这行显示了LRU列表中页移动到LRU首部的次数，因为该服务器在运行阶段改变没有达到innodb\_old\_blocks\_time阀值的值，因此not young为0**
6960.42 youngs/s, 0.00 non-youngs/s **#表示每秒****young和non-youngs这两类操作的次数**
Pages read 2946570833, created 43450158, written 574214278 **#这行显示了innodb被读取，创建，写入了多少页，读/写页的值是指的从磁盘读到缓冲池的数据，或者从缓冲池写到磁盘中的数据，创建页指的是innodb在缓冲池中分配但没有从数据文件中读取内容的页，因为它并不关心内容是什么（如，它们可能属于一个已经被删除的表）**
6960.54 reads/s, 4.42 creates/s, 9.33 writes/s **#这行显示了对应上面一行的每秒read，create，write的页数**
Buffer pool hit rate 955 / 1000, young-making rate 45 / 1000 not 0 / 1000 **#这行显示了缓冲池的命中率，它用来衡量innodb在缓冲池中查找到所需页的比例，它度量自上次Innodb状态输出后到本次输出这段时间内的命中率，因此，如果服务器自那以后一直很安静，你将会看到No buffer pool page gets since the last printout。它对于度量缓存池的大小并没有用处。**
Pages read ahead 6928.54/s, evicted without access 8.21/s, Random read ahead 0.00/s **#这行显示了页面预读，随机预读的每秒页数**
LRU len: 2694782, unzip\_LRU len: 0 **#innodb1.0.x开始支持压缩页的功能，将原来16K的页压缩为1K，2K，4K，8K，而由于页的大小发生了变化，LRU列表也有了些改变，对于非16K的页，是通过unzip\_LRU列表进行管理的，可以看到unzip\_LRU len为0表示没有使用压缩页.**
I/O sum\[60790\]:cur\[30\], unzip sum\[0\]:cur\[0\]
对于压缩页的表，每个表的压缩比例可能不同，可能存在有的表页大小为8K，有的表页大小为2K的情况，unzip\_LRUs 怎样从缓存池中分配内存的呢？
首先，在unzip\_LRU列表中对不同压缩页大小的页进行分别管理，其次，通过伙伴算法进行内存的分配，例如：需要从缓存池中申请页为4K的大小，其过程如下：
a：检查4K的unzip\_LRU列表，检查是否有可用的空闲页
b：若有，则直接使用
c：若没有，检查8K的unzip\_LRU列表
d：若能够得到空闲页，将页分成2个4K的页，存放到4K的unzip\_LRU列表
e：若不能得到空闲页，从LRU列表中申请一个16K的页，将页分成1个8K，2个4K的页，分别存放到各自大小对应的unzip\_LRU列表中。
注：可能出现Free buffers和Database pages之和不等于Buffer pool size，因为缓冲池中的页肯会被分配给自适应哈希索引，lock信息，insert buffer等，而这部分页不需要LRU算法进行维护，因此不在LRU列表中。
9.2.如果innodb buffer pool使用参数innodb
\_buffer\_pool\_instances=num设置了大于1个缓冲池实例，那么就会按照这个参数把innodb\_buffer\_pool\_size=xxx平分为num份。每份的信息显示类似如下，这部分的内容和9.1小节内容类似，就不再多说。
\----------------------
INDIVIDUAL BUFFER POOL INFO
\----------------------
\---BUFFER POOL 0
Buffer pool size 541003
Free buffers 1
Database pages 538965
Old database pages 198933
Modified db pages 2190
Pending reads 128
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 603372180, not young 0
1441.81 youngs/s, 0.00 non-youngs/s
Pages read 589705199, created 8703138, written 116954697
1441.61 reads/s, 0.75 creates/s, 1.83 writes/s
Buffer pool hit rate 955 / 1000, young-making rate 45 / 1000 not 0 / 1000
Pages read ahead 1436.98/s, evicted without access 0.87/s, Random read ahead 0.00/s
LRU len: 538965, unzip\_LRU len: 0
I/O sum\[12158\]:cur\[6\], unzip sum\[0\]:cur\[0\]
\---BUFFER POOL 1
Buffer pool size 541003
Free buffers 1
Database pages 538959
Old database pages 198931
Modified db pages 2025
Pending reads 0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 602366394, not young 0
1481.35 youngs/s, 0.00 non-youngs/s
Pages read 588738997, created 8708171, written 113209540
1480.56 reads/s, 0.83 creates/s, 1.92 writes/s
Buffer pool hit rate 958 / 1000, young-making rate 42 / 1000 not 0 / 1000
Pages read ahead 1473.73/s, evicted without access 1.96/s, Random read ahead 0.00/s
LRU len: 538959, unzip\_LRU len: 0
I/O sum\[12158\]:cur\[6\], unzip sum\[0\]:cur\[0\]
10.这部分显示了其他各项的innodb统计：
\--------------
ROW OPERATIONS
\--------------
0 queries inside InnoDB, 0 queries in queue **#这行显示了innodb内核内有多少个线程，队列中有多少个线程，队列中的查询是innodb为限制并发执行的线程数量而不运行进入内核的线程。查询在进入队列之前会休眠等待。**
5 read views open inside InnoDB **#这行显示了有多少打开的innodb读视图，读视图是包含事务开始点的数据库内容的MVCC快照，你可以看看某特定事务在第6部分TRANSACTIONS是否有读视图**
Main thread process no. 4368, id 140653691242240, state: sleeping **#这行显示了内核的主线程状态**
Number of rows inserted 3429012215, updated 153529675, deleted 112310240, read 3739562987410 **#这行显示了多少行被插入，更新和删除，读取**
428.52 inserts/s, 7.21 updates/s, 0.46 deletes/s, 1047933.92 reads/s **#这行显示了对应上面一行的每秒平均值，如果想查看innodb有多少工作量在进行，那么这两行是很好的参考值**
\----------------------------
END OF INNODB MONITOR OUTPUT **#要注意了，如果看不到这行输出，可能是有大量事务或者是有一个大的死锁截断了输出信息**
\============================
注：内核的主线程状态可能的状态值有如下一些：
A：doing background drop tables
B：doing insert buffer merge
C：flushing buffer pool pages
D：making checkpoint
E：purging
F：reserving kernel mutex
G：sleeping
H：suspending
I：waiting for buffer pool flush to end
J：waiting for server activity

    Created at: 2020-04-09T10:33:01+08:00
    Updated at: 2020-04-09T10:33:01+08:00


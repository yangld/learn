
# spring-boot内存占用过高

![[8知识管理/InBox/evernote/参考/_resources/(1条消息)_spring-boot内存占用过高_zengwende的博客-CSDN博客.resources/original.png]]
[zengwende](https://me.csdn.net/zengwende) 2019-12-23 14:59:56 ![[8知识管理/InBox/evernote/参考/_resources/(1条消息)_spring-boot内存占用过高_zengwende的博客-CSDN博客.resources/articleReadEyes.png]] 3007  

		
分类专栏： [Spring boot](https://blog.csdn.net/zengwende/category_9069153.html) 文章标签： [spring](https://www.csdn.net/gather_22/MtTaEg0sMDg2NTAtYmxvZwO0O0OO0O0O.html) [boot](https://www.csdn.net/gather_2b/MtTaEg0sNDA2OTItYmxvZwO0O0OO0O0O.html) [内存](https://www.csdn.net/gather_27/MtTaEg0sNDk0NjQtYmxvZwO0O0OO0O0O.html) [优化](https://www.csdn.net/gather_29/MtTaEg0sNDA4MjYtYmxvZwO0O0OO0O0O.html)

**JVM是Java Virtual Machine的缩写，中文名为Java虚拟机。它是一种用于计算设备的规范，是一个虚构出来的计算机，主要通过在实际的计算机上仿真模拟各种计算机功能来实现的。在实际运用过程中，易观技术人员注意到一台开发机上各个微服务进程占用内存很高，随即便展开了调查......**

**现象：前段时间发现某台开发机上各个微服务进程占用内存很高，这里记录下解决思路，仅供参考。**

*   Centos6.10+Jdk1.8+SpringBoot1.4.4环境下各个JVM进程所占内存使用情况

![[format,png.3.jpeg]]

**VIRT和RES都很高......**

以其中某个进程为例（进程启动日期为8月9日，排查时候的时间是8月10日10:54:58，也就是说该进程运行时间应该不会超过48小时）

![[format,png.11.jpeg]]

top命令查看该进程占用内存情况**（可以看到此进程已经占用2.7G物理内存）**

![[format,png.1.jpeg]]

为了排除掉是因为中途有压力测试的嫌疑，将此服务进行了重启，但是刚起的进程(19146)，

占内存情况**RES:1.8G, VIRT:33.4G …**

![[format,png.12.jpeg]]

JVM进程动不动就是2G以上的内存，然而开发环境并没什么业务请求，谁是罪魁祸首 ？

> **解决问题之前，先复习下几个基础知识。**

**1\. 什么是RES和VIRT？**

*   RES：resident memory usage 常驻内存

（1）进程当前使用的内存大小，但不包括swap out

（2）包含其他进程的共享

（3）如果申请100m的内存，实际使用10m，它只增长10m，与VIRT相反

（4）关于库占用内存的情况，它只统计加载的库文件所占内存大小

RES = CODE + DATA

*   VIRT：virtual memory usage

（1）进程“需要的”虚拟内存大小，包括进程使用的库、代码、数据等

（2）假如进程申请100m的内存，但实际只使用了10m，那么它会增长100m，而不是实际的使用量

VIRT = SWAP + RES

**2\. Linux与进程内存模型**

![[format,png.8.jpeg]]

**3\. JVM内存模型（1.7与1.8之间的区别）**

![[format,png.5.jpeg]]

**所以JVM进程内存大小大致为：**

非heap（非heap=元空间+栈内存+…）+heap+JVM进程运行所需内存+其他数据

> **那么会是jvm内存泄漏引起的吗？**

*   使用Jmap命令将整个heap dump下来，然后用jvisualvm分析

![[format,png.13.jpeg]]

可以看到，堆内存一切正常（dump会引起FGC,但并不影响此结论）

> **那么可能是SpringBoot的原因吗？**

为了验证此问题，通过部署系统在开发机上起了1个没有任何业务代码的springboot进程，仅仅是引入注册中心

![[format,png.9.jpeg]]

查看此进程内存占用情况：

![[format,png.4.jpeg]]

明显已经设置了Xmx为512MB，虽然Xmx不等于最终JVM所占总内存，但至少也不会偏差太多； 那么使用jmap命令查看当前jvm堆内存配置和使用情况（下面的图2是在图1现场5分钟之后截取的）

![[format,png.2.jpeg]]（图1）

![[format,png.10.jpeg]]（图2）

所以从2次的jmap结果中，可以得出以下几个结论：

*   我们的Xmx设置并没有生效，因为MaxHeapSize≠Xmx
*   图1中jvm占用内存计算：

元空间(20.79MB)+ eden(834MB)+年老代(21MB)+线程栈（38\*1024KB）+JVM进程本身运行内存+ NIO的DirectBuffer +JIT+JNI+…≈top(Res) 1.1G

当前jvm线程数统计：jstack 7311 |grep ‘tid’|wc –l (linux 64位系统中jvm线程默认栈大小为1MB)

*   Eden区进行了多次扩容，由图1可知eden区可用空间已经不够用了（容量：843MB，已使用：834MB），图2中扩容到1566MB
*   Eden区经历了Minor Gc，由图2可知eden区已使用空间：60MB，说明之前在eden区的对象大部分已经被回收，部分未被回收的对象已经转入到扩展1区了

> **Xmx设置为何未生效？**

查看部署系统的启动脚本，发现启动方式为：Java –jar $jar\_file –Xms512m –Xmx1024m

正确的Java命令:

java \[ options \] class \[ arguments \]

java \[ options \] -jar file.jar \[ arguments \]

**其实到这里，也找到了此问题原因所在，Java –jar $jar\_file –Xms512m –Xmx1024m被JVM解释成了程序的参数。**

手动执行: java –Xms512m –Xmx1024m –jar ems-client-1.0.jar

![[format,png.6.jpeg]]

**至此，RES过高的问题已解决，但是VIRT的问题还在**

使用系统命令pmap -x 3516查看进程的内存映射情况，会发现大量的64MB内存块存在；统计了下，大概有50多个65404+132=65536,正好是64MB，算起来大约3个多G

![[format,png.jpeg]]

于是Google之，发现大致的原因是从glibc2.11版本开始，linux为了解决多线程下内存分配竞争而引起的性能问题，增强了动态内存分配行为，使用了一种叫做arena的memory pool,在64位系统下面缺省配置是一个arena大小为64M，一个进程可以最多有cpu cores \* 8个arena。假设机器是8核的，那么最多可以有8 \* 8 = 64个arena，也就是会使用64 \* 64 = 4096M内存。

然而我们可以通过设置系统环境变量来改变arena的数量：

**export MALLOC\_ARENA\_MAX=8（一般建议配置程序cpu核数）**

配置环境变量使其生效，再重启该jvm进程，VIRT比之前少了快2个G:

![[format,png.7.jpeg]]

    Created at: 2020-09-27T14:58:13+08:00
    Updated at: 2020-09-27T14:58:13+08:00


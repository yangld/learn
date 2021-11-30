
2011-07-27 15:39

## ipvsadm命令详解

libnet下载地址： http://search.cpan.org/dist/libnet/
ipvsadm下载地址： http://www.linuxvirtualserver.org/software/ipvs.html#kernel-2.6
从Linux内核版本2.6起，ip\_vs code已经被整合进了内核中，因此，只要在编译内核的时候选择了ipvs的功能，您的Linux即能支持LVS。Linux 2.4.23以后的内核版本也整合了ip\_vs code，但如果是更旧的内核版本，您得自己手动将ip\_vs code整合进内核原码中，并重新编译内核方可使用lvs。
一、关于ipvsadm:
ipvsadm是运行于用户空间、用来与ipvs交互的命令行工具，它的作用表现在：
1、定义在Director上进行dispatching的服务(service)，以及哪此服务器(server)用来提供此服务；
2、为每台同时提供某一种服务的服务器定义其权重（即概据服务器性能确定的其承担负载的能力）；
注：权重用整数来表示，有时候也可以将其设置为atomic\_t；其有效表示值范围为24bit整数空间，即（2^24-1）；
因此，ipvsadm命令的主要作用表现在以下方面：
1、添加服务（通过设定其权重>0）；
2、关闭服务（通过设定其权重>0）；此应用场景中，已经连接的用户将可以继续使用此服务，直到其退出或超时；新的连接请求将被拒绝；
3、保存ipvs设置，通过使用“ipvsadm-sav > ipvsadm.sav”命令实现；
4、恢复ipvs设置，通过使用“ipvsadm-sav < ipvsadm.sav”命令实现；
5、显示ip\_vs的版本号，下面的命令显示ipvs的hash表的大小为4k；
  # ipvsadm
    IP Virtual Server version 1.2.1 (size=4096)
6、显示ipvsadm的版本号
  # ipvsadm --version
   ipvsadm v1.24 2003/06/07 (compiled with popt and IPVS v1.2.0)

7、查看LVS上当前的所有连接
\# ipvsadm -Lcn  
或者
#cat /proc/net/ip\_vs\_conn
8、查看虚拟服务和RealServer上当前的连接数、数据包数和字节数的统计值，则可以使用下面的命令实现：
\# ipvsadm -l --stats
9、查看包传递速率的近似精确值，可以使用下面的命令：
\# ipvsadm -l --rate
二、ipvsadm使用中应注意的问题
默认情况下，ipvsadm在输出主机信息时使用其主机名而非IP地址，因此，Director需要使用名称解析服务。如果没有设置名称解析服务、服务不可用或设置错误，ipvsadm将会一直等到名称解析超时后才返回。当然，ipvsadm需要解析的名称仅限于RealServer，考虑到DNS提供名称解析服务效率不高的情况，建议将所有RealServer的名称解析通过/etc/hosts文件来实现；
三、调度算法
Director在接收到来自于Client的请求时，会基于"schedule"从RealServer中选择一个响应给Client。ipvs支持以下调度算法：（1、2为静态调度算法，3、4、5、6、7、8为动态调度算法）
1、轮询（round robin, rr),加权轮询(Weighted round robin, wrr)——
新的连接请求被轮流分配至各RealServer；算法的优点是其简洁性，它无需记录当前所有连接的状态，所以它是一种无状态调度。轮叫调度算法假设所有服务器处理性能均相同，不管服务器的当前连接数和响应速度。该算法相对简单，不适用于服务器组中处理性能不一的情况，而且当请求服务时间变化比较大时，轮叫调度算法容易导致服务器间的负载不平衡。

2、目标地址散列调度（Destination Hashing，dh）

算 法也是针对目标IP地址的负载均衡，但它是一种静态映射算法，通过一个散列（Hash）函数将一个目标IP地址映射到一台服务器。目标地址散列调度算法先 根据请求的目标IP地址，作为散列键（Hash Key）从静态分配的散列表找出对应的服务器，若该服务器是可用的且未超载，将请求发送到该服务器，否则返回空。

3、源地址散列调度（Source Hashing，sh）

算 法正好与目标地址散列调度算法相反，它根据请求的源IP地址，作为散列键（Hash Key）从静态分配的散列表找出对应的服务器，若该服务器是可用的且未超载，将请求发送到该服务器，否则返回空。它采用的散列函数与目标地址散列调度算法 的相同。除了将请求的目标IP地址换成请求的源IP地址外，它的算法流程与目标地址散列调度算法的基本相似。在实际应用中，源地址散列调度和目标地址散列 调度可以结合使用在防火墙集群中，它们可以保证整个系统的唯一出入口。

4、最少连接(least connected, lc)， 加权最少连接(weighted least connection, wlc)——
新的连接请求将被分配至当前连接数最少的RealServer；最小连接调度是一种动态调度算法，它通过服务器当前所活跃的连接数来估计服务器的负载情况。调度器需要记录各个服务器已建立连接的数目，当一个请求被调度到某台服务器，其连接数加1；当连接中止或超时，其连接数减一。
lc：256\*A+I=当前连接数  wlc：（256\*A+I）/W=当前连接数   【A：活动连接数  I:非活动连接数 W：权重值】
5、基于局部性的最少链接调度（Locality-Based Least Connections Scheduling，lblc）——
针对请求报文的目标IP地址的负载均衡调度，目前主要用于Cache集群系统，因为在Cache集群中客户请求报文的目标IP地址是变化的。这里假设任何后端服务器都可以处理任一请求，算法的设计目标是在服务器的负载基本平衡情况下，将相同目标IP地址的请求调度到同一台服务器，来提高各台服务器的访问局部性和主存Cache命中率，从而整个集群系统的处理能力。LBLC调度算法先根据请求的目标IP地址找出该目标IP地址最近使用的服务器，若该服务器是可用的且没有超载，将请求发送到该服务器；若服务器不存在，或者该服务器超载且有服务器处于其一半的工作负载，则用“最少链接”的原则选出一个可用的服务器，将请求发送到该服务器。
6、带复制的基于局部性最少链接调度（Locality-Based Least Connections with Replication Scheduling，lblcr）

——也是针对目标IP地址的负载均衡，目前主要用于Cache集群系统。它与LBLC算法的不同之处是它要维护从一个目标IP地址到一组服务器的映射，而 LBLC算法维护从一个目标IP地址到一台服务器的映射。对于一个“热门”站点的服务请求，一台Cache 服务器可能会忙不过来处理这些请求。这时，LBLC调度算法会从所有的Cache服务器中按“最小连接”原则选出一台Cache服务器，映射该“热门”站点到这台Cache服务器，很快这台Cache服务器也会超载，就会重复上述过程选出新的Cache服务器。这样，可能会导致该“热门”站点的映像会出现在所有的Cache服务器上，降低了Cache服务器的使用效率。LBLCR调度算法将“热门”站点映射到一组Cache服务器（服务器集合），当该“热门”站点的请求负载增加时，会增加集合里的Cache服务器，来处理不断增长的负载；当该“热门”站点的请求负载降低时，会减少集合里的Cache服务器数目。这样，该“热门”站点的映像不太可能出现在所有的Cache服务器上，从而提供Cache集群系统的使用效率。LBLCR算法先根据请求的目标IP地址找出该目标IP地址对应的服务器组；按“最小连接”原则从该服务器组中选出一台服务器，若服务器没有超载，将请求发送到该服务器；若服务器超载；则按“最小连接”原则从整个集群中选出一台服务器，将该服务器加入到服务器组中，将请求发送到该服务器。同时，当该服务器组有一段时间没有被修改，将最忙的服务器从服务器组中删除，以降低复制的程度。
7、 最短的期望的延迟（Shortest Expected Delay Scheduling ,sed）
sed: (A+1)/w=当前连接数
8、最少队列调度（Never Queue Scheduling ,nq）
无需队列。如果有台realserver的连接数＝0就直接分配过去，不需要在进行sed运算
四、关于LVS追踪标记fwmark：
如果LVS放置于多防火墙的网络中，并且每个防火墙都用到了状态追踪的机制，那么在回应一个针对于LVS的连接请求时必须经过此请求连接进来时的防火墙，否则，这个响应的数据包将会被丢弃。

本文出自 “[linux way](http://linuxbpm.blog.51cto.com/)” 博客，请务必保留此出处<http://linuxbpm.blog.51cto.com/1823930/388243>

[#lb技术](http://hi.baidu.com/tag/lb%E6%8A%80%E6%9C%AF/feeds)
浏览(204) [评论](http://hi.baidu.com/sunyang_kaka/item/3230a350c7591eaeadc8576c#) [转载](http://hi.baidu.com/sunyang_kaka/item/3230a350c7591eaeadc8576c#)

    Created at: 2012-10-23T15:25:10+08:00
    Updated at: 2012-10-23T15:25:10+08:00


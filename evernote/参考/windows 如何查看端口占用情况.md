
在window下，如何停止占用某个端口的进程及操作中使用到的windows相关命令

* * *

[论坛首页](http://www.iteye.com/forums) → [编程语言技术论坛](http://www.iteye.com/forums/board/language) →

# windows 如何查看端口占用情况?

.
[全部](http://www.iteye.com/forums/board/language) [Ruby](http://www.iteye.com/forums/tag/Ruby) [Python](http://www.iteye.com/forums/tag/Python) [PHP](http://www.iteye.com/forums/tag/PHP) [Flash](http://www.iteye.com/forums/tag/Flash) [C++](http://www.iteye.com/forums/tag/C++) [.net](http://www.iteye.com/forums/tag/.net) [Rails](http://www.iteye.com/forums/tag/Rails) [Flex](http://www.iteye.com/forums/tag/Flex) [C](http://www.iteye.com/forums/tag/C) [C#](http://www.iteye.com/forums/tag/C%23) [Django](http://www.iteye.com/forums/tag/Django)

[Java开发新方式：专注UI，快速开发](http://www.iteye.com/clicks/849)
« 上一页 1 [2](http://www.iteye.com/topic/1117270?page=2) [下一页 »](http://www.iteye.com/topic/1117270?page=2)
浏览 47024 次

锁定老帖子 [主题：windows 如何查看端口占用情况?](http://www.iteye.com/topic/1117270)
精华帖 (0) :: 良好帖 (2) :: 新手帖 (5) :: 隐藏帖 (2)
作者正文

*   panfuy
*   等级: 初级会员
*   [![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.4.gif]]](http://panfuy.iteye.com/)
*   性别: ![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.2.gif]]
*   文章: 5
*   积分: 80
*   来自: 深圳
*   ![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.6.gif]]

   发表时间：2011-10-31  

[<](http://www.iteye.com/topic/1117270#) [\>](http://www.iteye.com/topic/1117270#) 猎头职位: [北京: 【北京】游戏公司诚邀php开发工程师](http://www.iteye.com/jobs/2506)
相关文章: <http://www.iteye.com/topic/1117270#> 

*   [谁占用了我的端口(如果:80)请现出原型.](http://www.iteye.com/topic/320760)
*   [被忽悠：0号端口提供IIS的80端口Hello World服务？](http://www.iteye.com/topic/43279)
*   [cmd查看端口号,并关闭占用端口的进程](http://www.iteye.com/topic/1124046)

推荐群组: [JBoss SEAM](http://seam.group.iteye.com/)
[更多相关推荐](http://www.iteye.com/wiki/topic/1117270)
[Windows](http://www.iteye.com/forums/tag/Windows) .

开始--运行--cmd 进入命令提示符 输入netstat -ano 即可看到所有连接的PID 之后在任务管理器中找到这个PID所对应的程序如果任务管理器中**没有PID**这一项,可以在任务管理器中选"查看"-"选择列"
        经常，我们在启动应用的时候发现系统需要的端口被别的程序占用，如何知道谁占有了我们需要的端口，很多人都比较头疼，下面就介绍一种非常简单的方法，希望对大家有用
假如我们需要确定谁占用了我们的9050端口
1、Windows平台
在windows命令行窗口下执行：
1.查看所有的端口占用情况

C:\\>**netstat -ano**

  协议    本地地址                     外部地址               状态                   PID

  TCP    127.0.0.1:1434         0.0.0.0:0              LISTENING       3236
  TCP    127.0.0.1:5679         0.0.0.0:0              LISTENING       4168
  TCP    127.0.0.1:7438         0.0.0.0:0              LISTENING       4168
  TCP    127.0.0.1:8015         0.0.0.0:0              LISTENING       1456
  TCP    192.168.3.230:139      0.0.0.0:0              LISTENING       4
  TCP    192.168.3.230:1957     220.181.31.225:443     ESTABLISHED     3068
  TCP    192.168.3.230:2020     183.62.96.189:1522     ESTABLISHED     1456
  TCP    192.168.3.230:2927     117.79.91.18:80        ESTABLISHED     4732
  TCP    192.168.3.230:2929     117.79.91.18:80        ESTABLISHED     4732
  TCP    192.168.3.230:2930     117.79.91.18:80        ESTABLISHED     4732
  TCP    192.168.3.230:2931     117.79.91.18:80        ESTABLISHED     4732

2.查看指定端口的占用情况
C:\\>**netstat -aon|findstr "9050"**

  协议    本地地址                     外部地址               状态                   PID

  TCP    127.0.0.1:9050         0.0.0.0:0              LISTENING       2016

P: 看到了吗，端口被进程号为2016的进程占用，继续执行下面命令： （也可以去任务管理器中查看pid对应的进程）

3.查看PID对应的进程
C:\\>**tasklist|findstr "2016"**

 映像名称                       PID 会话名              会话#       内存使用
 ========================= ======== ================
  tor.exe                     2016 Console                 0     16,064 K
P:很清楚吧，tor占用了你的端口。

4.结束该进程

C:\\>**taskkill /f /t /im tor.exe**

其他不懂的用 help吧~

.
声明：ITeye文章版权属于作者，受法律保护。没有作者书面许可不得转载。
推荐链接

*   <http://www.iteye.com/clicks/609>
    
     <http://wangmeng.baidu.com/> 
    [![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.gif]]](http://www.baidu.com/cpro.php?GItK00KVC1Ak9qesgZq8ZAhectJYuaYAyhxjnnM5FK3BbrnSb952lPA1ugH-RaHngAn-fdMEZqZKVeJa9YZr5RguPVsYB4gxtNU65vm4iPisWro4jbANNSIeFm_1.DD_jilqq7Pau-tgblUNKWudF6uB8hIB4oDkjZI7X1BsT_rrumuCyn-hHFkR.IgF_5y9YIZ0lQzqLILT8pgw-XyR8mvqVQLwETA-WQ1DknHTzP100IAYqnWm4rjR30Zwd5gRvP1D4rHf0Ivsqn6KWUMw85yP1uA4Bmy-bINqWTZc0IZTqn0K9uAP_mgP15H00TMnqn0KWIAYqIAN3I7qbuyu9IykYg1fvr7tvn0K8mgwd5HT0pgwGujYvnjn0pgwGUhuEpyfqPjT1P1D4P6KMTA-b5H00ThNhTA-b5H00my-s5HK_XZNmXMKFnAuD0ZNGTjdoTb-yPhwuiRqFP6KWpjYs0Zw9TWYvP0KbIZ0qnfK-mywGujYs0APzm1YYn1mdnf0)
    
*   [Java开发新方式：专注UI，快速开发！](http://www.iteye.com/clicks/854)

[返回顶楼](http://www.iteye.com/topic/1117270#)
 <http://panfuy.iteye.com/> <http://panfuy.iteye.com/blog/profile> <http://my.iteye.com/messages/new?message%5Breceiver_name%5D=panfuy> <http://panfuy.iteye.com/blog/guest_book> <http://my.iteye.com/feed?subscription%5Bsubscribed_user_name%5D=panfuy> 

*   phk070832
*   等级: 初级会员
*   [![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.1.gif]]](http://phk070832.iteye.com/)
*   性别: ![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.2.gif]]
*   文章: 495
*   积分: 30
*   来自: 杭州
*   ![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.6.gif]]

   发表时间：2011-11-04  

用TCP View吧 看到很清楚 .
[返回顶楼](http://www.iteye.com/topic/1117270#)
 <http://phk070832.iteye.com/> <http://phk070832.iteye.com/blog/profile> <http://my.iteye.com/messages/new?message%5Breceiver_name%5D=phk070832> <http://phk070832.iteye.com/blog/guest_book> <http://my.iteye.com/feed?subscription%5Bsubscribed_user_name%5D=phk070832> [回帖地址](http://www.iteye.com/topic/1117270#2271361)
[0](http://www.iteye.com/topic/1117270#) [0](http://www.iteye.com/topic/1117270#) 请登录后投票

*   superlittlefish
*   等级: 初级会员
*   [![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.1.gif]]](http://superlittlefish.iteye.com/)
*   性别: ![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.2.gif]]
*   文章: 6
*   积分: 30
*   来自: 北京
*   ![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.6.gif]]

   发表时间：2011-11-04  

学习了, 3ks. .
[返回顶楼](http://www.iteye.com/topic/1117270#)
 <http://superlittlefish.iteye.com/> <http://superlittlefish.iteye.com/blog/profile> <http://my.iteye.com/messages/new?message%5Breceiver_name%5D=superlittlefish> <http://superlittlefish.iteye.com/blog/guest_book> <http://my.iteye.com/feed?subscription%5Bsubscribed_user_name%5D=superlittlefish> [回帖地址](http://www.iteye.com/topic/1117270#2271362)
[0](http://www.iteye.com/topic/1117270#) [0](http://www.iteye.com/topic/1117270#) 请登录后投票

*   superlittlefish
*   等级: 初级会员
*   [![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.1.gif]]](http://superlittlefish.iteye.com/)
*   性别: ![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.2.gif]]
*   文章: 6
*   积分: 30
*   来自: 北京
*   ![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.6.gif]]

   发表时间：2011-11-04  

感谢分享, 能否推荐一本windows 相关的命令的书? .
[返回顶楼](http://www.iteye.com/topic/1117270#)
 <http://superlittlefish.iteye.com/> <http://superlittlefish.iteye.com/blog/profile> <http://my.iteye.com/messages/new?message%5Breceiver_name%5D=superlittlefish> <http://superlittlefish.iteye.com/blog/guest_book> <http://my.iteye.com/feed?subscription%5Bsubscribed_user_name%5D=superlittlefish> [回帖地址](http://www.iteye.com/topic/1117270#2271460)
[0](http://www.iteye.com/topic/1117270#) [0](http://www.iteye.com/topic/1117270#) 请登录后投票

*   caizi12
*   等级: 初级会员
*   [![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.5.jpeg]]](http://caizi12.iteye.com/)
*   性别: ![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.2.gif]]
*   文章: 351
*   积分: 70
*   来自: 北京
*   ![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.6.gif]]

   发表时间：2011-11-04  

或者
根据进程ID杀
\>taskkill /F /PID pid .
[返回顶楼](http://www.iteye.com/topic/1117270#)
 <http://caizi12.iteye.com/> <http://caizi12.iteye.com/blog/profile> <http://my.iteye.com/messages/new?message%5Breceiver_name%5D=caizi12> <http://caizi12.iteye.com/blog/guest_book> <http://my.iteye.com/feed?subscription%5Bsubscribed_user_name%5D=caizi12> [回帖地址](http://www.iteye.com/topic/1117270#2271484)
[0](http://www.iteye.com/topic/1117270#) [1](http://www.iteye.com/topic/1117270#) 请登录后投票

*   icesugar
*   等级: 初级会员
*   [![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.1.gif]]](http://icesugar.iteye.com/)
*   性别: ![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.2.gif]]
*   文章: 4
*   积分: 40
*   来自: 成都
*   ![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.6.gif]]

   发表时间：2011-11-05  

任务管理器可以看见PID的。只是你没打开任务管理器->点击查看->点击选择列->勾选PID
OK了。可以显示PID了 .
[返回顶楼](http://www.iteye.com/topic/1117270#)
 <http://icesugar.iteye.com/> <http://icesugar.iteye.com/blog/profile> <http://my.iteye.com/messages/new?message%5Breceiver_name%5D=icesugar> <http://icesugar.iteye.com/blog/guest_book> <http://my.iteye.com/feed?subscription%5Bsubscribed_user_name%5D=icesugar> [回帖地址](http://www.iteye.com/topic/1117270#2271513)
[0](http://www.iteye.com/topic/1117270#) [0](http://www.iteye.com/topic/1117270#) 请登录后投票

*   ye\_guanwen
*   等级: 初级会员
*   [![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.1.gif]]](http://ye-guanwen.iteye.com/)
*   性别: ![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.2.gif]]
*   文章: 77
*   积分: 50
*   来自: 南京
*   ![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.6.gif]]

   发表时间：2011-11-05  

不错。。一直 .
[返回顶楼](http://www.iteye.com/topic/1117270#)
 <http://ye-guanwen.iteye.com/> <http://ye-guanwen.iteye.com/blog/profile> <http://my.iteye.com/messages/new?message%5Breceiver_name%5D=ye_guanwen> <http://ye-guanwen.iteye.com/blog/guest_book> <http://my.iteye.com/feed?subscription%5Bsubscribed_user_name%5D=ye_guanwen> [回帖地址](http://www.iteye.com/topic/1117270#2271631)
[0](http://www.iteye.com/topic/1117270#) [0](http://www.iteye.com/topic/1117270#) 请登录后投票

*   string2020
*   等级: 初级会员
*   [![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.3.jpeg]]](http://string2020.iteye.com/)
*   性别: ![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.2.gif]]
*   文章: 148
*   积分: 30
*   来自: 广州
*   ![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.6.gif]]

   发表时间：2011-11-05  

netstat -aon|findstr "9050"
tasklist|findstr "2016"
能不能把着两步合并成一步，一步查询出哪个端口，被哪个程序占用了。 .
[返回顶楼](http://www.iteye.com/topic/1117270#)
 <http://string2020.iteye.com/> <http://string2020.iteye.com/blog/profile> <http://my.iteye.com/messages/new?message%5Breceiver_name%5D=string2020> <http://string2020.iteye.com/blog/guest_book> <http://my.iteye.com/feed?subscription%5Bsubscribed_user_name%5D=string2020> [回帖地址](http://www.iteye.com/topic/1117270#2271660)
[0](http://www.iteye.com/topic/1117270#) [0](http://www.iteye.com/topic/1117270#) 请登录后投票

*   gougou851129
*   等级: 初级会员
*   [![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.1.gif]]](http://gougou851129.iteye.com/)
*   性别: ![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.2.gif]]
*   文章: 51
*   积分: 30
*   来自: 南京
*   ![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.6.gif]]

   发表时间：2011-11-05  

用active ports 比系统自带的要好用多了 .
[返回顶楼](http://www.iteye.com/topic/1117270#)
 <http://gougou851129.iteye.com/> <http://gougou851129.iteye.com/blog/profile> <http://my.iteye.com/messages/new?message%5Breceiver_name%5D=gougou851129> <http://gougou851129.iteye.com/blog/guest_book> <http://my.iteye.com/feed?subscription%5Bsubscribed_user_name%5D=gougou851129> [回帖地址](http://www.iteye.com/topic/1117270#2271702)
[0](http://www.iteye.com/topic/1117270#) [0](http://www.iteye.com/topic/1117270#) 请登录后投票

*   phk070832
*   等级: 初级会员
*   [![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.1.gif]]](http://phk070832.iteye.com/)
*   性别: ![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.2.gif]]
*   文章: 495
*   积分: 30
*   来自: 杭州
*   ![[./_resources/windows_如何查看端口占用情况.resources/unknown_filename.6.gif]]

   发表时间：2011-11-06  

我都直接使用TCP View处理，因为当初刚学java的时候经常会出现某某端口被占用，用了TCP View直接把占用端口的进程停了，非常方便。 .
[返回顶楼](http://www.iteye.com/topic/1117270#)
 <http://phk070832.iteye.com/> <http://phk070832.iteye.com/blog/profile> <http://my.iteye.com/messages/new?message%5Breceiver_name%5D=phk070832> <http://phk070832.iteye.com/blog/guest_book> <http://my.iteye.com/feed?subscription%5Bsubscribed_user_name%5D=phk070832> [回帖地址](http://www.iteye.com/topic/1117270#2271819)
[0](http://www.iteye.com/topic/1117270#) [0](http://www.iteye.com/topic/1117270#) 请登录后投票

« 上一页 1 [2](http://www.iteye.com/topic/1117270?page=2) [下一页 »](http://www.iteye.com/topic/1117270?page=2)

[论坛首页](http://www.iteye.com/forums) → [编程语言技术版](http://www.iteye.com/forums/board/language)
跳转论坛:

*   [云南: 云南远信诚聘高级业务分析师](http://www.iteye.com/jobs/2318)
*   [云南: 云南远信诚聘高级软件质保工程师](http://www.iteye.com/jobs/2327)
*   [云南: 云南远信诚聘视觉设计师](http://www.iteye.com/jobs/2296)
*   [云南: 云南远信诚聘软件测试工程师](http://www.iteye.com/jobs/2300)
*   [上海: 用友汽车软件诚聘高级Java程序员](http://www.iteye.com/jobs/2064)
*   [云南: 云南远信诚聘软件工程师（Java）](http://www.iteye.com/jobs/2297)
*   [云南: 云南远信诚聘高级软件工程师(web)](http://www.iteye.com/jobs/2302)
*   [云南: 云南远信诚聘高级软件工程师(J2EE)](http://www.iteye.com/jobs/2321)
*   [北京: ITeye官方招聘和猎头诚聘【北京】游戏公司诚](http://www.iteye.com/jobs/2506)
*   [上海: 用友汽车软件诚聘高级java开发工程师（UAP平](http://www.iteye.com/jobs/2140)
*   [吉林: 用友汽车软件诚聘高级Java工程师工作地点：长](http://www.iteye.com/jobs/2137)
*   [广东: 用友汽车软件诚聘中级JAVA工程师 工作地点：](http://www.iteye.com/jobs/2144)
*   [吉林: 用友汽车软件诚聘数据库技术工程师DBA 工作地](http://www.iteye.com/jobs/2138)
*   [云南: 云南远信诚聘软件质保工程师](http://www.iteye.com/jobs/2329)
*   [上海: 用友汽车软件诚聘中级java程序员（工作地点：](http://www.iteye.com/jobs/2143)
*   [上海: 用友汽车软件诚聘初级java开发工程师（UAP平](http://www.iteye.com/jobs/2141)
*   [云南: 云南远信诚聘系统集成工程师](http://www.iteye.com/jobs/2333)
*   [云南: 云南远信诚聘业务分析师](http://www.iteye.com/jobs/2337)
*   [上海: 用友汽车软件诚聘项目经理](http://www.iteye.com/jobs/2078)

    Created at: 2013-01-28T09:52:53+08:00
    Updated at: 2013-01-28T09:52:53+08:00


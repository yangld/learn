
![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/embedded.svg]]![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/embedded.1.svg]]

 [![[3_hongyang321.gif]]](https://blog.csdn.net/hongyang321) 

[hongyang321](https://blog.csdn.net/hongyang321)
码龄9年 [![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/nocErtification.png]]暂无认证](https://me.csdn.net/hongyang321?utm_source=14998968)

[32](https://blog.csdn.net/hongyang321)
[原创](https://blog.csdn.net/hongyang321)

6
粉丝

5
获赞

10
评论

3万+
访问

419
积分

7
收藏

32万+
[周排名](https://blog.csdn.net/rank/writing_rank)

20万+
[总排名](https://blog.csdn.net/rank/writing_rank_total)

 [![[blog3.png]]](https://blog.csdn.net/home/help.html#level) 
等级

[TA的主页](https://me.csdn.net/hongyang321)
[私信](https://im.csdn.net/im/main.html?userName=hongyang321)

  

[![[11759548447680372706.gif]]](https://adclick.g.doubleclick.net/pcs/click?xai=AKAOjsut1rt--PtOxvHGaRiUrzAtL6WwBaWTJ7vC6kLH2J23-RSZxPUeRKAmFJhNR4mnzpGm_2YOp0tmmwV0Kf91Y06HzMAAepSn3hCwK2GgDAxS1rbKnM-f6hv3FP5pPHmPBv4ubsEg4K5XRo1An5pgud4CJwOrL-E2UWuAaoVLSM-TJ-Hj4Ezg3XQmfu-fIZLfpwmrtbceuC3yvG3foJERjvAAgZoO8iuLstXlAOMR7lFqyZancr-tKE7YDFzFb1v_5PALE8I0mdaYZY59x26QvozfiGy3nKmIkz57HvQVDHUaz8sHzOkPNaoGnIcwKjo2FQgjFIJzHn4m3Fs5WBT2XRtVWiRAaWNNwUtL99f2OhTZTdR_0RtqNqJhNOG57V4k3MiLc_c40f-ZXSy10k6ecag6bEmnJod9F2hXTijXT9RdevM0weu8z7gbolCcyMpCQ8bFHIcg5ds9OqQU9YbzoR4yy8jn_xRTeKI0uUiTzKZn5VY5yI5O1LryYyy3xKlvoocW-tmVWKkX8HlhMEWz7a2Yua2DsoQm_CEhp5jgK5FU_4znIVrxBwY2WM8ckO0f_ZmVJLgQ2CLH2GGJUf4tJ_V3QJ-NrzX44aJuHWw0LiVYcYcYmxKz5xOJemDvbyaUAhratraC29MR0R2dJPBvNWaXnq-Aid1fvppsZUId6rOo_lTVC9aGmhhr-TELnvaCMor5GXx845vc-94dbR9adZH784E54Kmng4JW9p2rW4F6x4PW_OxQB_Bz74Kg_HiNcXoL4DiKe62uVLwmxienBtR35LFlLg4lYfVg3Em-3GeiPvoqaYBl9xEa6c0k4q9vlfwbIn0uMxI2QSM6pWEuWvaRNEoUgjk9VT7RM4oC-pzCdlooZ-9HwJJ-NymyNecBEIVXMNu9Va3IOKid1jShHpLzAWM-PHQKFXywsC-WO_1Xdx7z-kcQebN0dnqA98lsolp4SmgFxjmS_2cSFxyXIN6EH89RqL8TeenHlAi6LmCpfol2vdMBJhYdZxoHCekUY3jYUuhcgEGOX3IaOghI1Yt7Ua1fbDKQHSthx8gLzp1msBoC9cNB8A6-i30ak08V7A1KJ03-vBYYgqM&sai=AMfl-YT4ZR7-iNtx8KMeETR3BDj1bbYwTQz1a36euRvmJdNya_Mjf4w3uxqGL6gY6rdppTsDOwAZsJwS7WQGa8YbuRStltgmG1Hy7HuIzdus_LfEcSrazzWd192Zq0l3x9Y67WQq8hxPPSzI0sr50SHKM55pfJE8S6iv47om2Hlpad3aR__tUzMgukT2kdkdmbvCBiQQWXfHAH7llCAtkp8KtDnctn9Wr9CpwDbF0en0EEJ_0pzwK4jL8x3OVsFs2VQVrA96CDNLVMf02Q-vuQWVmRz2X_9vW7yH0Lcc2dhBXSJcYHeJSB06t0dO_ESeOLfcnxwZamUhgwRCokDkuzNAnwPIPaVuL5RiSF0c1Fyf69Hjww&sig=Cg0ArKJSzEb4TUv6ZrD7&urlfix=1&adurl=https://www.ueachina.cn/%3Futm_source%3Ddisplay%26utm_medium%3Ddisplay%26utm_campaign%3DPG1920RE_pgt-home)

![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/embedded.2.svg]]

![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/embedded.3.svg]]

![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/1.2.png]]

### 最新文章

*   [Intellij IDEA 最新旗舰版注册激活(2018)](https://blog.csdn.net/hongyang321/article/details/84107197)
*   [Java中调用https时报peer not authenticated的解决方案](https://blog.csdn.net/hongyang321/article/details/82743731)
*   [zabbix从放弃到入门（安装篇）](https://blog.csdn.net/hongyang321/article/details/80096556)
*   [Jmeter传输有中文的json数据，乱码、加转义问题处理](https://blog.csdn.net/hongyang321/article/details/80091725)
*   [免费的XML格式化、编辑软件](https://blog.csdn.net/hongyang321/article/details/80079472)

### 分类专栏

*    [![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/resize,m_fixed,h_224,w_224.3.png]] SpringBoot  2篇](https://blog.csdn.net/hongyang321/category_7345594.html) 
*    [![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/resize,m_fixed,h_224,w_224.png]] 工具软件  1篇](https://blog.csdn.net/hongyang321/category_7619567.html) 
*    [![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/resize,m_fixed,h_224,w_224.2.png]] 问题处理  2篇](https://blog.csdn.net/hongyang321/category_7622232.html) 
*    [![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/resize,m_fixed,h_224,w_224.2.png]] zabbix](https://blog.csdn.net/hongyang321/category_7623235.html) 
*    [![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/resize,m_fixed,h_224,w_224.1.png]] 教程  1篇](https://blog.csdn.net/hongyang321/category_7623244.html) 

### 归档

2018

[11月 1篇](https://blog.csdn.net/hongyang321/article/month/2018/11)
[9月 1篇](https://blog.csdn.net/hongyang321/article/month/2018/09)
[4月 3篇](https://blog.csdn.net/hongyang321/article/month/2018/04)
[1月 1篇](https://blog.csdn.net/hongyang321/article/month/2018/01)

2017

[12月 1篇](https://blog.csdn.net/hongyang321/article/month/2017/12)

2011

[5月 3篇](https://blog.csdn.net/hongyang321/article/month/2011/05)
[4月 22篇](https://blog.csdn.net/hongyang321/article/month/2011/04)

### 热门文章

*   [在SpringBoot项目中添加logback的MDC ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/readCountWhite.png]]10061](https://blog.csdn.net/hongyang321/article/details/78803584) 
*   [Logback 输出日志性能优化 ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/readCountWhite.png]]9740](https://blog.csdn.net/hongyang321/article/details/78960508) 
*   [Jmeter传输有中文的json数据，乱码、加转义问题处理 ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/readCountWhite.png]]4856](https://blog.csdn.net/hongyang321/article/details/80091725) 
*   [Java中调用https时报peer not authenticated的解决方案 ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/readCountWhite.png]]4465](https://blog.csdn.net/hongyang321/article/details/82743731) 
*   [免费的XML格式化、编辑软件 ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/readCountWhite.png]]2588](https://blog.csdn.net/hongyang321/article/details/80079472) 

### 最新评论

*   [Java中调用https时报pee...](https://blog.csdn.net/hongyang321/article/details/82743731#comments)
    
    ... [sd144765：](https://my.csdn.net/sd144765)https://my.oschina.net/u/1164681/blog/863363 这篇纹章深入分析, 有可能是服务器默认设置不支持低版本jdk使用的加密协议
    
*   [Logback 输出日志性能优化](https://blog.csdn.net/hongyang321/article/details/78960508#comments)
    
    ... [hongyang321：](https://my.csdn.net/hongyang321)\[reply\]hvang1988\[/reply\]jprofiler
    
*   [在SpringBoot项目中添加l...](https://blog.csdn.net/hongyang321/article/details/78803584#comments)
    
    ... [baxiadsy\_csdn：](https://my.csdn.net/baxiadsy_csdn)如果第一个request1进入未处理完成，第二个request2进入再次MDC.put(REQUEST\_ID, uuid);会不会直接将第一个request1的MDC值覆盖了？因为rqeust1与request2都是MDC key=REQUEST\_ID
    
*   [Logback 输出日志性能优化](https://blog.csdn.net/hongyang321/article/details/78960508#comments)
    
    ... [hvang1988：](https://my.csdn.net/hvang1988)大佬，你的cpu占用怎么分析出来的，啥工具呀
    
*   [在SpringBoot项目中添加l...](https://blog.csdn.net/hongyang321/article/details/78803584#comments)
    
    ... [sinat\_30136655：](https://my.csdn.net/sinat_30136655)\[reply\]danmingzhen\[/reply\]我也遇到了，知道怎么解决了吗？
    

![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/1.2.png]]

# Logback 输出日志性能优化

![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/original.png]]
[hongyang321](https://me.csdn.net/hongyang321) 2018-01-03 14:04:30 ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/articleReadEyes.png]] 9767  

		
分类专栏： [SpringBoot](https://blog.csdn.net/hongyang321/category_7345594.html)

笔者负责的一个集成接口平台的应用，其业务功能并不复杂，但是要重点考虑接口的性能。
在进行过异步数据库写入、第三方代码调优、报文解析调优后，基本上已经无可优化性能的代码了。但是在JProfiler的监控里面又发现了logback日志的可优化空间。

问题描述：
下图中可看出logback的日志输出占了64%的cpu消耗，目标就是优化它！
![[78960508.bin]]
![[20180103140504552.png]]

优化方案：
1\. 这部分写日志的代码写了一些报文数据，确实是比较大的字符串。先禁掉控制台输出，生产环境也不需要控制台输出，写日志文件即可。
配置中去掉控制台输出
<**root** **level****\="INFO"**\>
_<!--<appender-ref ref="STDOUT"/>-->_
<**appender-ref** **ref****\="ASYNC\_ROLLING\_FILE"**/>
</**root**\>
优化后的结果，915ms直接变为76ms，优化效果相当显著
![[78960508.1.bin]]
![[20180103140524874.png]]

2\. 可能这时有人会说了，“你控制台禁了，日志文件又禁不了，不还是慢啊！”这话很有道理，但是logback有个好东东，日志文件异步写入
配置如下：
<**appender** **name****\="ASYNC\_ROLLING\_FILE"** **class****\="ch.qos.logback.classic.AsyncAppender"**\>
<**appender-ref** **ref****\="ROLLING\_FILE"** />
</**appender**\>
<**root** **level****\="INFO"**\>
<**appender-ref** **ref****\="ASYNC\_ROLLING\_FILE"**/>
</**root**\>
所以在上面的性能监控里面就看不到文件写入的性能消耗了

*    
*    [![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/tobarComment.png]] 评论 3](https://blog.csdn.net/hongyang321/article/details/78960508#commentBox) 
*    [[# | ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/tobarShare.png]] 分享]] 
*    [[# | ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/tobarCollect.png]] 收藏 3]] 
*    [[# | ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/tobarMobile.png]] 手机看]] 
*     
*   [[# | 关注]]

#### [改进SEIR模型的matlab代码.zip](https://download.csdn.net/download/weixin_44348260/12412703)05-12
[本资源包括，基于SEIR模型的新冠肺炎疫情分析matlab代码和最新的国内疫情数据集。代码已详细备注，具体模型详解见本人博客，大家可以下载交流，略有瑕疵，欢迎指正。](https://download.csdn.net/download/weixin_44348260/12412703)

[IT哈哈的博客](https://blog.csdn.net/xvhongliang)

 ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/readCountWhite.png]] 279

#### [_Logback_配置文件这么写，TPS提高10倍](https://blog.csdn.net/xvhongliang/article/details/99310993)

[受台风利奇马的影响很多地方都迎来了强降雨，双休日不能出去玩一起学习吧，就先从最基本的配置讲起再介绍高级特性异步_输出__日志_。如果只想看异步_输出__日志_提升_性能_的部分请将文章往下拉一点。通过阅读本篇文章将了解到1._日志__输出_到文件并根据LEVEL级别将_日志_分类保存到不同文件 2.通过异步_输出__日志_减少磁盘IO提高_性能_ 3.异步_输出__日志_的原理配置文件_logback_\-spring.xmlSpr......](https://blog.csdn.net/xvhongliang/article/details/99310993)

 [[# | ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/anonymous-User-img.png]]]] 

*   [![[3_hvang1988.jpeg]]](https://me.csdn.net/hvang1988)
    
    [hvang1988](https://me.csdn.net/hvang1988):大佬，你的cpu占用怎么分析出来的，啥工具呀4月前
    ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/unknown_filename.png]]
    
    *   [![[3_hongyang321.gif]]](https://me.csdn.net/hongyang321)
        
        [hongyang321![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/unknown_filename.1.png]]](https://me.csdn.net/hongyang321)回复:jprofiler2月前
        ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/unknown_filename.png]]
        

*   [![[3_a4453368.png]]](https://me.csdn.net/a4453368)
    
    [小蝙蝠侠](https://me.csdn.net/a4453368):不错，学到不少2年前
    ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/unknown_filename.png]]
    

[zhibin的程序日记](https://blog.csdn.net/loophome)

 ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/readCountWhite.png]] 1709

#### [_logback_异步_日志_AsyncAppender配置](https://blog.csdn.net/loophome/article/details/103254677)

[_日志_记录会消耗_性能_，但当出现问题的时候，_日志_又能够帮助我们快速解决问题。那么如何提高打_日志_的_性能_呢？在使用_logback_的时候，推荐使用AsyncAppender异步记录_日志_。1）_logback_设置AsyncAppender要注意AsyncAppender异步记录ILoggingEvents，它仅充当事件分派器，因此必须引用另一个appender才能执行任何有用的操作。<con......](https://blog.csdn.net/loophome/article/details/103254677)

[Ronin\_88的博客](https://blog.csdn.net/Ronin_88)

 ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/readCountWhite.png]] 168

#### [springboot项目_日志__优化_(整合_logback_框架)](https://blog.csdn.net/Ronin_88/article/details/104789394)

[为了更好的追踪和查看http请求信息，包括请求状态，参数，以及响应报文，因此定义aop切面，按照一定格式打印出controller层请求信息和响应报文信息，项目_日志_框架为log back 案例代码如下：package com.eno.config.aop;import java.lang.reflect.Method;import java.time.Duration;import ......](https://blog.csdn.net/Ronin_88/article/details/104789394)

#### [_Logback_ _输出__日志__性能__优化_ - 上善若水 - CSDN博客](https://blog.csdn.net/hongyang321/article/details/78960508/)

11-29

[在进行过异步数据库写入、第三方代码调优、报文解析调优后,基本上已经无可_优化__性能_的代码了。但是在JProfiler的监控里面又发现了_logback__日志_的可_优化_空间。 问题描述:...](https://blog.csdn.net/hongyang321/article/details/78960508/)

#### [_logback__日志_颜色调优、_日志_分离 - qq\_34313827的博客](https://blog.csdn.net/qq_34313827/article/details/80394325)

12-16

[_logback_是log4j作者推出的新_日志_系统,原生支持slf4j通用_日志_api,允许平滑切换_日志_系统,并且对简化应用部署中_日志_处理的工作做了有益的封装。 官方地址为:http://...](https://blog.csdn.net/qq_34313827/article/details/80394325)

[wpkk66的专栏](https://blog.csdn.net/tornadowp)

 ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/readCountWhite.png]] 5万+

#### [log4j_日志__输出__性能__优化_\-缓存、异步](https://blog.csdn.net/tornadowp/article/details/8182496)

[1、log4j已成为大型系统必不可少的一部分，log4j可以很方便的帮助我们在程序的任何位置_输出_所要打印的信息，便于我们对系统在调试阶段和正式运行阶段对问题分析和定位。由于_日志_级别的不同，对系统的_性能_影响也是有很大的差距，_日志_级别越高，_性能_越高。 2、log4j主要分为error,warn,info,debug四个级别，也是使用最多的四种，_日志_级别从左至右依次增加。 3、log4j...](https://blog.csdn.net/tornadowp/article/details/8182496)

[Fisher\_yu01的博客](https://blog.csdn.net/Fisher_yu01)

 ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/readCountWhite.png]] 1404

#### [spring boot _logback_按天写_日志_， info和error_日志_分开](https://blog.csdn.net/Fisher_yu01/article/details/82633599)

[&lt;?xml version="1.0" encoding="utf-8" ?&gt;&lt;configuration&gt; &lt;appender name="STDOUT" class="ch.qos._logback_.core.ConsoleAppender"&gt; &lt;encoder&gt;](https://blog.csdn.net/Fisher_yu01/article/details/82633599)

#### [_logback__性能_调优测试 - Pasenger的专栏](https://blog.csdn.net/Pasenger/article/details/38582949)

12-12

[在进行过异步数据库写入、第三方代码调优、报文解析调优后,基本上已经无可_优化__性能_的代码了。但是在JProfiler的监控里... 博文 来自: 上善若水 _LogBack__日志_丢失...](https://blog.csdn.net/Pasenger/article/details/38582949)

#### [_logback__性能__优化_及源码分析\_wildpal的专栏-CSDN博客](https://blog.csdn.net/wildpal/article/details/52327188)

6-11

[_Logback_ _输出__日志__性能__优化_ 笔者负责的一个集成接口平台的应用,其业务功能并不复杂,但是要重点考虑接口的_性能_。在进行过异步数据库写入、第三方代码调优、报文解析调...](https://blog.csdn.net/wildpal/article/details/52327188)

[追梦者xuaner](https://blog.csdn.net/qq_23132561)

 ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/readCountWhite.png]] 1176

#### [_logback_(3):_输出__日志_到数据库](https://blog.csdn.net/qq_23132561/article/details/88753750)

[参考_logback_官方文档,地址为https://_logback_.qos.ch/manual/configuration.html；一、用IntelliJ IDEA新建maven项目；二、导入jar包：_logback_需要的jar包 <dependency> <groupId>ch.qos._logback_</groupId> ...](https://blog.csdn.net/qq_23132561/article/details/88753750)

[wus\_shang的博客](https://blog.csdn.net/wus_shang)

 ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/readCountWhite.png]] 250

#### [_logback_的使用和_logback_.xml详解](https://blog.csdn.net/wus_shang/article/details/79286668)

[更新记录2017-02-06 :1.需要更改的参数提取为变量，如果是SpringBoot项目，可以完全写在配置文件，可去看减轻茶的配置 ；2.定义控制台自定义颜色，Eclipse需要安装ANSI插件2017-12-28 ：修改添加_日志_记录到数据库，去除1.2.3版本不兼容的保存_日志_文件的file标签 ，&lt;File&gt;${LOG\_HOME}/info.duduerp.log&lt;/Fil......](https://blog.csdn.net/wus_shang/article/details/79286668)

#### [一次_logback_多线程调优的经历\_weixin\_33797791的博客-C...\_CSDN博客](https://blog.csdn.net/weixin_33797791/article/details/88742365)

6-16

[至此,整个_logback_多线程调优结束,通过充分_优化_同步竞争的方式,最终使得分线程记录_日志_的_性能_比最原始的多线程写同一文件提高了10倍(SiftAppender去锁提高到5倍,Map...](https://blog.csdn.net/weixin_33797791/article/details/88742365)

#### [_Logback_ 配置文件这么写,TPS 提高 10 倍!\_路人甲Java-CSDN博客](https://blog.csdn.net/likun557/article/details/107438151)

7-20

[Spring Boot工程自带_logback_和slf4j的依赖,所以重点放在编写配置文件上,需要引入什么依赖,_日志_依赖冲突统统都不需要我们管了。 _logback_框架会默认加载classpath下命名为...](https://blog.csdn.net/likun557/article/details/107438151)

[GeekSnow的博客](https://blog.csdn.net/GeekSnow)

 ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/readCountWhite.png]] 6983

#### [_logback_异步_输出__日志_](https://blog.csdn.net/GeekSnow/article/details/53405062)

[_logback_异步_输出__日志_代码块](https://blog.csdn.net/GeekSnow/article/details/53405062)

[wildpal的专栏](https://blog.csdn.net/wildpal)

 ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/readCountWhite.png]] 6610

#### [_logback__性能__优化_及源码分析](https://blog.csdn.net/wildpal/article/details/52327188)

[项目中_日志_使用最多的是_logback__输出__日志_文件。下图是_logback_在实际并发环境中的表现,200并发请求，大量blocked： 移除_日志__输出_做对比: 查看thread dump 可以看到blocked是由_logback_导致。_logback_源码分析_logback_文件_输出_类是RollingFileAppender,打印_日志_的方法是subAppend，rollover是关闭文件切换_日志_文件。/\*\*...](https://blog.csdn.net/wildpal/article/details/52327188)

#### [_Logback_配置文件这么写,TPS提高10倍 - 朱小厮的博客 - CSDN博客](https://blog.csdn.net/u013256816/article/details/99379181)

11-30

[在进行过异步数据库写入、第三方代码调优、报文解析调优后,基本上已经无可_优化__性能_的代码了。但是在JProfiler的监控里... 博文 来自: 上善若水 _logback_的配置...](https://blog.csdn.net/u013256816/article/details/99379181)

#### [_logback_ 常用配置(详解)\_霓虹深处-CSDN博客\__logback_配置文件详解](https://blog.csdn.net/qq_36850813/article/details/83092051)

7-23

[_logback_ 简介Ceki Gülcü在Java_日志_领域世界知名。他创造了Log4J ,这个最早的Java_日志_框架即便在JRE内置_日志_功能的竞争下仍然非常流行。随后他又着手实现SLF4J 这个...](https://blog.csdn.net/qq_36850813/article/details/83092051)

©️2020 CSDN 皮肤主题: 大白 设计师: CSDN官方博客 [返回首页](https://blog.csdn.net/)

[关于我们](https://www.csdn.net/company/index.html#about) [招聘](https://www.csdn.net/company/index.html#recruit) [广告服务](https://www.csdn.net/company/index.html#advertisement) [网站地图](https://www.csdn.net/gather/A) _![[./_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/embedded.4.svg]] [kefu@csdn.net](https://blog.csdn.net/hongyang321/article/details/78960508mailto:webmaster@csdn.net)![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/embedded.5.svg]] [客服论坛](http://bbs.csdn.net/forums/Service)![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/embedded.6.svg]] 400-660-0108 ![[8知识管理/InBox/evernote/参考/_resources/Logback_输出日志性能优化_上善若水-CSDN博客_logback_调优.resources/embedded.7.svg]][QQ客服（8:30-22:00）](https://url.cn/5epoHIm?_type=wpa&qidian=true)_ 
[公安备案号 11010502030143](http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11010502030143) [京ICP备19004658号](http://beian.miit.gov.cn/publish/query/indexFirst.action) [京网文〔2020〕1039-165号](https://csdnimg.cn/release/live_fe/culture_license.png) [版权与免责声明](https://www.csdn.net/company/index.html#statement) [版权申诉](https://blog.csdn.net/blogdevteam/article/details/90369522) [网络110报警服务](http://www.cyberpolice.cn/)
[中国互联网举报中心](http://www.12377.cn/) [家长监护](https://download.csdn.net/index.php/tutelage/) [版权申诉](https://blog.csdn.net/blogdevteam/article/details/90369522) [北京互联网违法和不良信息举报中心](http://www.bjjubao.org/)

    Created at: 2020-07-30T20:35:43+08:00
    Updated at: 2020-07-30T20:35:43+08:00


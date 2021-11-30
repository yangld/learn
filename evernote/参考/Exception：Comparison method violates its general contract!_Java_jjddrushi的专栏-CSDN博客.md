
![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/embedded.svg]]![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/embedded.1.svg]]![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/embedded.2.svg]]

# Exception：Comparison method violates its general contract!

原创 [熊猫都爱吃](https://me.csdn.net/jjddrushi) 最后发布于2016-12-21 17:52:11 阅读数 468  

![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/embedded.4.svg]]

在项目中，数据后台查询一些数据时偶然出现这个漏洞，错误信息如下：

    严重: Servlet.service() for servlet [springMVC] in context with path [/ice] threw exception [Request processing failed; nested exception is java.lang.IllegalArgumentException: Comparison method violates its general contract!] with root cause
    java.lang.IllegalArgumentException: Comparison method violates its general contract!
        at java.util.TimSort.mergeHi(TimSort.java:899)
        at java.util.TimSort.mergeAt(TimSort.java:516)
        at java.util.TimSort.mergeCollapse(TimSort.java:439)
        at java.util.TimSort.sort(TimSort.java:245)
        at java.util.Arrays.sort(Arrays.java:1512)
        at java.util.ArrayList.sort(ArrayList.java:1454)
        at com.liyunet.service.functional.impl.IPDataMonitorServiceImpl.getIpDataByFetchedOrEnterpriseOrEvaluation(IPDataMonitorServiceImpl.java:160)

报错语句如下：

            infoVO.sort((IPInfoCompletionVO v1, IPInfoCompletionVO v2) -> v1.getDegreeOfCompletion()<v2.getDegreeOfCompletion()?1:-1);登录后复制

，经百度得知，使用比较器时，在做比较的两个变量相同时应该返回0，如果不返回0，则在一些特殊情况下会造成排序出错。具体解释，这里就不列举了，下面是引用文章的链接
[关于TimSort排序的原理解释](http://www.tuicool.com/articles/MZreyuv)

*   [[# | ![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/embedded.5.svg]]点赞]] 
*   [[# | ![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/embedded.6.svg]]收藏]]
*   [[# | ![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/embedded.7.svg]]分享]]
*     

 [![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/3_jjddrushi.png]] ![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/8.5.png]]](https://blog.csdn.net/jjddrushi) 

[熊猫都爱吃](https://blog.csdn.net/jjddrushi)
发布了20 篇原创文章 · 获赞 3 · 访问量 6万+

[私信](https://im.csdn.net/im/main.html?userName=jjddrushi) 

![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/1.1.png]]

 [[# | ![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/anonymous-User-img.png]]]] 

#### [java异常：_Comparison_ _method_ _violates_ its _general_ _contract_!解决](https://blog.csdn.net/TomCosin/article/details/83381221)

[项目在线上运行时突然出现了几百封异常邮件，过了一段时间又自动好了。项目异常报错信息是Comparisonmethodviolatesitsgeneralcontract在顺着堆栈信息查找下去，发现是s...](https://blog.csdn.net/TomCosin/article/details/83381221) 博文 [来自： TomCosin的博客](https://blog.csdn.net/TomCosin)

#### [_Comparison_ _method_ _violates_ its _general_ _contract_!](https://blog.csdn.net/weixin_39194257/article/details/90481854)

[最近项目中有许多地方用到了集合排序，不是自然排序，必须的自己实现排序逻辑了。java提供实现排序接口有两个Comparable与Comparator。我简单理解：1.Comparable接口是实现在需...](https://blog.csdn.net/weixin_39194257/article/details/90481854) 博文 [来自： 天生卷发](https://blog.csdn.net/weixin_39194257)

#### [这个坑，你要注意：_Comparison_ _method_ _violates_ its _general_ _contract_!](https://blog.csdn.net/xvshu/article/details/70153759)

[背景有部分业务需要进行排序，对比的对象是某实体里的金额（double 类型），这样，我们实现了自定义的比较类，结果运行一段时间之后报了错误：Comparison method violates its...](https://blog.csdn.net/xvshu/article/details/70153759) 博文 [来自： 许恕](https://blog.csdn.net/xvshu)

#### [处理 Comparable接口不严谨导致_Comparison_ _method_ _violates_ its _general_ _contract_!](https://blog.csdn.net/wangxueming/article/details/80967341)

[本文主旨是记录问题解决过程出错的日志ShuttingdownVM---------beginningofcrashFATALEXCEPTION:mainProcess:com.gezbox.deliv...](https://blog.csdn.net/wangxueming/article/details/80967341) 博文 [来自： 王学明](https://blog.csdn.net/wangxueming)

![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/1.1.png]]

#### [图解JDK7的_Comparison_ _method_ _violates_ its _general_ _contract_异常](https://blog.csdn.net/u013164293/article/details/50914109)

[1. 摘要前一阵遇到了一个使用Collections.sort()时报异常的问题，跟小伙伴@zhuidawugui 一起排查了一下，发现问题的原因是JDK7的排序实现改为了TimSort，之后我们又进...](https://blog.csdn.net/u013164293/article/details/50914109) 博文 [来自： 三杯五岳](https://blog.csdn.net/u013164293)

#### [java TimSort算法思路理解](https://blog.csdn.net/LG772EF/article/details/95219123)

[文章目录前言java doc介绍英文介绍译文思路参考资料前言今天线上环境报了个错：java.lang.IllegalArgumentException: Comparison method viola...](https://blog.csdn.net/LG772EF/article/details/95219123) 博文 [来自： 随风的博客](https://blog.csdn.net/LG772EF)

#### [List排序报错 - _Comparison_ _method_ _violates_ its _general_ _contract_!](https://blog.csdn.net/BruceZong/article/details/81211025)

[在JDK1.7之后，ArrayList的默认排序方式做了修改，使用TimeSort排序算法来排序但是，此排序算法比老版本的算法多了如下几个限制条件，如果不注意，排序可能会抛异常1. 自反性，compa...](https://blog.csdn.net/BruceZong/article/details/81211025) 博文 [来自： BruceZong的专栏](https://blog.csdn.net/BruceZong)

#### [_Comparison_ _method_ _violates_ its _general_ _contract_!报错解决方法](https://blog.csdn.net/qq_36802747/article/details/95453725)

[今天遇到了一个Comparison method violates its general contract!问题，本来是同一个方法一个取了前十后十，一个是显示全部，然后一个报错，一个却能正常问题，排...](https://blog.csdn.net/qq_36802747/article/details/95453725) 博文 [来自： qq\_36802747的博客](https://blog.csdn.net/qq_36802747)

#### [_Comparison_ _method_ _violates_ its _general_ _contract_；Collections.sort排序问题](https://blog.csdn.net/alinekang/article/details/89010448)

[用Collections.sort对List<Object>进行排序，本来没什么问题的， 查某一条数据的时候突然报了这个错，Comparison method violates its g...](https://blog.csdn.net/alinekang/article/details/89010448) 博文 [来自： alinekang的博客](https://blog.csdn.net/alinekang)

#### [图解JDK7的_Comparison_ _method_ _violates_ its _general_ co...\_CSDN博客](https://blog.csdn.net/liuxiao723846/article/details/53760363)
#### [..._Comparison_ _method_ _violates_ its _general_ _contract_...\_CSDN博客](https://blog.csdn.net/yanxiaosa/article/details/52595131)

![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/1.1.png]]

#### [集合排序中的 _Comparison_ _method_ _violates_ its _general_ _contract_ 异常](https://blog.csdn.net/Revered_Mars/article/details/84523707)

[异常信息 java.lang.IllegalArgumentException: Comparison method violates its general contract! at java.ut...](https://blog.csdn.net/Revered_Mars/article/details/84523707) 博文 [来自： Revered\_Mars的博客](https://blog.csdn.net/Revered_Mars)

#### [java异常:_Comparison_ _method_ _violates_ its _general_ con...\_CSDN博客](https://blog.csdn.net/TomCosin/article/details/83381221)
#### [...异常:_Comparison_ _method_ _violates_ its _general_ cont...\_CSDN博客](https://blog.csdn.net/const_/article/details/103728979)

#### [排序：这个坑，你要注意：_Comparison_ _method_ _violates_ its _general_ _contract_!](https://blog.csdn.net/hizhangyuping/article/details/83576859)

[解决方法如下：/\*\* \* 对比类：根据持有金额 \*/ private static class TenderCollectComparator implements Comparator&amp...](https://blog.csdn.net/hizhangyuping/article/details/83576859) 博文 [来自： hizhangyuping的博客](https://blog.csdn.net/hizhangyuping)

[![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/3_tomcosin.png]]](https://blog.csdn.net/TomCosin)关注
##### [TomCosin](https://blog.csdn.net/TomCosin)

22篇文章

排名:千里之外

[![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/3_weixin_39194257.jpeg]]](https://blog.csdn.net/weixin_39194257)关注
##### [自带五拨片](https://blog.csdn.net/weixin_39194257)

36篇文章

排名:千里之外

[![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/3_xvshu.jpeg]]![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/embedded.9.svg]]](https://blog.csdn.net/xvshu)关注
##### [许恕](https://blog.csdn.net/xvshu)

334篇文章

排名:1000+

[![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/3_zwbzwbzwbzwbzwbzwb.png]]](https://blog.csdn.net/zwbzwbzwbzwbzwbzwb)关注
##### [林边清泉1](https://blog.csdn.net/zwbzwbzwbzwbzwbzwb)

3篇文章

排名:千里之外

#### [图解JDK7的_Comparison_ _method_ _violates_ its _general_ co...\_CSDN博客](https://blog.csdn.net/u013164293/article/details/50914109)
#### [..._Exception_: _Comparison_ _method_ _violates_ its genera...\_CSDN博客](https://blog.csdn.net/w1235q/article/details/80705630)

#### [jdk1.7Timsort 排序异常小结](https://blog.csdn.net/lp18036194881/article/details/78601715)

[异常如下：Exception in thread "main" java.lang.IllegalArgumentException: Comparison method violates its g...](https://blog.csdn.net/lp18036194881/article/details/78601715) 博文 [来自： lp18036194881的博客](https://blog.csdn.net/lp18036194881)

#### [jdk 7 IllegalArgument_Exception_: _Comparison_ _method_ _violates_ its _general_ _contract_](https://bbs.csdn.net/topics/390191098)
#### [..._Exception_: _Comparison_ _method_ _violates_ its genera...\_CSDN博客](https://blog.csdn.net/jerry1744110/article/details/41802209)
#### [...导致_Comparison_ _method_ _violates_ its _general_ contr...\_CSDN博客](https://blog.csdn.net/wangxueming/article/details/80967341)

#### [解决 _Comparison_ _method_ _violates_ its _general_ _contract_!](https://blog.csdn.net/dielucuan8830/article/details/101753734)

[问题：Comparison method violates its general contract!报错1 Collections.sort(list, new Comparator<Inte...](https://blog.csdn.net/dielucuan8830/article/details/101753734) 博文 [来自： dielucuan8830的博客](https://blog.csdn.net/dielucuan8830)

![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/1.1.png]]

#### [排序异常:_Comparison_ _method_ _violates_ its _general_ con...\_CSDN博客](https://blog.csdn.net/Hyzzzzh/article/details/104966227)

#### [关于排序的_Comparison_ _method_ _violates_ its _general_ _contract_!错误](https://blog.csdn.net/xfnbing/article/details/49071815)

[原因：jdk6与jdk7排序算法之间存在着不兼容。jdk6默认使用 java.util.Arrays.useLegacyMergeSort进行排序；jdk7默认使用java.util.Arrays.T...](https://blog.csdn.net/xfnbing/article/details/49071815) 博文 [来自： xfnbing的专栏](https://blog.csdn.net/xfnbing)

#### [_Comparison_ _method_ _violates_ its _general_ _contract_! 錯誤](https://bbs.csdn.net/topics/390241698)

#### [_Comparison_ _method_ _violates_ its _general_ _contract_. 问题分析](https://blog.csdn.net/weixin_37882382/article/details/88826393)

[参考这篇：https://www.cnblogs.com/wendelhuang/p/7356797.html我的问题和这一篇的问题一样，引进了对 null值的处理，Java 1.6之前没有问题的，J...](https://blog.csdn.net/weixin_37882382/article/details/88826393) 博文 [来自： You can either travel or read,but either your body or soul must be on the way.](https://blog.csdn.net/weixin_37882382)

#### [JAVA比较器报错：_Comparison_ _method_ _violates_ its _general_ _contract_](https://blog.csdn.net/iteye_21201/article/details/82477138)

[java.lang.IllegalArgumentException: Comparison method violates its general contract!网上查到一个解释：Descrip...](https://blog.csdn.net/iteye_21201/article/details/82477138) 博文 [来自： Jasonshieh](https://blog.csdn.net/iteye_21201)

#### [比较器报错：_Comparison_ _method_ _violates_ its _general_ _contract_](https://blog.csdn.net/u013217071/article/details/53516280)

[转载自：http://blog.csdn.net/fanzitao/article/details/8040201Brother Zeng遇到的错误：Java.lang.IllegalArgument...](https://blog.csdn.net/u013217071/article/details/53516280) 博文 [来自： xiaowei的博客](https://blog.csdn.net/u013217071)

![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/1.1.png]]

#### [_Comparison_ _method_ _violates_ its _general_ _contract_ 解决办法](https://blog.csdn.net/zhang168/article/details/24669739)

[1、 更改Comparator内部实现，确保排序的逻辑满足以下条件：a) sng(compare(x,y)) == -sgn(compare(y,x));b) 如果(compare(x,y) > 0)...](https://blog.csdn.net/zhang168/article/details/24669739) 博文 [来自： zhang168的专栏](https://blog.csdn.net/zhang168)

#### [java Collections.sort()异常 ：_Comparison_ _method_ _violates_ its _general_ _contract_](https://blog.csdn.net/yujianbiancheng/article/details/100005718)

[java JDK7以后的版本，对集合排序函数sort底层实现类Timsort做了优化。TimSort排序是一种优化的归并排序，它将归并排序(merge sort) 与插入排序(insertion so...](https://blog.csdn.net/yujianbiancheng/article/details/100005718) 博文 [来自： 遇见编程](https://blog.csdn.net/yujianbiancheng)

#### [java-collections.sort异常_Comparison_ _method_ _violates_ its _general_ _contract_!](https://blog.csdn.net/qq_15266291/article/details/79321657)

[异常信息java.lang.IllegalArgumentException: Comparison method violates its general contract! at java.uti...](https://blog.csdn.net/qq_15266291/article/details/79321657) 博文 [来自： 张誌先生的博客](https://blog.csdn.net/qq_15266291)

#### [java错误_Comparison_ _method_ _violates_ its _general_ _contract_!](https://blog.csdn.net/mm_bit/article/details/46805693)

[今天用到Collections.sort();方法时，提示错误如下：网上查到一个解释：Description: The sorting algorithm used by java.util.Arra...](https://blog.csdn.net/mm_bit/article/details/46805693) 博文 [来自： mm\_bit的博客](https://blog.csdn.net/mm_bit)

#### [关于JDK7的IllegalArgument_Exception_:_Comparison_ _method_ _violates_ its _general_ _contract_](https://blog.csdn.net/lqadam/article/details/72810171)

[关于JDK7的IllegalArgumentException:Comparison method violates its general contract今天看社区问答的时候看到的一个问题,起因是...](https://blog.csdn.net/lqadam/article/details/72810171) 博文 [来自： lqadam的博客](https://blog.csdn.net/lqadam)

#### [Comparator异常：_Comparison_ _method_ _violates_ its _general_ _contract_!](https://blog.csdn.net/Gaugamela/article/details/78583714)

[规范比较器](https://blog.csdn.net/Gaugamela/article/details/78583714) 博文 [来自： ZhangJian的博客](https://blog.csdn.net/Gaugamela)

#### [java 【排序】异常：java.lang.IllegalArgument_Exception_: _Comparison_ _method_ _violates_ its _general_ _contract_!](https://blog.csdn.net/u013066244/article/details/80441214)

[环境java：1.7前言本来是不想写这篇的，但是最近老报这个错误，一开始，我以为解决了，后来发现不是那么回事现在特意记录下我的排序代码我先贴出完整的排序代码：/\*\* \* 支持两个字段排序 \* @par...](https://blog.csdn.net/u013066244/article/details/80441214) 博文 [来自： 山鬼谣的专栏](https://blog.csdn.net/u013066244)

#### [实质解决方法（精华帖）_Comparison_ _method_ _violates_ its _general_ _contract_!](https://blog.csdn.net/sinat_29970905/article/details/82385630)

[源码listRs = list.stream().sorted((n1, n2) -&amp;gt; { BigDecimal value1 = n1.g...](https://blog.csdn.net/sinat_29970905/article/details/82385630) 博文 [来自： 穿越整个城市的越野跑](https://blog.csdn.net/sinat_29970905)

#### [java.lang.IllegalArgument_Exception_: _Comparison_ _method_ _violates_ its _general_ _contract_!](https://blog.csdn.net/tsh18523266651/article/details/77053794)

[对一个集合里的对象按照某属性排序时，遇到问题 java.lang.IllegalArgumentException: Comparison method violates its general co...](https://blog.csdn.net/tsh18523266651/article/details/77053794) 博文 [来自： 遨游大海](https://blog.csdn.net/tsh18523266651)

#### [_Comparison_ _method_ _violates_ its _general_ _contract_ 解决](https://blog.csdn.net/adknuf1202/article/details/102167889)

[java.lang.IllegalArgumentException: Comparison method violates its general contract!原因JDK7中的Collecti...](https://blog.csdn.net/adknuf1202/article/details/102167889) 博文

#### [使用比较器 java.lang.IllegalArgument_Exception_: _Comparison_ _method_ _violates_ its _general_ _contract_! 解决办法](https://blog.csdn.net/h2453532874/article/details/88727803)

[java.lang.IllegalArgumentException: Comparison method violates its general contract! at line 899, ja...](https://blog.csdn.net/h2453532874/article/details/88727803) 博文 [来自： Mr.hu](https://blog.csdn.net/h2453532874)

#### [_Comparison_ _method_ _violates_ its _general_ _contract_ 问题的处理](https://blog.csdn.net/qq_27093465/article/details/82190723)

[java.lang.IllegalArgumentException: Comparison method violates its general contract!    at java.util...](https://blog.csdn.net/qq_27093465/article/details/82190723) 博文 [来自： 请叫我大师兄](https://blog.csdn.net/qq_27093465)

#### [mybatis异常invalid _comparison_: java.util.Date and java.lang.String](https://blog.csdn.net/daniel_fei/article/details/60883476)

[严重: Servlet.service() for servlet spring in context with path threw exception Request processi...](https://blog.csdn.net/daniel_fei/article/details/60883476) 博文 [来自： daniel\_fei的博客](https://blog.csdn.net/daniel_fei)

#### [java.lang.IllegalArgument_Exception_: invalid _comparison_: java.util.Date and java.lang.String错误解决](https://blog.csdn.net/IDEEaaa/article/details/82557583)

[一、背景在用mybatis编写sql判断时间大小时，报错： 二、错误原因编写mybatis的XML文件出错，在判空时，加入了判断空字符串的语句，无法比较 java.util.Date类型与  java...](https://blog.csdn.net/IDEEaaa/article/details/82557583) 博文 [来自： IDEEaaa的博客](https://blog.csdn.net/IDEEaaa)

#### [大学四年自学走来，这些私藏的实用工具/学习网站我贡献出来了](https://blog.csdn.net/m0_37907797/article/details/102781027)

[大学四年，看课本是不可能一直看课本的了，对于学习，特别是自学，善于搜索网上的一些资源来辅助，还是非常有必要的，下面我就把这几年私藏的各种资源，网站贡献出来给你们。主要有：电子书搜索、实用工具、在线视频...](https://blog.csdn.net/m0_37907797/article/details/102781027) 博文 [来自： 帅地](https://blog.csdn.net/m0_37907797)

#### [在中国程序员是青春饭吗？](https://blog.csdn.net/harvic880925/article/details/102850436)

[今年，我也32了 ，为了不给大家误导，咨询了猎头、圈内好友，以及年过35岁的几位老程序员……舍了老脸去揭人家伤疤……希望能给大家以帮助，记得帮我点赞哦。目录：你以为的人生 一次又一次的伤害 猎头界的真...](https://blog.csdn.net/harvic880925/article/details/102850436) 博文 [来自： 启舰](https://blog.csdn.net/harvic880925)

#### [超全Python图像处理讲解（多图预警）](https://blog.csdn.net/ZackSock/article/details/103794134)

[文章目录Pillow模块讲解一、Image模块1.1 、打开图片和显示图片1.2、创建一个简单的图像1.3、图像混合（1）透明度混合（2）遮罩混合1.4、图像缩放（1）按像素缩放（2）按尺寸缩放1.5...](https://blog.csdn.net/ZackSock/article/details/103794134) 博文 [来自： ZackSock的博客](https://blog.csdn.net/ZackSock)

#### [为什么猝死的都是程序员，基本上不见产品经理猝死呢？](https://blog.csdn.net/dfskhgalshgkajghljgh/article/details/103841693)

[相信大家时不时听到程序员猝死的消息，但是基本上听不到产品经理猝死的消息，这是为什么呢？我们先百度搜一下：程序员猝死，出现将近700多万条搜索结果：搜索一下：产品经理猝死，只有400万条的搜索结果，从搜...](https://blog.csdn.net/dfskhgalshgkajghljgh/article/details/103841693) 博文 [来自： 曹银飞的专栏](https://blog.csdn.net/dfskhgalshgkajghljgh)

#### [毕业5年，我问遍了身边的大佬，总结了他们的学习方法](https://blog.csdn.net/qq_35190492/article/details/103847147)

[我问了身边10个大佬，总结了他们的学习方法，原来成功都是有迹可循的。](https://blog.csdn.net/qq_35190492/article/details/103847147) 博文 [来自： 敖丙](https://blog.csdn.net/qq_35190492)

#### [推荐10个堪称神器的学习网站](https://blog.csdn.net/qing_gee/article/details/103869737)

[每天都会收到很多读者的私信，问我：“二哥，有什么推荐的学习网站吗？最近很浮躁，手头的一些网站都看烦了，想看看二哥这里有什么新鲜货。”今天一早做了个恶梦，梦到被老板辞退了。虽然说在我们公司，只有我辞退老...](https://blog.csdn.net/qing_gee/article/details/103869737) 博文 [来自： 沉默王二](https://blog.csdn.net/qing_gee)

#### [强烈推荐10本程序员必读的书](https://blog.csdn.net/qing_gee/article/details/104085756)

[很遗憾，这个春节注定是刻骨铭心的，新型冠状病毒让每个人的神经都是紧绷的。那些处在武汉的白衣天使们，尤其值得我们的尊敬。而我们这些窝在家里的程序员，能不外出就不外出，就是对社会做出的最大的贡献。有些读者...](https://blog.csdn.net/qing_gee/article/details/104085756) 博文 [来自： 沉默王二](https://blog.csdn.net/qing_gee)

[Java](https://java.csdn.net/) [C语言](https://c1.csdn.net/) [Python](https://python.csdn.net/) [C++](https://cplus.csdn.net/) [C#](https://csharp.csdn.net/) [Visual Basic .NET](https://vbn.csdn.net/) [JavaScript](https://js.csdn.net/) [PHP](https://php.csdn.net/) [SQL](https://sql.csdn.net/) [Go语言](https://go.csdn.net/) [R语言](https://r.csdn.net/) [Assembly language](https://assembly.csdn.net/) [Swift](https://swift.csdn.net/) [Ruby](https://ruby.csdn.net/) [MATLAB](https://matlab.csdn.net/) [PL/SQL](https://plsql.csdn.net/) [Perl](https://perl.csdn.net/) [Visual Basic](https://vb.csdn.net/) [Objective-C](https://obj.csdn.net/) [Delphi/Object Pascal](https://delphi.csdn.net/) [Unity3D](https://www.csdn.net/unity/)

©️2019 CSDN 皮肤主题: 编程工作室 设计师: CSDN官方博客

 [![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/3_jjddrushi.png]] ![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/8.5.png]]](https://blog.csdn.net/jjddrushi) 

[熊猫都爱吃](https://blog.csdn.net/jjddrushi)
[TA的个人主页 >](https://me.csdn.net/jjddrushi)

[原创](https://blog.csdn.net/jjddrushi)
[20](https://blog.csdn.net/jjddrushi)

粉丝
1

获赞
3

评论
5

访问
6万+

等级:
 [![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/embedded.10.svg]]](https://blog.csdn.net/home/help.html#level) 

周排名:
[14万+](https://blog.csdn.net/rank/writing_rank)

积分:
753

总排名:
[12万+](https://blog.csdn.net/rank/writing_rank_total)

[私信](https://im.csdn.net/im/main.html?userName=jjddrushi)

[![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/unknown_filename.2.png]]](https://www.googleadservices.com/pagead/aclk?sa=L&ai=CkTzrrc6eXrfXBNS0qAGYxb7wDIfqr8FcvpiI88AL2tkeEAEgt8iUAmDZAqAB0_z21QPIAQmpAiC5IsdtUYE-qAMByAPDBKoE6AFP0OCB5ij0HnFVybPpcL4Phtg6pb_BDJnLjWpP_zDwUtEN6VRjZajP1g4nW4tQaiLhpTnw8SFVuYUUwTWg1do5dkl10hf3BTntNJMzmaRITVOdClotaOONr_0CeYB3F2t3rvpgmfYtWlhB_xv0sB0WmHU3L7TjyY_1L0hDDZzjf5KQi7IeJa6ErgTF9WLdzg91jfDbXkXXbs_iD10KJo4E4SQhbXZ6Jy4t00KJWTJt8_qQYmMnfljTV7C4AjJ8KGDOU3LDSU-mLXd-Olw8YEFlHVtGGf6-uKRuv2z4XNYXRyyRTm8WIX2BwASK3_mi-AKQBgGgBi6AB-vm-54BiAcBkAcCqAeOzhuoB9XJG6gHk9gbqAe6BqgH8NkbqAfy2RuoB6a-G6gH7NUbqAfz0RuoB-zVG6gHltgbqAfC2hvYBwDSCAYIABACGBqxCYTpl3OSnEHIgAoBigq_AWh0dHBzOi8vYWQuZG91YmxlY2xpY2submV0L2RkbS90cmFja2Nsay9OOTAwOS4xMzQ0MjYuR09PR0xFRElTUExBWU5FVFdPUi9CMjM3Mjc2MDkuMjcwNzM0MjQyO2RjX3Rya19haWQ9NDY1MzQwNDcyO2RjX3Rya19jaWQ9MTMwNzExNDM4O2RjX2xhdD07ZGNfcmRpZD07dGFnX2Zvcl9jaGlsZF9kaXJlY3RlZF90cmVhdG1lbnQ9O3RmdWE9mAsByAsB4AsB2BMNiBQBmBYB&ae=1&num=1&cid=CAMSeQClSFh3F7nEjuy4NmpW7yUQIrF0c0Pmt7swzOCdetJXNgELHbyaBlWnHSU__GcUiRJgH7LVskSY0_W3oB8x4vVBeHxVrWVefDuLGgyiDuEM-45tiT9YmrmKsN4wRwH11cNLhc893vUAL1OzVo0FYYqyNVSY_bwEZbc&sig=AOD64_2mNS986Qk9fV1QeXRsa0q4OgZUlw&client=ca-pub-1076724771190722&nb=9&adurl=https://www.nike.com.hk/shoe/air_max_collection/list.htm%3Fcp%3Dhkns_ad_43916_a_NSWAO_am2090_adw_ptallcsafsinsp_ALL_R1_TC_1x1)

[全新NIKE Air Max 2090](https://www.googleadservices.com/pagead/aclk?sa=L&ai=CkTzrrc6eXrfXBNS0qAGYxb7wDIfqr8FcvpiI88AL2tkeEAEgt8iUAmDZAqAB0_z21QPIAQmpAiC5IsdtUYE-qAMByAPDBKoE6AFP0OCB5ij0HnFVybPpcL4Phtg6pb_BDJnLjWpP_zDwUtEN6VRjZajP1g4nW4tQaiLhpTnw8SFVuYUUwTWg1do5dkl10hf3BTntNJMzmaRITVOdClotaOONr_0CeYB3F2t3rvpgmfYtWlhB_xv0sB0WmHU3L7TjyY_1L0hDDZzjf5KQi7IeJa6ErgTF9WLdzg91jfDbXkXXbs_iD10KJo4E4SQhbXZ6Jy4t00KJWTJt8_qQYmMnfljTV7C4AjJ8KGDOU3LDSU-mLXd-Olw8YEFlHVtGGf6-uKRuv2z4XNYXRyyRTm8WIX2BwASK3_mi-AKQBgGgBi6AB-vm-54BiAcBkAcCqAeOzhuoB9XJG6gHk9gbqAe6BqgH8NkbqAfy2RuoB6a-G6gH7NUbqAfz0RuoB-zVG6gHltgbqAfC2hvYBwDSCAYIABACGBqxCYTpl3OSnEHIgAoBigq_AWh0dHBzOi8vYWQuZG91YmxlY2xpY2submV0L2RkbS90cmFja2Nsay9OOTAwOS4xMzQ0MjYuR09PR0xFRElTUExBWU5FVFdPUi9CMjM3Mjc2MDkuMjcwNzM0MjQyO2RjX3Rya19haWQ9NDY1MzQwNDcyO2RjX3Rya19jaWQ9MTMwNzExNDM4O2RjX2xhdD07ZGNfcmRpZD07dGFnX2Zvcl9jaGlsZF9kaXJlY3RlZF90cmVhdG1lbnQ9O3RmdWE9mAsByAsB4AsB2BMNiBQBmBYB&ae=1&num=1&cid=CAMSeQClSFh3F7nEjuy4NmpW7yUQIrF0c0Pmt7swzOCdetJXNgELHbyaBlWnHSU__GcUiRJgH7LVskSY0_W3oB8x4vVBeHxVrWVefDuLGgyiDuEM-45tiT9YmrmKsN4wRwH11cNLhc893vUAL1OzVo0FYYqyNVSY_bwEZbc&sig=AOD64_2mNS986Qk9fV1QeXRsa0q4OgZUlw&client=ca-pub-1076724771190722&nb=0&adurl=https://www.nike.com.hk/shoe/air_max_collection/list.htm%3Fcp%3Dhkns_ad_43916_a_NSWAO_am2090_adw_ptallcsafsinsp_ALL_R1_TC_1x1)
[![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/unknown_filename.1.png]]](https://www.googleadservices.com/pagead/aclk?sa=L&ai=CkTzrrc6eXrfXBNS0qAGYxb7wDIfqr8FcvpiI88AL2tkeEAEgt8iUAmDZAqAB0_z21QPIAQmpAiC5IsdtUYE-qAMByAPDBKoE6AFP0OCB5ij0HnFVybPpcL4Phtg6pb_BDJnLjWpP_zDwUtEN6VRjZajP1g4nW4tQaiLhpTnw8SFVuYUUwTWg1do5dkl10hf3BTntNJMzmaRITVOdClotaOONr_0CeYB3F2t3rvpgmfYtWlhB_xv0sB0WmHU3L7TjyY_1L0hDDZzjf5KQi7IeJa6ErgTF9WLdzg91jfDbXkXXbs_iD10KJo4E4SQhbXZ6Jy4t00KJWTJt8_qQYmMnfljTV7C4AjJ8KGDOU3LDSU-mLXd-Olw8YEFlHVtGGf6-uKRuv2z4XNYXRyyRTm8WIX2BwASK3_mi-AKQBgGgBi6AB-vm-54BiAcBkAcCqAeOzhuoB9XJG6gHk9gbqAe6BqgH8NkbqAfy2RuoB6a-G6gH7NUbqAfz0RuoB-zVG6gHltgbqAfC2hvYBwDSCAYIABACGBqxCYTpl3OSnEHIgAoBigq_AWh0dHBzOi8vYWQuZG91YmxlY2xpY2submV0L2RkbS90cmFja2Nsay9OOTAwOS4xMzQ0MjYuR09PR0xFRElTUExBWU5FVFdPUi9CMjM3Mjc2MDkuMjcwNzM0MjQyO2RjX3Rya19haWQ9NDY1MzQwNDcyO2RjX3Rya19jaWQ9MTMwNzExNDM4O2RjX2xhdD07ZGNfcmRpZD07dGFnX2Zvcl9jaGlsZF9kaXJlY3RlZF90cmVhdG1lbnQ9O3RmdWE9mAsByAsB4AsB2BMNiBQBmBYB&ae=1&num=1&cid=CAMSeQClSFh3F7nEjuy4NmpW7yUQIrF0c0Pmt7swzOCdetJXNgELHbyaBlWnHSU__GcUiRJgH7LVskSY0_W3oB8x4vVBeHxVrWVefDuLGgyiDuEM-45tiT9YmrmKsN4wRwH11cNLhc893vUAL1OzVo0FYYqyNVSY_bwEZbc&sig=AOD64_2mNS986Qk9fV1QeXRsa0q4OgZUlw&client=ca-pub-1076724771190722&nb=19&adurl=https://www.nike.com.hk/shoe/air_max_collection/list.htm%3Fcp%3Dhkns_ad_43916_a_NSWAO_am2090_adw_ptallcsafsinsp_ALL_R1_TC_1x1)
[NIKE Air Max 2090將Air Max 90
進化演繹，將今天的想像，延伸到
未來。](https://www.googleadservices.com/pagead/aclk?sa=L&ai=CkTzrrc6eXrfXBNS0qAGYxb7wDIfqr8FcvpiI88AL2tkeEAEgt8iUAmDZAqAB0_z21QPIAQmpAiC5IsdtUYE-qAMByAPDBKoE6AFP0OCB5ij0HnFVybPpcL4Phtg6pb_BDJnLjWpP_zDwUtEN6VRjZajP1g4nW4tQaiLhpTnw8SFVuYUUwTWg1do5dkl10hf3BTntNJMzmaRITVOdClotaOONr_0CeYB3F2t3rvpgmfYtWlhB_xv0sB0WmHU3L7TjyY_1L0hDDZzjf5KQi7IeJa6ErgTF9WLdzg91jfDbXkXXbs_iD10KJo4E4SQhbXZ6Jy4t00KJWTJt8_qQYmMnfljTV7C4AjJ8KGDOU3LDSU-mLXd-Olw8YEFlHVtGGf6-uKRuv2z4XNYXRyyRTm8WIX2BwASK3_mi-AKQBgGgBi6AB-vm-54BiAcBkAcCqAeOzhuoB9XJG6gHk9gbqAe6BqgH8NkbqAfy2RuoB6a-G6gH7NUbqAfz0RuoB-zVG6gHltgbqAfC2hvYBwDSCAYIABACGBqxCYTpl3OSnEHIgAoBigq_AWh0dHBzOi8vYWQuZG91YmxlY2xpY2submV0L2RkbS90cmFja2Nsay9OOTAwOS4xMzQ0MjYuR09PR0xFRElTUExBWU5FVFdPUi9CMjM3Mjc2MDkuMjcwNzM0MjQyO2RjX3Rya19haWQ9NDY1MzQwNDcyO2RjX3Rya19jaWQ9MTMwNzExNDM4O2RjX2xhdD07ZGNfcmRpZD07dGFnX2Zvcl9jaGlsZF9kaXJlY3RlZF90cmVhdG1lbnQ9O3RmdWE9mAsByAsB4AsB2BMNiBQBmBYB&ae=1&num=1&cid=CAMSeQClSFh3F7nEjuy4NmpW7yUQIrF0c0Pmt7swzOCdetJXNgELHbyaBlWnHSU__GcUiRJgH7LVskSY0_W3oB8x4vVBeHxVrWVefDuLGgyiDuEM-45tiT9YmrmKsN4wRwH11cNLhc893vUAL1OzVo0FYYqyNVSY_bwEZbc&sig=AOD64_2mNS986Qk9fV1QeXRsa0q4OgZUlw&client=ca-pub-1076724771190722&nb=7&adurl=https://www.nike.com.hk/shoe/air_max_collection/list.htm%3Fcp%3Dhkns_ad_43916_a_NSWAO_am2090_adw_ptallcsafsinsp_ALL_R1_TC_1x1)
[![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/unknown_filename.png]]](https://www.googleadservices.com/pagead/aclk?sa=L&ai=CkTzrrc6eXrfXBNS0qAGYxb7wDIfqr8FcvpiI88AL2tkeEAEgt8iUAmDZAqAB0_z21QPIAQmpAiC5IsdtUYE-qAMByAPDBKoE6AFP0OCB5ij0HnFVybPpcL4Phtg6pb_BDJnLjWpP_zDwUtEN6VRjZajP1g4nW4tQaiLhpTnw8SFVuYUUwTWg1do5dkl10hf3BTntNJMzmaRITVOdClotaOONr_0CeYB3F2t3rvpgmfYtWlhB_xv0sB0WmHU3L7TjyY_1L0hDDZzjf5KQi7IeJa6ErgTF9WLdzg91jfDbXkXXbs_iD10KJo4E4SQhbXZ6Jy4t00KJWTJt8_qQYmMnfljTV7C4AjJ8KGDOU3LDSU-mLXd-Olw8YEFlHVtGGf6-uKRuv2z4XNYXRyyRTm8WIX2BwASK3_mi-AKQBgGgBi6AB-vm-54BiAcBkAcCqAeOzhuoB9XJG6gHk9gbqAe6BqgH8NkbqAfy2RuoB6a-G6gH7NUbqAfz0RuoB-zVG6gHltgbqAfC2hvYBwDSCAYIABACGBqxCYTpl3OSnEHIgAoBigq_AWh0dHBzOi8vYWQuZG91YmxlY2xpY2submV0L2RkbS90cmFja2Nsay9OOTAwOS4xMzQ0MjYuR09PR0xFRElTUExBWU5FVFdPUi9CMjM3Mjc2MDkuMjcwNzM0MjQyO2RjX3Rya19haWQ9NDY1MzQwNDcyO2RjX3Rya19jaWQ9MTMwNzExNDM4O2RjX2xhdD07ZGNfcmRpZD07dGFnX2Zvcl9jaGlsZF9kaXJlY3RlZF90cmVhdG1lbnQ9O3RmdWE9mAsByAsB4AsB2BMNiBQBmBYB&ae=1&num=1&cid=CAMSeQClSFh3F7nEjuy4NmpW7yUQIrF0c0Pmt7swzOCdetJXNgELHbyaBlWnHSU__GcUiRJgH7LVskSY0_W3oB8x4vVBeHxVrWVefDuLGgyiDuEM-45tiT9YmrmKsN4wRwH11cNLhc893vUAL1OzVo0FYYqyNVSY_bwEZbc&sig=AOD64_2mNS986Qk9fV1QeXRsa0q4OgZUlw&client=ca-pub-1076724771190722&nb=8&adurl=https://www.nike.com.hk/shoe/air_max_collection/list.htm%3Fcp%3Dhkns_ad_43916_a_NSWAO_am2090_adw_ptallcsafsinsp_ALL_R1_TC_1x1)

![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/embedded.11.svg]]

![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/embedded.12.svg]]

![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/1.1.png]]

### 最新文章

*   [Kali Linux安装报错Detect and mount CD-ROM](https://blog.csdn.net/jjddrushi/article/details/89930709)
*   [centos7下 mysql5.7.9（8.0）启动失败问题](https://blog.csdn.net/jjddrushi/article/details/83827945)
*   [WIN10退出microsoft帐号](https://blog.csdn.net/jjddrushi/article/details/83658884)
*   [Swagger2+SpringMVC整合](https://blog.csdn.net/jjddrushi/article/details/80511638)
*   [chrome黑屏解决](https://blog.csdn.net/jjddrushi/article/details/79155421)

### 分类专栏

*    [![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/20190918140145169.png]] Exceptions  9篇](https://blog.csdn.net/jjddrushi/category_6305301.html) 
*    [![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/20190927151026427.png]] 异常总结  2篇](https://blog.csdn.net/jjddrushi/category_6322785.html) 
*    [![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/20190927151043371.png]] java  3篇](https://blog.csdn.net/jjddrushi/category_6370153.html) 
*    [![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/20190927151117521.png]] fetch  3篇](https://blog.csdn.net/jjddrushi/category_6368449.html) 
*    [![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/20190927151132530.png]] 算法  1篇](https://blog.csdn.net/jjddrushi/category_6383285.html) 
*    [![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/20190927151053287.png]] 前端  1篇](https://blog.csdn.net/jjddrushi/category_6479276.html) 
*    [![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/20190927151132530.png]] 系统  2篇](https://blog.csdn.net/jjddrushi/category_6497909.html) 
*    [![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/20190927151124774.png]] 框架](https://blog.csdn.net/jjddrushi/category_7605065.html) 
*    [![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/2019091813595558.png]] 插件  1篇](https://blog.csdn.net/jjddrushi/category_7701352.html) 
*    [![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/20190918140213434.png]] 杂说  1篇](https://blog.csdn.net/jjddrushi/category_8298178.html) 
*    [![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/20190918140012416.png]] web安全  1篇](https://blog.csdn.net/jjddrushi/category_8927188.html) 

### 归档

2019

[5月 1篇](https://blog.csdn.net/jjddrushi/article/month/2019/05)

2018

[11月 2篇](https://blog.csdn.net/jjddrushi/article/month/2018/11)
[5月 1篇](https://blog.csdn.net/jjddrushi/article/month/2018/05)
[1月 1篇](https://blog.csdn.net/jjddrushi/article/month/2018/01)

2017

[12月 1篇](https://blog.csdn.net/jjddrushi/article/month/2017/12)
[3月 1篇](https://blog.csdn.net/jjddrushi/article/month/2017/03)

2016

[12月 1篇](https://blog.csdn.net/jjddrushi/article/month/2016/12)
[11月 2篇](https://blog.csdn.net/jjddrushi/article/month/2016/11)
[10月 4篇](https://blog.csdn.net/jjddrushi/article/month/2016/10)
[9月 1篇](https://blog.csdn.net/jjddrushi/article/month/2016/09)
[8月 7篇](https://blog.csdn.net/jjddrushi/article/month/2016/08)
[7月 3篇](https://blog.csdn.net/jjddrushi/article/month/2016/07)

### 热门文章

*   [关于I5六代CPU安装win7系统的问题](https://blog.csdn.net/jjddrushi/article/details/52996753)
    
    阅读数 24200
    
*   [chrome黑屏解决](https://blog.csdn.net/jjddrushi/article/details/79155421)
    
    阅读数 7950
    
*   [WIN10退出microsoft帐号](https://blog.csdn.net/jjddrushi/article/details/83658884)
    
    阅读数 6429
    
*   [Swagger2+SpringMVC整合](https://blog.csdn.net/jjddrushi/article/details/80511638)
    
    阅读数 4850
    
*   [爬虫中使用HttpClient发送ajax请求，并处理返回的JSON字符串](https://blog.csdn.net/jjddrushi/article/details/52292760)
    
    阅读数 4596
    

### 最新评论

*   [centos7下 mysql5.7...](https://blog.csdn.net/jjddrushi/article/details/83827945#comments)
    
    ... [quanjiafu0122：](https://my.csdn.net/quanjiafu0122)有用，谢谢
    
*   [centos7下 mysql5.7...](https://blog.csdn.net/jjddrushi/article/details/83827945#comments)
    
    ... [lupus721：](https://my.csdn.net/lupus721)呵呵，竟然是针对，有用。。。
    
*   [centos7下 mysql5.7...](https://blog.csdn.net/jjddrushi/article/details/83827945#comments)
    
    ... [qinglingLS：](https://my.csdn.net/qinglingLS)对的，原因在于你原本安装了mysql5.x，然后你没有删除相关联的文件就给新安装了mysql8，所以当mysql8启动的时候，他就会自动想要redo，但是显然这个行为会失败，从而导致了启动问题。
    
*   [centos7下 mysql5.7...](https://blog.csdn.net/jjddrushi/article/details/83827945#comments)
    
    ... [weixin\_43294577：](https://my.csdn.net/weixin_43294577)这个方法有用，成功了
    
*   [Swagger2+SpringMV...](https://blog.csdn.net/jjddrushi/article/details/80511638#comments)
    
    ... [zhu\_\_si：](https://my.csdn.net/zhu__si)你好，swagger加入Spring MVC后影响到了视图解析器，导致项目不能运行，只能看swagger-ui.html要怎么搞啊
    

![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/1.1.png]]

![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/embedded.13.svg]][kefu@csdn.net](https://blog.csdn.net/jjddrushi/article/details/53788295mailto:webmaster@csdn.net) _![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/embedded.14.svg]][QQ客服](https://url.cn/5epoHIm?_type=wpa&qidian=true)_

_![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/embedded.15.svg]][客服论坛](http://bbs.csdn.net/forums/Service)_ ![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/embedded.16.svg]]400-660-0108

工作时间 8:30-22:00

[关于我们](https://www.csdn.net/company/index.html#about)[招聘](https://www.csdn.net/company/index.html#recruit)[广告服务](https://www.csdn.net/company/index.html#advertisement) [网站地图](https://www.csdn.net/gather/A)

[京ICP备19004658号](http://beian.miit.gov.cn/publish/query/indexFirst.action) [经营性网站备案信息](https://csdnimg.cn/cdn/content-toolbar/csdn-ICP.png)

![[./_resources/Exception：Comparison_method_violates_its_general_contract!_Java_jjddrushi的专栏-CSDN博客.resources/gongan.png]][公安备案号 11010502030143](http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11010502030143)

[京网文〔2020〕1039-165号](https://csdnimg.cn/release/live_fe/culture_license.png)

©1999-2020 北京创新乐知网络技术有限公司 [网络110报警服务](http://www.cyberpolice.cn/)

[北京互联网违法和不良信息举报中心](http://www.bjjubao.org/)

[中国互联网举报中心](http://www.12377.cn/)[家长监护](https://download.csdn.net/index.php/tutelage/)

[版权与免责声明](https://www.csdn.net/company/index.html#statement)[版权申诉](https://blog.csdn.net/blogdevteam/article/details/90369522)

    Created at: 2020-04-21T18:46:53+08:00
    Updated at: 2020-04-21T18:46:53+08:00


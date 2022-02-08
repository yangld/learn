
![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/embedded.svg]]![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/embedded.1.svg]]

*   [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/csdnlogo.png]]](https://www.csdn.net/)
*   [首页](https://www.csdn.net/)
*   [博客](https://blog.csdn.net/)
*   [学院](https://edu.csdn.net/)
*   [下载](https://download.csdn.net/)
*   [论坛](https://bbs.csdn.net/)
*   [APP](https://www.csdn.net/apps/download?code=pc_1555579859)
*   [问答](https://ask.csdn.net/)
*   [商城](https://h5.youzan.com/v2/showcase/homepage?alias=BUj3rrGa2J&ps=760)
*   [活动](https://huiyi.csdn.net/)
*   [VIP会员](https://mall.csdn.net/vip)![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/vipimg.png]]
*   [专题](https://spec.csdn.net/)
*   [招聘](http://job.csdn.net/)
*   [ITeye](http://www.iteye.com/)
*   [GitChat](https://gitbook.cn/?ref=csdn)
*   [图文课](https://gitchat.csdn.net/?utm_source=csdn_toolbar)

*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/csdn-search.png]]](https://so.csdn.net/so/) 
    
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/csdn-xie.png]] 写博客](https://mp.csdn.net/postedit)
*   [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/message-icon.png]]消息](https://i.csdn.net/#/msg/index)
*   [登录](https://passport.csdn.net/account/login)[注册](https://passport.csdn.net/account/login)

![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/1.3.png]]

转

# \[Linux\]Mac OSX 命令行下控制 Wifi命令

2016年06月19日 13:47:41 [王珂的个人笔记](https://me.csdn.net/cn_wk) 阅读数 8685更多
分类专栏： [linux](https://blog.csdn.net/cn_wk/article/category/5931771)

## Mac OSX 命令行下控制 Wifi命令

Mac 命令行下查看当前 Wifi网络设备名称

|     |     |
| --- | --- |
| 1<br>2 | networksetup \-listallhardwareports<br>//或者 使用 ifconfig 查找 Wifi 设备名称 |

本人结果如下，可以看到我的 Wifi 设备名称为 **en0** 后面命令需要该设备名称。

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16 | eagle@macbook ~ networksetup \-listallhardwareports<br><br>Hardware Port: Bluetooth DUN<br>Device: Bluetooth\-Modem<br>Ethernet Address: N/A<br><br>Hardware Port: Wi\-Fi<br>Device: en0<br>Ethernet Address: 20:c9:d0:84:d4:e3<br><br>Hardware Port: Bluetooth PAN<br>Device: en3<br>Ethernet Address: 20:c9:d0:84:d4:e4<br><br>VLAN Configurations<br>\===\===\===\===\===\===\= |

关闭 Wifi

|     |     |
| --- | --- |
| 1   | networksetup \-setairportpower en0 off |

启动 Wifi

|     |     |
| --- | --- |
| 1   | networksetup \-setairportpower en0 on |

扫描附近可用 Wifi热点

|     |     |
| --- | --- |
| 1   | /System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport scan |

加入 Wifi

|     |     |
| --- | --- |
| 1<br>2 | networksetup \-setairportnetwork en0 WIFI\_SSID\_I\_WANT\_TO\_JOIN WIFI\_PASSWORD<br>//例如：networksetup -setairportnetwork en0  TP\_LINK\_110  12345678 |

**networksetup** 其他用法 参考 Apple 文档 或 直接执行命令 **man networksetup**

###### <https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man8/networksetup.8.html>

赚翻了!股神狱中曝出庄家洗盘规律，牢记这3点，看完焕然大悟！ 巨景 · 顶新

![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/1.3.png]]

 [[# | ![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/anonymous-User-img.png]]]] 

#### [_Mac_OS通过_命令行_搜索文件](https://blog.csdn.net/yjk13703623757/article/details/77987029)

[1.通过Find命令搜索文件find命令非常高效，并且使用简单。find命令来自unix，macOS和Linux系统同样支持该命令。find最基本的操作就是：find文件路径参数比如，你在当前用户文件...](https://blog.csdn.net/yjk13703623757/article/details/77987029) 博文 [来自： yjk13703623757的博客](https://blog.csdn.net/yjk13703623757)

#### [_mac_\__命令行_下_控制_Wi-Fi](https://blog.csdn.net/S_gy_Zetrov/article/details/78078801)

[Mac命令行下查看当前Wifi网络设备名称首先命令行输入networksetup-listallhardwareports在命令行中返回的结果中找Wi-Fi的设备名，通常是en0//...//omit...](https://blog.csdn.net/S_gy_Zetrov/article/details/78078801) 博文 [来自： S\_gy\_Zetrov的博客](https://blog.csdn.net/S_gy_Zetrov)

#### [使用常见的网络_命令_查看当前网络状态——_Mac_ OS X篇](https://blog.csdn.net/zkh90644/article/details/50539948)

[此篇文章是本人第一次翻译，如有不妥，请见谅。本文主要讲述了不同的网络状态对应的不同现象的解决方法和常用的MacOSX下网络测试命令。...](https://blog.csdn.net/zkh90644/article/details/50539948) 博文 [来自： zkh90644的博客](https://blog.csdn.net/zkh90644)

#### [_Mac_OS下_命令行_安装神器brew](https://blog.csdn.net/qq_34870631/article/details/83147422)

[1、安装brew：/usr/bin/ruby-e&quot;$(curl-fsSLhttps://raw.githubusercontent.com/Homebrew/install/master/i...](https://blog.csdn.net/qq_34870631/article/details/83147422) 博文 [来自： LinuxBegin的博客](https://blog.csdn.net/qq_34870631)

脂肪杀手，饭后坚持吃点它，轻松到90斤！ 舜飞
![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/1.3.png]]

#### [_Mac_ OS X 用终端破解附近 _Wifi_ 密码教程](https://blog.csdn.net/jackshiny/article/details/52008102)

[首先需要确保电脑装有Xcode和homebrew。1sudobrewinstallaircrack-ng等待一段时间安装，然后使用mac系统下自带的airport进行附近wifi信号的监测。首先我们将...](https://blog.csdn.net/jackshiny/article/details/52008102) 博文 [来自： jackshiny的专栏](https://blog.csdn.net/jackshiny)

#### [_mac_OS - networksetup _命令_](https://blog.csdn.net/lovechris00/article/details/81631050)

[networksetupnetworksetupSYNOPSIS方法示例输入下面命令，可查看很多可用的网络命令：mannetworksetup可以知道networksetup命令地址是：/usr/sb...](https://blog.csdn.net/lovechris00/article/details/81631050) 博文 [来自： Mac 慢慢学](https://blog.csdn.net/lovechris00)

#### [_mac__命令行_配置网络](https://blog.csdn.net/BoArmy/article/details/51221237)

[mac命令行配置网络今天终于找到了MacOSX通过命令行修改ip的方式了,记录如下：修改mac地址,重启后失效sudoifconfigen0lladdrd0:67:e5:2e:07:f1修改路由表,同...](https://blog.csdn.net/BoArmy/article/details/51221237) 博文 [来自： BoArmy的专栏](https://blog.csdn.net/BoArmy)

#### [airport – 极少人知道的_命令行_无线工具](https://blog.csdn.net/github_33644920/article/details/52827946)

[配置软链接sudoln-s/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airpo...](https://blog.csdn.net/github_33644920/article/details/52827946) 博文 [来自： 极客世杰](https://blog.csdn.net/github_33644920)

#### [_Mac_ _OSX_ 快捷键&_命令行_](https://blog.csdn.net/chuangzaozhe1/article/details/12869109)

[一.MacOSX快捷键ctrl+shift                  快速放大dock的图标会暂时放大，而如果你开启了dock放大Command+Option+W        将所有窗口关闭...](https://blog.csdn.net/chuangzaozhe1/article/details/12869109) 博文 [来自： No Excuses! Confidence! Vigorous！](https://blog.csdn.net/chuangzaozhe1)

#### [_Linux__Mac_ _OSX_ _命令行_下_控制_ _Wifi__命令_ - CSDN博客](http://blog.csdn.net/cn_wk/article/details/51712118)
#### [_mac_\__命令行_下_控制_Wi-Fi - S\_gy\_Zetrov的博客 - CSDN博客](https://blog.csdn.net/s_gy_zetrov/article/details/78078801)

2019减肥新方法，每天一杯，排毒养颜！ 舜飞
![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/1.3.png]]

#### [在终端配置当前网络的网络代理](https://blog.csdn.net/wjxiz/article/details/45159637)

[今天重新准备重新安装Mac系统，于是进入recovery盘进行重新下载安装。这个时候遇到问题了：我所在的pacaterie的网络（速度超快10m/s不是梦）是需要配置代理的，可是recovery里面是...](https://blog.csdn.net/wjxiz/article/details/45159637) 博文 [来自： wjxiz的专栏](https://blog.csdn.net/wjxiz)

#### [_Mac_OS系统使用系列-3._Mac__命令行__命令_学习 - 拾春华 让思...\_CSDN博客](https://blog.csdn.net/cshichunhua/article/details/78299472)
#### [_MAC__OSX_ 网络诊断_命令_ - Iris\_plus的专栏 - CSDN博客](https://blog.csdn.net/iris_plus/article/details/51511582)

#### [_Mac_网卡_命令行_](https://blog.csdn.net/Hynial/article/details/78884649)

[网络设置：netstat-rsudoroute-ndelete-net0.0.0.0sudoroute-nadd-net10.197.0.0-netmask255.255.0.010.197.102....](https://blog.csdn.net/Hynial/article/details/78884649) 博文 [来自： Hynial的博客](https://blog.csdn.net/Hynial)

[![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/3_yjk13703623757.jpg]]](https://blog.csdn.net/yjk13703623757)关注
##### [Locutus](https://blog.csdn.net/yjk13703623757)

491篇文章

排名:2000+

[![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/3_s_gy_zetrov.jpg]]](https://blog.csdn.net/S_gy_Zetrov)关注
##### [sgyzetrov](https://blog.csdn.net/S_gy_Zetrov)

201篇文章

排名:千里之外

[![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/3_zkh90644.jpg]]](https://blog.csdn.net/zkh90644)关注
##### [zkhCreator](https://blog.csdn.net/zkh90644)

20篇文章

排名:千里之外

[![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/3_qq_34870631.jpg]]](https://blog.csdn.net/qq_34870631)关注
##### [LinuxBegin](https://blog.csdn.net/qq_34870631)

50篇文章

排名:千里之外

#### [1、_Mac_ _OSX__命令行_ - weixin\_34401479的博客 - CSDN博客](https://blog.csdn.net/weixin_34401479/article/details/90856302)
#### [_Mac_ _OSX_网络诊断_命令_ - 冲吧,不要停! - CSDN博客](https://blog.csdn.net/hotdust/article/details/53900274)
#### [_Mac_ _OSX_ _命令行_知识](https://download.csdn.net/download/weihbsh/1669508)

#### [_mac_ _osx_ _命令行_修改主机名](https://blog.csdn.net/youcharming/article/details/51259089)

[scutil--setHostNamehz-ng-shield2-sta2hz-ng-shield1-sta2:~root#scutil--setHostNamehz-ng-shield2-sta2h...](https://blog.csdn.net/youcharming/article/details/51259089) 博文 [来自： youcharming的专栏](https://blog.csdn.net/youcharming)

#### [_Mac_ _OSX_ 快捷键&_命令行_ - weixin\_33907511的博客 - CSDN博客](https://blog.csdn.net/weixin_33907511/article/details/93394176)
#### [_mac_ _命令行_配置 - weixin\_34019929的博客 - CSDN博客](https://blog.csdn.net/weixin_34019929/article/details/90876990)

#### [_Mac_ _OSX_下使用apt-get_命令_](https://blog.csdn.net/Mark_Lewis/article/details/80426515)

[apt-get是debian(Ubuntu)才有的包管理器macosx下应使用brew，或Finkbrew 全称Homebrew，是MacOSX上的软件包管理工具，能在Mac中方便的安装软件或者卸载软...](https://blog.csdn.net/Mark_Lewis/article/details/80426515) 博文 [来自： Mark\_Lewis的博客](https://blog.csdn.net/Mark_Lewis)

关闭
学院广告

[反转！“只问了1个框架，就给了35K的Python岗”

学Python的程序员建议收藏！](https://kunyu.csdn.net/?d=2&m=tpJcQQHAcADbJyEiHJAnLicppipQJmLScSbbLEAHXJpScAELHDJXQpHibLQJApibWEAiJitbJcLDntitnnpooSovQtnmHJEEcQEQ&k=&dest=https%3A%2F%2Fedu.csdn.net%2Ftopic%2Fpython115%3Futm_source%3Dblogfeed2)

![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/1.3.png]]

#### [_Mac_ _OSX_ 快捷键&_命令行_ - weixin\_33795743的博客 - CSDN博客](https://blog.csdn.net/weixin_33795743/article/details/91737417)
#### [_Mac__命令行_登录\_srun3000网络认证 - lemonTree的博客 - CSDN博客](https://blog.csdn.net/scylhy/article/details/81429397)

#### [_Linux_ _命令行_下连接_WiFi_](https://blog.csdn.net/qq_33917045/article/details/80468912)

 [ 之前用了很久的一个dell笔记本因为一天之内让我见识了四种不同的蓝屏代码所以终于退役了。。。换了一个联想拯救者R720，然而这也不是什么省心的笔记本——一装linux就卡死。今天受百...](https://blog.csdn.net/qq_33917045/article/details/80468912) 博文 [来自： KALI linux新版折腾笔记](https://blog.csdn.net/qq_33917045)

#### [_Mac_如何共享_wifi_热点](https://blog.csdn.net/guang_s/article/details/84643801)

[一、打开系统偏好设置，点击“共享”二、点击“互联网共享”（先不要勾选），设置右边选项，最后点击“Wi-Fi选项”三、设置WiFi密码四、设置完成后，勾选“互联网共享”，确定启动五、手机连接Mac共享的...](https://blog.csdn.net/guang_s/article/details/84643801) 博文 [来自： 猿始森林](https://blog.csdn.net/guang_s)

#### [_MAC__OSX_ 网络诊断_命令_](https://blog.csdn.net/Iris_plus/article/details/51511582)

[1基本工具 网络诊断的第一步，是了解自己的设备，比如有哪些接口，IP地址都是什么。 ifconfig 显示网络接口(interface)信息。如接口名称，接口类型，接口的IP地址，硬件的MAC地址等。...](https://blog.csdn.net/Iris_plus/article/details/51511582) 博文 [来自： Iris\_plus的专栏](https://blog.csdn.net/Iris_plus)

#### [_MAC_ OS X airport command](https://blog.csdn.net/meganli/article/details/9036859)

[Strangelyhiddenfromthecasualuserisaspiffycommandlineutilitythatallowsyoutoview,configure,andtroubles...](https://blog.csdn.net/meganli/article/details/9036859) 博文 [来自： meganli的专栏](https://blog.csdn.net/meganli)

#### [解决_mac_系统下无法手动设置ip的问题](https://blog.csdn.net/yuquan0821/article/details/51726329)

[无效的服务器地址BasicIPv6ValidationError➜ ~networksetup-listallnetworkservices ➜ ~networksetup-setv6off"Ethe...](https://blog.csdn.net/yuquan0821/article/details/51726329) 博文 [来自： yuquan0821的专栏](https://blog.csdn.net/yuquan0821)

关闭
学院广告

[羡慕AI高薪岗！为什么这类程序员不建议大家转型？

被众多开发工程师羡慕的AI程序员为啥这么高薪！30w只是白菜价有啥要求？](https://kunyu.csdn.net/?d=2&m=cEQQinnbSbinHncpbbiDyHcQEmLtvbJLAHXJEitiDLHSEbSJDAnAXEUJHtEpLQWbQbAnJJLoipbovpJUAypEUnJpXinEbHitJcQQ&k=&dest=https%3A%2F%2Fedu.csdn.net%2Ftopic%2Fai30%3Futm_source%3Dblogfeed5)

![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/1.3.png]]

#### [_Mac_ OS下的_wifi_配置工具](https://blog.csdn.net/liteblue/article/details/49497893)

[为了用mac抓取802.11ac的空口包，需要用到MacOS下的配置wifi的工具。找了半天没有iwconfig/wpa\_supplicant命令，但是发现了airport这个命令。虽然不是很熟悉，但...](https://blog.csdn.net/liteblue/article/details/49497893) 博文 [来自： AG blog](https://blog.csdn.net/liteblue)

#### [_Mac_ OS X上使用Wireshark抓包](https://blog.csdn.net/phunxm/article/details/38590561)

[本文记录了在MacOSX上安装XQuartz+Wireshark以及使用Wireshark进行抓包（通过RVI抓取iPhone数据包）的步骤过程。...](https://blog.csdn.net/phunxm/article/details/38590561) 博文 [来自： 曾梦想仗剑走天涯](https://blog.csdn.net/phunxm)

#### [_Mac_ _Wifi_ 使用模式切换小记](https://blog.csdn.net/johnnycode/article/details/48294941)

[相信很多人都有这样的感受..公司使用192.168.1.\*网段而家使用10.0.0.\*网段,而开发过程中很多调试需要连接本机,所以本机IP必须静态IP才可以!!...](https://blog.csdn.net/johnnycode/article/details/48294941) 博文 [来自： 王吉军-全栈工程师](https://blog.csdn.net/johnnycode)

#### [获取路由器的_Mac_地址和当前的iP地址](https://blog.csdn.net/hechenghai/article/details/45318109)

[packagecom.example.atest;importandroid.content.Context;importandroid.net.ConnectivityManager;importa...](https://blog.csdn.net/hechenghai/article/details/45318109) 博文 [来自： hechenghai](https://blog.csdn.net/hechenghai)

#### [_Mac_OS X _命令行_破解_wifi_密码](https://blog.csdn.net/u010105234/article/details/50330391)

[部分内容转自网络此方法是抓包，然后跑字典完成的，时间长短就看电脑的配置成不成功看的是字典够不够强大MacPorts使用（MacPorts详细信息查看这篇：http://blog.csdn.net/u0...](https://blog.csdn.net/u010105234/article/details/50330391) 博文 [来自： SmileTime的小窝](https://blog.csdn.net/u010105234)

关闭
学院
广告

[免费直播分享计算机视觉技术之人脸识别实战（领取课件+源码）

快速通过人脸识别及姿态估计项目实训建立对计算机视觉核心技术的探索](https://kunyu.csdn.net/?d=2&m=icASSbtfvpHpJbibcSmJJLUbAbLiAHcbSLctooESiHAJnSipXUpEJHbvvDLEbEHQAWnQJiEcUfJpSJobcyppnyApAHDppSQLttJQ&k=&dest=https%3A%2F%2Fedu.csdn.net%2FhuiyiCourse%2Fdetail%2F1051%3Futm_source%3Dblogfeed1051)

![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/1.3.png]]

#### [_mac_ _命令行_su使用](https://blog.csdn.net/chenguibao/article/details/46507457)

[mac上，一开始系统进入创建的用户是具有管理员权限的用户，但是那个密码，却不是进入root的密码，当运行su-这个命令时，想进入root用户，发现需要输入密码，而输入自己用户密码后报su：sorry，...](https://blog.csdn.net/chenguibao/article/details/46507457) 博文 [来自： chen](https://blog.csdn.net/chenguibao)

#### [_mac_ os _命令行__命令_](https://blog.csdn.net/kelly_fumiao/article/details/88390055)

[命令chmod命令:用于改变文件或目录的访问权限https://blog.csdn.net/adwfcu/article/details/7720893...](https://blog.csdn.net/kelly_fumiao/article/details/88390055) 博文 [来自： kelly\_fumiao的博客](https://blog.csdn.net/kelly_fumiao)

#### [_Mac_ 下_命令行_自动补全_命令_](https://blog.csdn.net/superweiyan/article/details/51423746)

[用vim打开.inputrc,输入下面内容setcompletion-ignore-caseonsetshow-all-if-ambiguousonTAB:menu-complete保存，重启命令行即...](https://blog.csdn.net/superweiyan/article/details/51423746) 博文 [来自： superweiyan的博客](https://blog.csdn.net/superweiyan)

#### [_Mac_ _命令行_下 ll_命令_](https://blog.csdn.net/herehear/article/details/76572208)

[Mac下命令行里是没有ll命令的，但是Linux用熟悉里很别扭，于是自己写了一个ll由于需要用到root权限，但是默认状态下，Mac是没有root用户的自己建root用户sudopasswdroot然...](https://blog.csdn.net/herehear/article/details/76572208) 博文 [来自： herehear的博客](https://blog.csdn.net/herehear)

#### [_Mac_ _Linux_ _命令行_入门](https://blog.csdn.net/weixin_43826596/article/details/90544275)

[参考https://blog.csdn.net/fungleo/article/details/78488656写的超级好ssh-i~/ssh\_my/vpn.pemusername@123.123.1...](https://blog.csdn.net/weixin_43826596/article/details/90544275) 博文 [来自： weixin\_43826596的博客](https://blog.csdn.net/weixin_43826596)

脂肪克星，饭后坚持吃点它，轻松瘦到90斤 舜飞
![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/1.3.png]]

#### [_mac_ _osX_ 使用终端的ssh_命令_登陆远程_linux_](https://blog.csdn.net/zw3413/article/details/85061192)

[ssh-p22username@ip  其中-p22参数指定了登陆端口号username为你远程linux中的用户名ip为你远程linux的ip地址这条命令执行完毕后，会提示你输入密码，输入即可，测试...](https://blog.csdn.net/zw3413/article/details/85061192) 博文 [来自： zw3413的专栏](https://blog.csdn.net/zw3413)

#### [_Mac_ OS X: airport_命令_的参数](https://blog.csdn.net/afatgoat/article/details/6212214)

[Usage:airport      Ifaninterfaceisnotspecified,airportwillusethefirstAirPortinterfaceonthesystem.   ...](https://blog.csdn.net/afatgoat/article/details/6212214) 博文 [来自： 中国在线教育](https://blog.csdn.net/afatgoat)

#### [_Mac__命令行_登录\_srun3000网络认证](https://blog.csdn.net/scylhy/article/details/81429397)

[Mac命令行登录\_srun3000网络认证对于srun3000认证网络，linux有命令行工具，登录即可，无需再保持登录窗口。但是mac只有java版本的窗口登录工具，仍需保持窗口，为此尝试通过cur...](https://blog.csdn.net/scylhy/article/details/81429397) 博文 [来自： lemonTree的博客](https://blog.csdn.net/scylhy)

#### [_Mac_OS系统使用系列-3._Mac__命令行__命令_学习](https://blog.csdn.net/u010978815/article/details/78299472)

[1.文件查找find命令$findhttp://www.ruanyifeng.com/blog/2009/10/5\_ways\_to\_search\_for\_files\_using\_the\_termina...](https://blog.csdn.net/u010978815/article/details/78299472) 博文 [来自： 拾春华 让思绪飞扬](https://blog.csdn.net/u010978815)

#### [_Mac_基本_命令_大全](https://blog.csdn.net/sun375867463/article/details/10575051)

[基本命令1、列出文件ls参数目录名    例:看看驱动目录下有什么:ls/System/Library/Extensions参数-w显示中文，-l详细信息，-a包括隐藏文件2、转换目录    cd  ...](https://blog.csdn.net/sun375867463/article/details/10575051) 博文 [来自： sun Andy Blog](https://blog.csdn.net/sun375867463)

如果不想穷一辈子:读懂三不卖七不买是关键,可惜无人知晓 顶点财经 · 顶新
![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/1.3.png]]

#### [_mac_ os x _命令_+10个常用_命令行_工具](https://blog.csdn.net/passtome/article/details/8853624)

[mac os x 命令+10个常用命令行工具（转）转载▼很多朋友对osx下的命令行操作挠头，估计多数是在windows时代开始接触计算机的。有dos基础的应该是看看就明白，而玩过Linux的应该是轻车...](https://blog.csdn.net/passtome/article/details/8853624) 博文 [来自： passtome的专栏](https://blog.csdn.net/passtome)

#### [_Mac_ OS/_Linux__命令_查询网络端口占用情况](https://blog.csdn.net/tianxiawuzhei/article/details/48971005)

[netstat命令netstat-an|grep33063306替换成需要grep的端口号 lsof命令通过listopenfile命令可以查看到当前打开文件，在linux中所有事物都是以文件形式存在...](https://blog.csdn.net/tianxiawuzhei/article/details/48971005) 博文 [来自： 思考的智慧，知识源于思考](https://blog.csdn.net/tianxiawuzhei)

#### [_Linux_网络_命令_](https://blog.csdn.net/daoquan/article/details/489899)

[Linux的网络命令比较多，其中一些命令像ping、ftp、telnet、route、netstat等在其它操作系统上也能看到，但也有一些Unix/Linux系统独有的命令，如ifconfig、fin...](https://blog.csdn.net/daoquan/article/details/489899) 博文 [来自： 孤独是因为思念谁](https://blog.csdn.net/daoquan)

#### [_Mac_ _OSX_下的tree_命令_](https://blog.csdn.net/xidiancoder/article/details/72654583)

[mac下默认是没有tree命令-bash:tree:commandnotfound2.曲线救国-解决方案修改~/.bash\_profile配置文件aliastree="find.-print|sed-...](https://blog.csdn.net/xidiancoder/article/details/72654583) 博文 [来自： 安东的技术博客](https://blog.csdn.net/xidiancoder)

#### [_Mac_查看附近_WiFi_信道及路由器信道的选择](https://blog.csdn.net/hc1104/article/details/38732959)

[首先打开终端，输入sudoln-s/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/a...](https://blog.csdn.net/hc1104/article/details/38732959) 博文 [来自： 止境](https://blog.csdn.net/hc1104)

【今日盘前】反弹在即，老股民微信意外获得惊人行情 顶点财经 · 顶新
![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/1.3.png]]

#### [_Mac_ _OSX_下等价apt-get的_命令_——brew](https://blog.csdn.net/Yeoman92/article/details/56613597)

[之前接触过Ubuntu系统，其安装软件包的命令sudoapt-getinstallxxx，一直觉得Mac和Linux的系统类似，Ubuntu的区别应该不大，然而今天使用命令sudoapt-getins...](https://blog.csdn.net/Yeoman92/article/details/56613597) 博文 [来自： Yeoman92的博客](https://blog.csdn.net/Yeoman92)

#### [_OSX_ _Wifi_ 测试软件](https://download.csdn.net/download/u012000163/6222665)
#### [_linux_ _wifi_ _控制_](https://bbs.csdn.net/topics/390614693)
#### [_mac_ _osx_ juice使用说明](https://download.csdn.net/download/Valck/2263290)
#### [_Mac_ _osx_ iWall 新版](https://download.csdn.net/download/qvb3d/10770726)

[![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/unknown_filename.png]]](http://mssp.baidu.com/)

[[# | ![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/unknown_filename.1.png]]]]

![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/1.3.png]]

#### [_Mac_ OS X _命令行_用户应当知道的八个终端工具](https://blog.csdn.net/qq_19732563/article/details/48825199)

[原文链接：EightTerminalUtilitiesEveryOSXCommandLineUserShouldKnowOSX 的Terminal终端开辟了强大的UNIX实用工具和脚本的世界。如果你是...](https://blog.csdn.net/qq_19732563/article/details/48825199) 博文 [来自： qq\_19732563的博客](https://blog.csdn.net/qq_19732563)

#### [_MAC_ OS X 终端_命令_入门 （简单常用整理）](https://blog.csdn.net/itianyi/article/details/8603185)

[今天小研究了一下MAC的终端命令，主要为了方便调试程序用，XCODE用不来啊。。。在这里记下。。防止丢失pwd　　　　　　当前工作目录cd（不加参数）　　进rootcd（folder）　　进入文件夹c...](https://blog.csdn.net/itianyi/article/details/8603185) 博文 [来自： taylor的专栏](https://blog.csdn.net/itianyi)

#### [_Mac_ OS X Terminal 101：终端使用初级教程](https://blog.csdn.net/zltianhen/article/details/8015556)

[MacOSXTerminal101：终端使用初级教程发表于 2012年7月29日 由 RenfeiSong|文章目录1为什么要使用命令行/如何开启命令行？2初识CommandLine3关于man命令4...](https://blog.csdn.net/zltianhen/article/details/8015556) 博文 [来自： zltianhen的专栏](https://blog.csdn.net/zltianhen)

#### [_mac_上使用_wifi_连接Android手机](https://blog.csdn.net/yeputi1015/article/details/53014062)

[首先在安卓手机中的设置开发者选项中打开ADBovernetworkunmi$  adbconnect192.168.1.5:5555成功后显示：connectedto192.168.1.5:5555本...](https://blog.csdn.net/yeputi1015/article/details/53014062) 博文 [来自： yeputi\_WK的博客](https://blog.csdn.net/yeputi1015)

#### [如何在_Mac_OS系统里的_命令行_下启动和停止mysql服务](https://blog.csdn.net/kannte/article/details/78469822)

[在macOSSierra操作系统版本中，启动／停止MySQL5.7的命令：启动-sudolaunchctlload-F/Library/LaunchDaemons/com.oracle.oss.mys...](https://blog.csdn.net/kannte/article/details/78469822) 博文 [来自： kannte的博客](https://blog.csdn.net/kannte)

陈小春哭诉：望京土豪怒砸2亿请他代言这款0充值传奇！真经典！ 贪玩游戏 · 顶新
![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/1.3.png]]

#### [_Mac_ _OSX_ 文件系统（转载）](https://blog.csdn.net/linwwwei/article/details/83940667)

[OSX系统深入了解－－系统文件结构篇OSX采用的是类UNIX的多用户系统。通常我们在启动盘下面都只能看到应用程序、资源库、系统、用户这４个目录。但其实还有很多的隐藏目录，如bin、sbin之类的，这些...](https://blog.csdn.net/linwwwei/article/details/83940667) 博文 [来自： linwwwei](https://blog.csdn.net/linwwwei)

[c# linq原理](https://www.csdn.net/gather_1b/NtjaMgxsLWRvd25sb2Fk.html) [c# 装箱有什么用](https://www.csdn.net/gather_1a/NtjaMgysLWRvd25sb2Fk.html) [c#集合 复制](https://www.csdn.net/gather_12/NtjaMgzsLWRvd25sb2Fk.html) [c# 一个字符串分组](https://www.csdn.net/gather_16/NtjaMg0sLWRvd25sb2Fk.html) [c++和c#哪个就业率高](https://www.csdn.net/gather_26/NtjaMg1sLWJsb2cO0O0O.html) [c# 批量动态创建控件](https://www.csdn.net/gather_1c/NtjaMg2sLWRvd25sb2Fk.html) [c# 模块和程序集的区别](https://www.csdn.net/gather_1a/NtjaMg3sLWRvd25sb2Fk.html) [c# gmap 截图](https://www.csdn.net/gather_14/NtjaMg4sLWRvd25sb2Fk.html) [c# 验证码图片生成类](https://www.csdn.net/gather_14/NtjaQgwsLWRvd25sb2Fk.html) [c# 再次尝试 连接失败](https://www.csdn.net/gather_16/NtjaQgxsLWRvd25sb2Fk.html)

 [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/3_cn_wk.jpg]] ![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/8.png]]](https://blog.csdn.net/cn_wk) 

[王珂的个人笔记](https://blog.csdn.net/cn_wk)

[TA的个人主页 >](https://me.csdn.net/cn_wk)

[私信](https://www.csdn.net/apps/download/?code=app_1564993662&callback=csdnapp%3A%2F%2Fweb%3Furl%3Dhttps%3A%2F%2Fapp.csdn.net%2Fother%3Fusername%3Dcn_wk)

[原创](https://blog.csdn.net/cn_wk?t=1)
[45](https://blog.csdn.net/cn_wk?t=1)

粉丝
71

喜欢
103

评论
16

等级：
 [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/embedded.2.svg]]](https://blog.csdn.net/home/help.html#level) 

访问：
58万+

积分：
5747

排名：
8431

勋章：

![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/zhuanlan.png]]

![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/chizhiyiheng.png]]

![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/1.3.png]]

### 最新文章

*   [【设计模式】外观模式&代理模式&中介者模式的区别](https://blog.csdn.net/cn_wk/article/details/88656965)
*   [【设计模式】代理模式(Proxy)的应用场景](https://blog.csdn.net/cn_wk/article/details/88532355)
*   [【shell】通过alias实现回调](https://blog.csdn.net/cn_wk/article/details/88240199)
*   [【C】——C利用回调函数实现多态](https://blog.csdn.net/cn_wk/article/details/87089158)
*   [父 shell，子 shell ，export 与 变量传递](https://blog.csdn.net/cn_wk/article/details/83790879)

### 分类专栏

*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/1.1.jpeg]] Python专栏 65篇](https://blog.csdn.net/cn_wk/article/category/9268338) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] python 91篇](https://blog.csdn.net/cn_wk/article/category/6126687) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] git 2篇](https://blog.csdn.net/cn_wk/article/category/5929191) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] linux 32篇](https://blog.csdn.net/cn_wk/article/category/5931771) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] mysql 7篇](https://blog.csdn.net/cn_wk/article/category/5885363) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] vim 4篇](https://blog.csdn.net/cn_wk/article/category/6151574) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] sql 5篇](https://blog.csdn.net/cn_wk/article/category/1364729) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] 并发编程 1篇](https://blog.csdn.net/cn_wk/article/category/5895221) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] TCP 1篇](https://blog.csdn.net/cn_wk/article/category/6052232) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] 正则表达式 2篇](https://blog.csdn.net/cn_wk/article/category/6126689) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] 调试 1篇](https://blog.csdn.net/cn_wk/article/category/6134194) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] 爬墙](https://blog.csdn.net/cn_wk/article/category/6160208) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] django 10篇](https://blog.csdn.net/cn_wk/article/category/6190564) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] 系统运维 2篇](https://blog.csdn.net/cn_wk/article/category/6209629) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] 数据结构 4篇](https://blog.csdn.net/cn_wk/article/category/6212616) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] 算法 1篇](https://blog.csdn.net/cn_wk/article/category/6288009) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] scrapy 1篇](https://blog.csdn.net/cn_wk/article/category/6301671) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] js](https://blog.csdn.net/cn_wk/article/category/6331418) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] 机器学习 4篇](https://blog.csdn.net/cn_wk/article/category/6383511) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] 计算机网络 4篇](https://blog.csdn.net/cn_wk/article/category/6420858) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] 操作系统 3篇](https://blog.csdn.net/cn_wk/article/category/6420865) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] LeetCode 1篇](https://blog.csdn.net/cn_wk/article/category/6421093) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] mac 1篇](https://blog.csdn.net/cn_wk/article/category/6423536) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] 效率 1篇](https://blog.csdn.net/cn_wk/article/category/6423537) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] 待整理 1篇](https://blog.csdn.net/cn_wk/article/category/6445783) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] hive 1篇](https://blog.csdn.net/cn_wk/article/category/6524740) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] 机器学习-数理统计 1篇](https://blog.csdn.net/cn_wk/article/category/6542780) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] C++ 21篇](https://blog.csdn.net/cn_wk/article/category/6727608) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] DesignPattern 1篇](https://blog.csdn.net/cn_wk/article/category/7092093) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] 设计](https://blog.csdn.net/cn_wk/article/category/7092094) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] 设计模式 5篇](https://blog.csdn.net/cn_wk/article/category/7092095) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] python，设计模式 1篇](https://blog.csdn.net/cn_wk/article/category/7092096) 
*    [![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/column_head.png]] shell 18篇](https://blog.csdn.net/cn_wk/article/category/7109159) 

### 归档

*   [2019年3月 3篇](https://blog.csdn.net/cn_wk/article/month/2019/03)
*   [2019年2月 1篇](https://blog.csdn.net/cn_wk/article/month/2019/02)
*   [2018年11月 1篇](https://blog.csdn.net/cn_wk/article/month/2018/11)
*   [2018年8月 3篇](https://blog.csdn.net/cn_wk/article/month/2018/08)
*   [2018年7月 4篇](https://blog.csdn.net/cn_wk/article/month/2018/07)
*   [2018年5月 11篇](https://blog.csdn.net/cn_wk/article/month/2018/05)
*   [2018年4月 3篇](https://blog.csdn.net/cn_wk/article/month/2018/04)
*   [2018年2月 1篇](https://blog.csdn.net/cn_wk/article/month/2018/02)
*   [2017年11月 4篇](https://blog.csdn.net/cn_wk/article/month/2017/11)
*   [2017年10月 9篇](https://blog.csdn.net/cn_wk/article/month/2017/10)
*   [2017年9月 5篇](https://blog.csdn.net/cn_wk/article/month/2017/09)
*   [2017年8月 24篇](https://blog.csdn.net/cn_wk/article/month/2017/08)
*   [2017年3月 16篇](https://blog.csdn.net/cn_wk/article/month/2017/03)
*   [2017年2月 10篇](https://blog.csdn.net/cn_wk/article/month/2017/02)
*   [2017年1月 1篇](https://blog.csdn.net/cn_wk/article/month/2017/01)
*   [2016年11月 5篇](https://blog.csdn.net/cn_wk/article/month/2016/11)
*   [2016年10月 8篇](https://blog.csdn.net/cn_wk/article/month/2016/10)
*   [2016年9月 7篇](https://blog.csdn.net/cn_wk/article/month/2016/09)
*   [2016年8月 6篇](https://blog.csdn.net/cn_wk/article/month/2016/08)
*   [2016年7月 4篇](https://blog.csdn.net/cn_wk/article/month/2016/07)
*   [2016年6月 11篇](https://blog.csdn.net/cn_wk/article/month/2016/06)
*   [2016年5月 22篇](https://blog.csdn.net/cn_wk/article/month/2016/05)
*   [2016年4月 28篇](https://blog.csdn.net/cn_wk/article/month/2016/04)
*   [2016年3月 33篇](https://blog.csdn.net/cn_wk/article/month/2016/03)
*   [2015年12月 10篇](https://blog.csdn.net/cn_wk/article/month/2015/12)
*   [2015年11月 16篇](https://blog.csdn.net/cn_wk/article/month/2015/11)
*   [2015年10月 19篇](https://blog.csdn.net/cn_wk/article/month/2015/10)
*   [2015年9月 9篇](https://blog.csdn.net/cn_wk/article/month/2015/09)
*   [2015年4月 1篇](https://blog.csdn.net/cn_wk/article/month/2015/04)
*   [2013年11月 1篇](https://blog.csdn.net/cn_wk/article/month/2013/11)
*   [2013年8月 1篇](https://blog.csdn.net/cn_wk/article/month/2013/08)
*   [2013年6月 1篇](https://blog.csdn.net/cn_wk/article/month/2013/06)
*   [2013年3月 3篇](https://blog.csdn.net/cn_wk/article/month/2013/03)

### 热门文章

*   [python遍历字典dict的几种方法](https://blog.csdn.net/cn_wk/article/details/50996099)
    
    阅读数 53366
    
*   [【Python 脚本报错】AttributeError:'module' has no attribute 'xxx'的解决方法](https://blog.csdn.net/cn_wk/article/details/50839159)
    
    阅读数 37577
    
*   [【CentOS】make cc Command not found，make: \*\*\* adlist.o Error 127”](https://blog.csdn.net/cn_wk/article/details/50244673)
    
    阅读数 20610
    
*   [python运算符 >> << 右移 左移](https://blog.csdn.net/cn_wk/article/details/52804690)
    
    阅读数 18751
    
*   [什么是Feed流](https://blog.csdn.net/cn_wk/article/details/62435230)
    
    阅读数 16843
    

### 最新评论

*   [机器学习信息熵、信息增益的概念](https://blog.csdn.net/cn_wk/article/details/53340585#comments)
    
    ... [Royala：](https://my.csdn.net/Royala)信息增益可以为负吗
    
*   [Python在python中获...](https://blog.csdn.net/cn_wk/article/details/76933956#comments)
    
    ... [qq\_36016692：](https://my.csdn.net/qq_36016692)赞，很有用
    
*   [数据结构哨兵作用](https://blog.csdn.net/cn_wk/article/details/52541367#comments)
    
    ... [weixin\_40709648：](https://my.csdn.net/weixin_40709648)。。。最后还得把a\[0\]还原回去的
    
*   [macMac多显示器之间的焦点...](https://blog.csdn.net/cn_wk/article/details/82026583#comments)
    
    ... [weixin\_42359693：](https://my.csdn.net/weixin_42359693)还以为 Mac本来就可以设置，结果需要第三方插件啊。 感谢指点
    
*   [提高你的Python: 解释yie...](https://blog.csdn.net/cn_wk/article/details/51316934#comments)
    
    ... [weixin\_37805635：](https://my.csdn.net/weixin_37805635)学习了
    

![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/1.3.png]]

[![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/edu-QR.png]]](https://edu.csdn.net/?utm_source=csdn_footer)

CSDN学院

![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/job-QR.png]]

CSDN企业招聘

![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/embedded.3.svg]][kefu@csdn.net](https://blog.csdn.net/cn_wk/article/details/51712118mailto:webmaster@csdn.net) _![[./_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/embedded.4.svg]][QQ客服](http://wpa.b.qq.com/cgi/wpa.php?ln=1&key=XzgwMDE4MDEwNl80ODc3MzVfODAwMTgwMTA2XzJf)_

_![[./_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/embedded.5.svg]][客服论坛](http://bbs.csdn.net/forums/Service)_ ![[8知识管理/InBox/evernote/参考/_resources/[Linux]Mac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/embedded.6.svg]]400-660-0108

工作时间 8:30-22:00

[关于我们](https://www.csdn.net/company/index.html#about)[招聘](https://www.csdn.net/company/index.html#recruit)[广告服务](https://www.csdn.net/company/index.html#contact) [网站地图](https://www.csdn.net/gather/A)

[![[./_resources/LinuxMac_OSX_命令行下控制_Wifi命令_-_cn_wk的专栏_-_CSDN博客.resources/embedded.7.svg]]_百度提供站内搜索_](https://zn.baidu.com/cse/home/index) [京ICP备19004658号](http://www.miibeian.gov.cn/publish/query/indexFirst.action)

©1999-2019 北京创新乐知网络技术有限公司

[经营性网站备案信息](https://csdnimg.cn/cdn/content-toolbar/csdn-ICP.png) _[网络110报警服务](http://www.cyberpolice.cn/)_

[北京互联网违法和不良信息举报中心](http://www.bjjubao.org/)

[中国互联网举报中心](http://www.12377.cn/)[家长监护](https://download.csdn.net/index.php/tutelage/)[版权申诉](https://blog.csdn.net/blogdevteam/article/details/90369522)

    Created at: 2019-09-10T09:50:35+08:00
    Updated at: 2019-09-10T09:50:35+08:00


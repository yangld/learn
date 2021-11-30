
*   [首页](https://www.smzdm.com/)
*   [好价__](https://www.smzdm.com/jingxuan/)
*   [社区__](https://post.smzdm.com/)
*   [海淘__](https://haitao.smzdm.com/)
*   [百科__](https://wiki.smzdm.com/)
*   [[# | 更多__]]

*   [投资者关系](https://ir.smzdm.com/)
*   [商业合作](https://shangjia.smzdm.com/)
*   [[# | 爆料投稿__]]

[[# | 登录]][[# | 注册]]

当前位置：
[社区首页](https://post.smzdm.com/)
\>
[电脑数码](https://post.smzdm.com/fenlei/diannaoshuma/)
\>
[软件应用](https://post.smzdm.com/fenlei/ruanjianyingyong/)
\>
[Apple/苹果软件应用](https://post.smzdm.com/fenlei/ruanjianyingyong/brand-1687/)
\>
文章详情

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e4923e75903c198.jpg]]

# 折腾下战三年，11款Macbook Pro安装Catalina步骤指南

2020-02-16 21:31:22 17点赞 85收藏 84评论

**创作立场声明：**这篇文章只是分享自己的折腾过程，给愿意折腾的值友一个指引，用到的工具和方法都不是我原创，我只是做过了一次，把自己的被坑的经历写出来分享

**追加修改(2020-03-28 01:34:41):**
鉴于最近有多位值友在升级过程中遇到不成功的问题，虽然我不知道问题在哪儿，但是估计最近的补丁应该能解决这些问题，所以我把最新1.3.4的补丁的网盘链接分享下，希望能帮助到大家，后续如果dosdude1大神的补丁有更新，我也会尽快更新的 1.3.4补丁链接 链接：

[pan.baidu](https://pan.baidu.com/s/1kUIRoH5A34mmu0UPeOIOFg)[.com](https://pan.baidu.com/s/1kUIRoH5A34mmu0UPeOIOFg) 提取码：a9de SHA1: 5d7d2033459ae4d1be6d32c27268ce34272c388f

     2013年在朋友那里收了一台2011年款的MacBook Pro13，I5+4G＋500G的配置在当年还是很不错的，虽然屏幕非retina，不过我一直用来编辑文档和看网页，也就无所谓。期间把内存换成了8G，硬盘也换成了512G的SSD，系统一直升级到10.13（High Sierra），[苹果](https://pinpai.smzdm.com/1687/)就不让继续升级（理由不表），新系统就与我无缘了。由于对性能没啥要求，目前而言机器的性能还很不错，虽然对新的MacBook Pro16的硬件很心水，但我还是很喜欢手里这款的键盘手感，需要性能的工作我都在[台式机](https://www.smzdm.com/fenlei/taishiji/)上完成，实在没有更换的理由，所以一直坚持到现在。直到前天看到值友下面的这篇文章，让我觉得又有可以折腾下，让我的老苹果焕发生机。

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e4647ff98fb38657.jpg]]](https://post.smzdm.com/p/a99vp20e)[硬核DIYer日志 篇十：怎么把“白苹果”黑了？ - 手把手保姆式教程，让老MacBook装上Catalina](https://post.smzdm.com/p/a99vp20e)蜗居的阿宅终于有了正当理由不出门，那么他们的生存秘诀是什么？全新上线的#宅家生活手册#征稿活动火热进行中，来分享你特殊时期的宅居规划吧>活动详情戳这里<时间：1月28日-2月29日嗨，大家好！我是Neo！说到苹果的MacBookPro，除了其经典的设计之外，最让果粉们喜欢的就是相对优雅简约的macO[沈少Neo](https://zhiyou.smzdm.com/member/4918744579/)| _赞_39 _评论_56 _收藏_293[查看详情](https://post.smzdm.com/p/a99vp20e)

       这位值友升级成功用的是09款的机器，他能安装成功，让我觉得我这款机器从性能、配置、以及[触摸板](https://www.smzdm.com/fenlei/chukongban/)键盘等，与现在主流能运行新系统的机器更加接近，应该更没问题，所以找齐了需要的工具和软件后，我就开干了。声明下，该文章就是在升级成功后的机器上写的，由于专注于折腾的过程，有些过程中的图片我并没有拍下来或者截图，文章中用到的部分图片可能来自于上文链接或者别的地方引用，我会注明，只是为了给想要折腾的值友更好的指引。

首先说下准备工作，1、最好能通过TimeMachine备份数据，非常重要的数据，建议通过U盘进行备份，避免追悔莫及。2、准备一个16GB或者以上的U盘，用来制作可引导的U盘，也是为了有备无患。3、下载补丁软件：macos catalina patcher，最新的是1.3.0版本，这是国外一个大神制作的补丁，这是能成功安装新系统的关键，这位大神的博客里的下载链接都是用的[谷歌](https://pinpai.smzdm.com/2047/)网盘，我试了很多次都下载失败（有稳定的同学当我没说），后来通过bing搜索到了国内一个网站上，才下载成功。大神的网站上有该版本补丁的SHA1值，在国内网站下载后，记得用工具对比下，免得出问题，国内部分网站恶意修改文件添加广告和病毒的尿性大家不得不防，因为我第一个下载到的文件，SHA1值就与官方的不同，我直接删除了，下不到的可以用我分享的[网盘链接](https://pan.baidu.com/s/1QSU1z3gmMDK0suLm52_Mrg)，提取码5ez0 。4、安装一个系统清理软件，比如腾讯柠檬（非必备，原因我后面说），下面开干。

第一步、关闭SIP（不用管什么是SIP，也可以去问度娘，这一步本来是要到安装途中才会遇到的，为了便于大家不返工，先搞定，这样可以免得来回折腾）。建议先关机，然后启动电脑后，反复按command+R键盘，进入recovery模式，打开终端，输入“csrutil disable”后回车，提示成功后即可，然后重启电脑进入系统，这一步我激动得忘了截图，所以就用网上下的图了，感谢Mac下载网站，如果侵权我删除，不知道能不能审过。如下图。

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e490b7e0d9f0203.jpg]]](https://post.smzdm.com/p/a992ln70/pic_2/)

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e490b7e33cb88930.jpg]]](https://post.smzdm.com/p/a992ln70/pic_3/)

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e490b7e8754c207.jpg]]](https://post.smzdm.com/p/a992ln70/pic_4/)

第二步，进入系统后，如果曾经或者现在安装了Adobe旗下的设计全家桶软件（flash player除外），运行腾讯柠檬的“应用卸载”功能彻底清除所有包含Adobe字眼的应用，这是由于Catalina发布后，Adobe的全家桶被发现和该系统有不兼容的地方，虽然后来Adobe发布补丁解决了这个问题，但是应该只有正版用户才能接受这个更新。用盗版的用户是没法更新的，即使之前已经卸载了，但是这个鬼软件会在系统里有残留，升级过程中系统会检测，即使有残留，都会提示要去下载升级补丁，点继续后就会去下载补丁，然后过几分钟就就报错失败，我在这里反复采坑几次，最后是彻底清除了才过去的，搞得我差点放弃，血泪的教训。截个图感谢下柠檬。

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e492411722206625.jpg]]](https://post.smzdm.com/p/a992ln70/pic_5/)

第三步，障碍基本都清除了，加载提前下好的macos catalina patcher并运行，点运行，如下图，界面英文，不过一路点continue就行，

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e4924102ae2b75.jpg]]](https://post.smzdm.com/p/a992ln70/pic_6/)

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e492410383489294.jpg]]](https://post.smzdm.com/p/a992ln70/pic_7/)

一直到要求加载系统镜像这一步。如果你有官方Catalina系统的镜像，那就点左边的加载，如果没有，就点右边的下载，系统镜像约8G大小，下载时间大约1-2个小时吧，看你的网速。相信大多数值友都没有这个镜像，乖乖点右边下载吧。

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e4924102e1633558.jpg]]](https://post.smzdm.com/p/a992ln70/pic_8/)

第四步，下载好镜像后，软件会自动加载，然后出现这个界面，从左到右依次是直接安装，制作启动U盘，制作启动光盘，第三个选项基本不用考虑了，就算你光驱能用，我估计家里有刻录盘的朋友也不多了。这时候可以直接点最左边的“install to this machine”选项安装就好，我个人为了保险起见，怕安装过程出问题，先选了中间的选项，制作了一个启动U盘。如果要制作启动U盘的，可以继续看完这一步，不需要的就直接跳到第五步吧。

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e49240fbc05f757.jpg]]](https://post.smzdm.com/p/a992ln70/pic_9/)

插入之前准备的空白16GU盘，然后使用当前系统自带的磁盘工具进行格式化，点“抹掉"，名称填一个你好记忆的就行，方便一会选择，格式选”MacOS扩展（日志型）”，然后点“抹掉”按钮，完成格式化，大概十多秒就完成了。

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e49241151a305922.jpg]]](https://post.smzdm.com/p/a992ln70/pic_10/)

回到补丁软件的界面，点击“Create Bootable Installer”，弹出U盘的选择界面，选择刚才你格式化好的U盘，然后点Start按钮，系统会弹窗让你输入系统密码，输入后回车，接下来就是等待补丁软件给原版镜像打补丁然后写入到U盘的过程，因为老的MacBook不支持USB3.0，所以整个打补丁和写入的过程大概会需要20-30分钟左右。

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e492410b8371666.jpg]]](https://post.smzdm.com/p/a992ln70/pic_11/)

 制作U盘的过程

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e492410b69e89246.jpg]]](https://post.smzdm.com/p/a992ln70/pic_12/)

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e49241146c0b7879.jpg]]](https://post.smzdm.com/p/a992ln70/pic_13/)启动U盘制作完成

第五步，安装系统吧。如果是选择直接安装的朋友，点击“install to this machine”选项后，一路根据提示一直下一步就行。如果和我一样，要制作个启动U盘，等U盘制作完成后，出现了上图，拔下U盘放一边，不要点Quit，点击Back，然后在点一次Back，安装选项的界面，点击点击“install to this machine”选项，根据提示一步步操作，就能正常进行安装了

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e49240fbc05f757.jpg]]](https://post.smzdm.com/p/a992ln70/pic_14/)

如果不小心点了Quit，就要重新启动补丁软件了，来到选择官方操作系统镜像界面时，直接点左边的“Browse for a copy”，然后在在downloads目录下找到已经下载好的镜像，不要再去浪费时间重复下载了。

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e4924102e1633558.jpg]]](https://post.smzdm.com/p/a992ln70/pic_15/)

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e49240f3cb044371.jpg]]](https://post.smzdm.com/p/a992ln70/pic_16/)直接选择已经下载好的镜像

      完成以上步骤，剩下的基本就和通过官方渠道升级一样了，都是傻瓜式的一直下一步或者输入密码，后续升级过程大概还需要30分钟左右，如果还是在用[机械硬盘](https://www.smzdm.com/fenlei/jixieyingpan/)，估计会慢一点。dosdude1大神制作的这个补丁工具还是很傻瓜的，图形化界面和和苹果官方的简直一模一样，唯一缺点是对于国内用户而言，界面语言是英文。

     我是昨晚（2020年2月15日）完成的整个过程，第二天乘着记忆清晰，把过程中遇到的问题写出来，避免大家踩坑，晒一张我的成功截图吧。

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e492bbc3d31d8097.jpg]]](https://post.smzdm.com/p/a992ln70/pic_17/)

最后感谢dosdude1大神制作的程序，感谢值友[沈少Neo](https://zhiyou.smzdm.com/member/4918744579/)给我领了个路。

补充一点，这个方法升级后，不会对原系统中的数据产生影响，请大家放心。

未经授权，不得转载
![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/the-end.png]]

*   [__ 一枚果粉的修养](https://www.smzdm.com/tag/tz240lm/post/)
*   [__ 经验攻略](https://www.smzdm.com/tag/t8dmqmk/post/)
*   [__ Apple/苹果](https://pinpai.smzdm.com/1687/)
*   [__ 软件应用](https://post.smzdm.com/fenlei/ruanjianyingyong/)

[[# | __ 17]] [[# | __ 85]] [__ _84_](https://post.smzdm.com/p/a992ln70/#comments)

[[# | 分享]]
[[# | 举报]]

文章很值，打赏犒劳作者一下

[[# | 打赏]]

*   [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5-small.png]]](https://zhiyou.smzdm.com/member/8100045956/)
*   [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5cce51c09a5a4-small.jpg]]](https://zhiyou.smzdm.com/member/8754900588/)
*   [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/3-small.png]]](https://zhiyou.smzdm.com/member/7728181886/)
*   [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/56cc1c3c902b0-small.jpg]]](https://zhiyou.smzdm.com/member/8553000975/)

人已打赏

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/588afeafed294-big.jpg]]

## _梵尘-_ _LV55_

没有

4文章| 3爆料| 12粉丝](https://zhiyou.smzdm.com/member/7410758998/)[[# | __关注]]

*   [[# | 相关商品推荐]]

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5b1b9bcb51c4b.jpg]]

《扫描全能王付费版》iOS数字版软件

《扫描全能王付费版》iOS数字版软件

_1元起_
[看百科](https://wiki.smzdm.com/p/599mrwj/) [去购买](https://go.smzdm.com/ec3f3b0ec5c1c556/ca_aa_yc_163_70669331_11386_1687_1641_0)

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5b091ca3dba54.jpg]]

《拍照取字 专业版》iOS数字版软件

《拍照取字 专业版》iOS数字版软件

_1元起_
[看百科](https://wiki.smzdm.com/p/9ooymxx/) [去购买](https://go.smzdm.com/e29a32b75845466a/ca_aa_yc_163_70669331_11386_1687_1641_0)

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5b0255c80a14a.jpg]]

《Picsew》iOS数字版软件

《Picsew》iOS数字版软件

_1元起_
[看百科](https://wiki.smzdm.com/p/jxxreqv/) [去购买](https://go.smzdm.com/ced725d54568e44d/ca_aa_yc_163_70669331_11386_1687_1641_0)

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5b025d32ef7f9.jpg]]

《国家地理 每日精选》iOS数字版软件

《国家地理 每日精选》iOS数字版软件

_1元起_
[看百科](https://wiki.smzdm.com/p/1ww8em3/) [去购买](https://go.smzdm.com/f3373279e71475cd/ca_aa_yc_163_70669331_11386_1687_1641_0)

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5b025f072d751.jpg]]

《TouchRetouch》iOS数字版软件

《TouchRetouch》iOS数字版软件

_12元起_
[看百科](https://wiki.smzdm.com/p/433jpv0/) [去购买](https://go.smzdm.com/61eef8f096a837ef/ca_aa_yc_163_70669331_11386_1687_1641_0)

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/58b905475676b5093.jpg]]

《1Password》 ios密码管理软件

《1Password》 ios密码管理软件

_暂无报价_
[看百科](https://wiki.smzdm.com/p/xo7e84/) [去购买](https://go.smzdm.com/7a14a935eed3ae7f/ca_aa_yc_163_70669331_11386_1687_1641_0)

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/58b6b99b0327c5456.jpg]]

《Money Pro》 记账理财软件

《Money Pro》 记账理财软件

_6元起_
[看百科](https://wiki.smzdm.com/p/9d3vde/) [去购买](https://go.smzdm.com/99ced3aa4294ee55/ca_aa_yc_163_70669331_11386_1687_1641_0)

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5b83c2c54cc0c3579.jpg]]

《指纹相册》iOS数字版软件

《指纹相册》iOS数字版软件

_1元起_
[看百科](https://wiki.smzdm.com/p/3q8jv14/) [去购买](https://go.smzdm.com/ae352b97d3bc4ffb/ca_aa_yc_163_70669331_11386_1687_1641_0)

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5b1b6626bc2ba.jpg]]

《Agenda》Mac数字版软件

《Agenda》Mac数字版软件

_暂无报价_
[看百科](https://wiki.smzdm.com/p/pnn01ze/) [去购买](https://go.smzdm.com/c59b781e4f01a991/ca_aa_yc_163_70669331_11386_1687_1641_0)

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/59546363a320d8256.jpg]]

Day One（日记+笔记）

Day One（日记+笔记）

_暂无报价_
[看百科](https://wiki.smzdm.com/p/o1gmod8/) [去购买](https://go.smzdm.com/57942b747f3fdbd2/ca_aa_yc_163_70669331_11386_1687_1641_0)

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5b0259b9411d7.jpg]]

《航旅纵横PRO》iOS数字版应用

《航旅纵横PRO》iOS数字版应用

_1元起_
[看百科](https://wiki.smzdm.com/p/ryy14gq/) [去购买](https://go.smzdm.com/d0e7d86e4089423b/ca_aa_yc_163_70669331_11386_1687_1641_0)

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/595f3baa253e41175.jpg]]

《Cardiograph（心电图仪）》iOS应用软件

《Cardiograph（心电图仪）》iOS应用软件

_暂无报价_
[看百科](https://wiki.smzdm.com/p/z4ye1y3/) [去购买](https://appsto.re/cn/eFOaab.i)

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5b7a58bcc48db1519.jpg]]

《SYS Pro》iOS数字版软件

《SYS Pro》iOS数字版软件

_1元起_
[看百科](https://wiki.smzdm.com/p/xm1p7y4/) [去购买](https://go.smzdm.com/1038c2b790f90755/ca_aa_yc_163_70669331_11386_1687_1641_0)

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/58ad49adb7e785628.jpg]]

《Lossless Photo Squeeze（无损图片瘦身）》

《Lossless Photo Squeeze（无损图片瘦身）》

_暂无报价_
[看百科](https://wiki.smzdm.com/p/jweo9n/) [去购买](https://go.smzdm.com/e6722ec51aac60fd/ca_aa_yc_163_70669331_11386_1687_1641_0)

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5b8cdc5d81969682.jpg]]

《Flink》iOS数字版软件

《Flink》iOS数字版软件

_1元起_
[看百科](https://wiki.smzdm.com/p/6o05x0d/) [去购买](https://go.smzdm.com/ef56b4e67af48665/ca_aa_yc_163_70669331_11386_1687_1641_0)

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5b83c0d279b079981.jpg]]

《彩云天气Pro》iOS数字版软件

《彩云天气Pro》iOS数字版软件

_1元起_
[看百科](https://wiki.smzdm.com/p/59q15mo/) [去购买](https://go.smzdm.com/e0ad7d4b48a0691a/ca_aa_yc_163_70669331_11386_1687_1641_0)

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/-zoneid=65&campaignid=0&cb=1581f8c040.gif]]

_84_评论

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/default_small.png]]
				

发表评论请 [[# | 登录]]

__

*   最新
*   最热

*   [1](https://post.smzdm.com/p/a992ln70/#comments)
*   [2](https://post.smzdm.com/p/a992ln70/p2/#comments)
*   [3](https://post.smzdm.com/p/a992ln70/p3/#comments)
*   [_\>_](https://post.smzdm.com/p/a992ln70/p2/#comments)

*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/588afeafed294-small.jpg]]](https://zhiyou.smzdm.com/member/7410758998/) 
    84楼
    
    05-06 15:16
    [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e906414bd0597146.png]]]]
    [______________](https://zhiyou.smzdm.com/user/tequan/)
    
    > 1
    > 
    > [hcj1980](https://zhiyou.smzdm.com/member/3162023470/) ：
    > 
    > macOS Catalina Patcher 1.3.5出来了，Catalina也可以升级到10.15.04了
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 2
    > 
    > [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/) ：
    > 
    > 小版本更新一般都没啥太大的功能更新，官方推就更，不推就懒得折腾了。我才刚刚爬梯子把1.3.4弄下来。新的就来了，好心累
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    [[# | 展开隐藏楼层]]
    
    > 5
    > 
    > [阿路123](https://zhiyou.smzdm.com/member/8100045956/) ：
    > 
    > 那怎么联系你啊
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    估计发不了个人账号
    
    来自 [Android 客户端](https://www.smzdm.com/push/) [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5-small.png]]](https://zhiyou.smzdm.com/member/8100045956/) 
    83楼
    
    05-06 13:23
    [阿路123](https://zhiyou.smzdm.com/member/8100045956/)
    
    [__](https://zhiyou.smzdm.com/user/tequan/)
    
    > 1
    > 
    > [hcj1980](https://zhiyou.smzdm.com/member/3162023470/) ：
    > 
    > macOS Catalina Patcher 1.3.5出来了，Catalina也可以升级到10.15.04了
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 2
    > 
    > [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/) ：
    > 
    > 小版本更新一般都没啥太大的功能更新，官方推就更，不推就懒得折腾了。我才刚刚爬梯子把1.3.4弄下来。新的就来了，好心累
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    [[# | 展开隐藏楼层]]
    
    > 4
    > 
    > [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/) ：
    > 
    > 这里没法留联系方式吧
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    那怎么联系你啊
    
    来自 [iPhone 客户端](https://www.smzdm.com/push/) [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/1-small.png]]](https://zhiyou.smzdm.com/member/3162023470/) 
    82楼
    
    04-27 15:10
    [hcj1980](https://zhiyou.smzdm.com/member/3162023470/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e90647c3a7885314.png]]]]
    [______](https://zhiyou.smzdm.com/user/tequan/)
    
    > 1
    > 
    > [hcj1980](https://zhiyou.smzdm.com/member/3162023470/) ：
    > 
    > 发现一个问题，安装catalina之后，按住 Command ⌘ + R，进不了恢复模式。
    > 
    > [[# | 举报]] [[# | 顶(1)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 2
    > 
    > [lvhe](https://zhiyou.smzdm.com/member/3434147844/) ：
    > 
    > 同样问题 而且安装有些软件还是会提示要求关闭sip 可是sip明明在安装patcher之前就已经关了啊
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    安全模式也无法进入，sip问题到是没碰到过
    
    来自 [Android 客户端](https://www.smzdm.com/push/) [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/56cc25f0d8635-small.jpg]]](https://zhiyou.smzdm.com/member/3434147844/) 
    81楼
    
    04-27 11:37
    [lvhe](https://zhiyou.smzdm.com/member/3434147844/)
    
    [__](https://zhiyou.smzdm.com/user/tequan/)
    
    > 1
    > 
    > [hcj1980](https://zhiyou.smzdm.com/member/3162023470/) ：
    > 
    > 发现一个问题，安装catalina之后，按住 Command ⌘ + R，进不了恢复模式。
    > 
    > [[# | 举报]] [[# | 顶(1)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    同样问题 而且安装有些软件还是会提示要求关闭sip 可是sip明明在安装patcher之前就已经关了啊
    
    [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/588afeafed294-small.jpg]]](https://zhiyou.smzdm.com/member/7410758998/) 
    80楼
    
    04-23 02:20
    [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e906414bd0597146.png]]]]
    [______________](https://zhiyou.smzdm.com/user/tequan/)
    
    > 1
    > 
    > [hcj1980](https://zhiyou.smzdm.com/member/3162023470/) ：
    > 
    > macOS Catalina Patcher 1.3.5出来了，Catalina也可以升级到10.15.04了
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 2
    > 
    > [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/) ：
    > 
    > 小版本更新一般都没啥太大的功能更新，官方推就更，不推就懒得折腾了。我才刚刚爬梯子把1.3.4弄下来。新的就来了，好心累
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    [[# | 展开隐藏楼层]]
    
    > 5
    > 
    > [TZning](https://zhiyou.smzdm.com/member/5000886503/) ：
    > 
    > 我的a1286只能10.12.6所有功能正常，往后的版本我全升级了就是不行，不折腾了。
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    哈哈，可怜的人儿
    
    来自 [Android 客户端](https://www.smzdm.com/push/) [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/58b818bdef10b-small.jpg]]](https://zhiyou.smzdm.com/member/5000886503/) 
    79楼
    
    04-22 21:09
    [TZning](https://zhiyou.smzdm.com/member/5000886503/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e906507d549e597.png]]]]
    [________](https://zhiyou.smzdm.com/user/tequan/)
    
    > 1
    > 
    > [hcj1980](https://zhiyou.smzdm.com/member/3162023470/) ：
    > 
    > macOS Catalina Patcher 1.3.5出来了，Catalina也可以升级到10.15.04了
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 2
    > 
    > [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/) ：
    > 
    > 小版本更新一般都没啥太大的功能更新，官方推就更，不推就懒得折腾了。我才刚刚爬梯子把1.3.4弄下来。新的就来了，好心累
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    [[# | 展开隐藏楼层]]
    
    > 4
    > 
    > [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/) ：
    > 
    > 没有额，我升级后一切正常，所有功能都能用，不行就装个旧版本重新升级试试
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    我的a1286只能10.12.6所有功能正常，往后的版本我全升级了就是不行，不折腾了。
    
    [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/1-small.png]]](https://zhiyou.smzdm.com/member/2701795250/) 
    78楼
    
    04-14 00:31
    [Terry0086](https://zhiyou.smzdm.com/member/2701795250/)
    
    [____](https://zhiyou.smzdm.com/user/tequan/)
    
    > 1
    > 
    > [值友3977390860](https://zhiyou.smzdm.com/member/5692735915/) ：
    > 
    > @梵尘- 我很和你是同款，为什么每次都是显示磁盘空间不足呢？
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 2
    > 
    > [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/) ：
    > 
    > 在那一步提示，更换过硬盘么？或者看看磁盘的剩余空间多大
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 3
    > 
    > [值友3977390860](https://zhiyou.smzdm.com/member/5692735915/) ：
    > 
    > 更换了256g硬盘，刚做完系统，里面什么都没安装。
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    可能是你EFI分区只有100M，想办法扩大到200MB，固态盘应该很好改。
    
    [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/588afeafed294-small.jpg]]](https://zhiyou.smzdm.com/member/7410758998/) 
    77楼
    
    04-13 16:28
    [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e906414bd0597146.png]]]]
    [______________](https://zhiyou.smzdm.com/user/tequan/)
    
    > 1
    > 
    > [hcj1980](https://zhiyou.smzdm.com/member/3162023470/) ：
    > 
    > macOS Catalina Patcher 1.3.5出来了，Catalina也可以升级到10.15.04了
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 2
    > 
    > [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/) ：
    > 
    > 小版本更新一般都没啥太大的功能更新，官方推就更，不推就懒得折腾了。我才刚刚爬梯子把1.3.4弄下来。新的就来了，好心累
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 3
    > 
    > [TZning](https://zhiyou.smzdm.com/member/5000886503/) ：
    > 
    > 2011款a1268升级Catalina快捷键不能调节亮度，而且会睡死需要硬关机再开，不知你的有没这两种问题？
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    没有额，我升级后一切正常，所有功能都能用，不行就装个旧版本重新升级试试
    
    来自 [Android 客户端](https://www.smzdm.com/push/) [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/58b818bdef10b-small.jpg]]](https://zhiyou.smzdm.com/member/5000886503/) 
    76楼
    
    04-13 15:16
    [TZning](https://zhiyou.smzdm.com/member/5000886503/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e906507d549e597.png]]]]
    [________](https://zhiyou.smzdm.com/user/tequan/)
    
    > 1
    > 
    > [hcj1980](https://zhiyou.smzdm.com/member/3162023470/) ：
    > 
    > macOS Catalina Patcher 1.3.5出来了，Catalina也可以升级到10.15.04了
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 2
    > 
    > [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/) ：
    > 
    > 小版本更新一般都没啥太大的功能更新，官方推就更，不推就懒得折腾了。我才刚刚爬梯子把1.3.4弄下来。新的就来了，好心累
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    2011款a1268升级Catalina快捷键不能调节亮度，而且会睡死需要硬关机再开，不知你的有没这两种问题？
    
    [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/588afeafed294-small.jpg]]](https://zhiyou.smzdm.com/member/7410758998/) 
    75楼
    
    04-09 12:47
    [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e906414bd0597146.png]]]]
    [______________](https://zhiyou.smzdm.com/user/tequan/)
    
    > 1
    > 
    > [hcj1980](https://zhiyou.smzdm.com/member/3162023470/) ：
    > 
    > macOS Catalina Patcher 1.3.5出来了，Catalina也可以升级到10.15.04了
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 2
    > 
    > [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/) ：
    > 
    > 小版本更新一般都没啥太大的功能更新，官方推就更，不推就懒得折腾了。我才刚刚爬梯子把1.3.4弄下来。新的就来了，好心累
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 3
    > 
    > [阿路123](https://zhiyou.smzdm.com/member/8100045956/) ：
    > 
    > 你好，我指导一下我吗？我的笔记本跟你一样的，想升级。能互通留个联系方式吗？
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    这里没法留联系方式吧
    
    来自 [Android 客户端](https://www.smzdm.com/push/) [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5-small.png]]](https://zhiyou.smzdm.com/member/8100045956/) 
    74楼
    
    04-08 15:03
    [阿路123](https://zhiyou.smzdm.com/member/8100045956/)
    
    [__](https://zhiyou.smzdm.com/user/tequan/)
    
    > 1
    > 
    > [hcj1980](https://zhiyou.smzdm.com/member/3162023470/) ：
    > 
    > macOS Catalina Patcher 1.3.5出来了，Catalina也可以升级到10.15.04了
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 2
    > 
    > [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/) ：
    > 
    > 小版本更新一般都没啥太大的功能更新，官方推就更，不推就懒得折腾了。我才刚刚爬梯子把1.3.4弄下来。新的就来了，好心累
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    你好，我指导一下我吗？我的笔记本跟你一样的，想升级。能互通留个联系方式吗？
    
    [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/588afeafed294-small.jpg]]](https://zhiyou.smzdm.com/member/7410758998/) 
    73楼
    
    04-03 12:10
    [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e906414bd0597146.png]]]]
    [______________](https://zhiyou.smzdm.com/user/tequan/)
    
    > 1
    > 
    > [你别乱来啊](https://zhiyou.smzdm.com/member/3420571170/) ：
    > 
    > 我的老Macbook是MC700,8GB+320GB机械，好几年没用了，昨天刚从Lion升级到EI Capitan，想问下楼主，这老机器升级到最新系统会不会很卡？我是懒得折腾，不想搞什么破解，我想知道MC700官方最高支持到哪个版本呀？
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    也就升级到10.13了吧
    
    来自 [Android 客户端](https://www.smzdm.com/push/) [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/56cc26fa5c982-small.jpg]]](https://zhiyou.smzdm.com/member/3420571170/) 
    72楼
    
    04-03 09:15
    [你别乱来啊](https://zhiyou.smzdm.com/member/3420571170/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e9064fa6768a547.png]]]]
    [______](https://zhiyou.smzdm.com/user/tequan/)
    
    我的老Macbook是MC700,8GB+320GB机械，好几年没用了，昨天刚从Lion升级到EI Capitan，想问下楼主，这老机器升级到最新系统会不会很卡？我是懒得折腾，不想搞什么破解，我想知道MC700官方最高支持到哪个版本呀？
    
    [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/1-small.png]]](https://zhiyou.smzdm.com/member/3162023470/) 
    71楼
    
    03-31 18:02
    [hcj1980](https://zhiyou.smzdm.com/member/3162023470/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e90647c3a7885314.png]]]]
    [______](https://zhiyou.smzdm.com/user/tequan/)
    
    > 1
    > 
    > [hcj1980](https://zhiyou.smzdm.com/member/3162023470/) ：
    > 
    > macOS Catalina Patcher 1.3.5出来了，Catalina也可以升级到10.15.04了
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 2
    > 
    > [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/) ：
    > 
    > 小版本更新一般都没啥太大的功能更新，官方推就更，不推就懒得折腾了。我才刚刚爬梯子把1.3.4弄下来。新的就来了，好心累
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    发现个问题，摄像头无法正常使用了。你的可以么？
    
    [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/588afeafed294-small.jpg]]](https://zhiyou.smzdm.com/member/7410758998/) 
    70楼
    
    03-30 15:59
    [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e906414bd0597146.png]]]]
    [______________](https://zhiyou.smzdm.com/user/tequan/)
    
    > 1
    > 
    > [hcj1980](https://zhiyou.smzdm.com/member/3162023470/) ：
    > 
    > macOS Catalina Patcher 1.3.5出来了，Catalina也可以升级到10.15.04了
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    小版本更新一般都没啥太大的功能更新，官方推就更，不推就懒得折腾了。我才刚刚爬梯子把1.3.4弄下来。新的就来了，好心累
    
    来自 [Android 客户端](https://www.smzdm.com/push/) [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/1-small.png]]](https://zhiyou.smzdm.com/member/3162023470/) 
    69楼
    
    03-30 14:05
    [hcj1980](https://zhiyou.smzdm.com/member/3162023470/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e90647c3a7885314.png]]]]
    [______](https://zhiyou.smzdm.com/user/tequan/)
    
    macOS Catalina Patcher 1.3.5出来了，Catalina也可以升级到10.15.04了
    
    [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/1-small.png]]](https://zhiyou.smzdm.com/member/3162023470/) 
    68楼
    
    03-30 08:43
    [hcj1980](https://zhiyou.smzdm.com/member/3162023470/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e90647c3a7885314.png]]]]
    [______](https://zhiyou.smzdm.com/user/tequan/)
    
    发现一个问题，安装catalina之后，按住 Command ⌘ + R，进不了恢复模式。
    
    [[# | 举报]] [[# | 顶(1)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/588afeafed294-small.jpg]]](https://zhiyou.smzdm.com/member/7410758998/) 
    67楼
    
    03-28 00:53
    [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e906414bd0597146.png]]]]
    [______________](https://zhiyou.smzdm.com/user/tequan/)
    
    > 1
    > 
    > [值友4404357777](https://zhiyou.smzdm.com/member/8925462904/) ：
    > 
    > 2011末自带的机械硬盘，按照这个方案升级Catalina成功后，买了一个西数500G固态硬盘替换了原装机械硬盘后，空盘默认安装了Mac OS Lion，然后升级到Mac OS Sierra,最后按照本文方案，每次到镜像下载完毕系统重启后，卡在了Command+R的那个界面，进不去Catania系统，是何原因呢？
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    稍后我会更新dosdude1大神最新的1.3.4版本的补丁，下载最新的试试
    
    来自 [Android 客户端](https://www.smzdm.com/push/) [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/1-small.png]]](https://zhiyou.smzdm.com/member/3162023470/) 
    66楼
    
    03-27 18:42
    [hcj1980](https://zhiyou.smzdm.com/member/3162023470/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e90647c3a7885314.png]]]]
    [______](https://zhiyou.smzdm.com/user/tequan/)
    
    > 1
    > 
    > [hcj1980](https://zhiyou.smzdm.com/member/3162023470/) ：
    > 
    > @梵尘- 楼主，为何安装了你分享的补丁之后，在安装catalina时，第一次重启之后，就卡在读进度条了？是何原因
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 2
    > 
    > [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/) ：
    > 
    > 这个建议百度下，问题我没遇到过所以不知道怎么解决，不知道你是否和我是同款机器
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    A1278，和你一样么？后来，不断的重试了几次，突然就成功了。patch，我是从dosdude上下载的1.3.4。
    
    [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/1-small.png]]](https://zhiyou.smzdm.com/member/8925462904/) 
    65楼
    
    03-27 18:31
    [值友4404357777](https://zhiyou.smzdm.com/member/8925462904/)
    
    2011末自带的机械硬盘，按照这个方案升级Catalina成功后，买了一个西数500G固态硬盘替换了原装机械硬盘后，空盘默认安装了Mac OS Lion，然后升级到Mac OS Sierra,最后按照本文方案，每次到镜像下载完毕系统重启后，卡在了Command+R的那个界面，进不去Catania系统，是何原因呢？
    
    [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/1-small.png]]](https://zhiyou.smzdm.com/member/3162023470/) 
    64楼
    
    03-27 17:00
    [hcj1980](https://zhiyou.smzdm.com/member/3162023470/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e90647c3a7885314.png]]]]
    [______](https://zhiyou.smzdm.com/user/tequan/)
    
    搞定了。多试几次就可以了。挺奇怪的。
    
    [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/588afeafed294-small.jpg]]](https://zhiyou.smzdm.com/member/7410758998/) 
    63楼
    
    03-27 15:02
    [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e906414bd0597146.png]]]]
    [______________](https://zhiyou.smzdm.com/user/tequan/)
    
    > 1
    > 
    > [hcj1980](https://zhiyou.smzdm.com/member/3162023470/) ：
    > 
    > @梵尘- 楼主，为何安装了你分享的补丁之后，在安装catalina时，第一次重启之后，就卡在读进度条了？是何原因
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    这个建议百度下，问题我没遇到过所以不知道怎么解决，不知道你是否和我是同款机器
    
    来自 [Android 客户端](https://www.smzdm.com/push/) [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/1-small.png]]](https://zhiyou.smzdm.com/member/3162023470/) 
    62楼
    
    03-27 12:52
    [hcj1980](https://zhiyou.smzdm.com/member/3162023470/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e90647c3a7885314.png]]]]
    [______](https://zhiyou.smzdm.com/user/tequan/)
    
    @梵尘- 楼主，为何安装了你分享的补丁之后，在安装catalina时，第一次重启之后，就卡在读进度条了？是何原因
    
    [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/1-small.png]]](https://zhiyou.smzdm.com/member/3162023470/) 
    61楼
    
    03-27 10:51
    [hcj1980](https://zhiyou.smzdm.com/member/3162023470/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e90647c3a7885314.png]]]]
    [______](https://zhiyou.smzdm.com/user/tequan/)
    
    楼主，为何安装了你分享的补丁之后，在安装catalina时，第一次重启之后，就卡在读进度条了？是何原因？
    
    [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/588afeafed294-small.jpg]]](https://zhiyou.smzdm.com/member/7410758998/) 
    60楼
    
    03-25 00:27
    [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e906414bd0597146.png]]]]
    [______________](https://zhiyou.smzdm.com/user/tequan/)
    
    > 1
    > 
    > [blueluk](https://zhiyou.smzdm.com/member/8461001589/) ：
    > 
    > 兄弟，bootcamp装了win10，装完这个后win还能用么？还是要重装win? 准备折腾11年的air
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 2
    > 
    > [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/) ：
    > 
    > 能用，没什么影响
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 3
    > 
    > [blueluk](https://zhiyou.smzdm.com/member/8461001589/) ：
    > 
    > 不需要重装就能用呀？谢啦，确定我今晚就动刀啦哈哈
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    整起来，躁动
    
    来自 [Android 客户端](https://www.smzdm.com/push/) [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/2-small.1.png]]](https://zhiyou.smzdm.com/member/8461001589/) 
    59楼
    
    03-24 13:26
    [blueluk](https://zhiyou.smzdm.com/member/8461001589/)
    
    > 1
    > 
    > [blueluk](https://zhiyou.smzdm.com/member/8461001589/) ：
    > 
    > 兄弟，bootcamp装了win10，装完这个后win还能用么？还是要重装win? 准备折腾11年的air
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 2
    > 
    > [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/) ：
    > 
    > 能用，没什么影响
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    不需要重装就能用呀？谢啦，确定我今晚就动刀啦哈哈
    
    来自 [Android 客户端](https://www.smzdm.com/push/) [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/588afeafed294-small.jpg]]](https://zhiyou.smzdm.com/member/7410758998/) 
    58楼
    
    03-24 11:40
    [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e906414bd0597146.png]]]]
    [______________](https://zhiyou.smzdm.com/user/tequan/)
    
    > 1
    > 
    > [blueluk](https://zhiyou.smzdm.com/member/8461001589/) ：
    > 
    > 兄弟，bootcamp装了win10，装完这个后win还能用么？还是要重装win? 准备折腾11年的air
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    能用，没什么影响
    
    来自 [Android 客户端](https://www.smzdm.com/push/) [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/2-small.1.png]]](https://zhiyou.smzdm.com/member/8461001589/) 
    57楼
    
    03-24 10:14
    [blueluk](https://zhiyou.smzdm.com/member/8461001589/)
    
    兄弟，bootcamp装了win10，装完这个后win还能用么？还是要重装win? 准备折腾11年的air
    
    来自 [Android 客户端](https://www.smzdm.com/push/) [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/588afeafed294-small.jpg]]](https://zhiyou.smzdm.com/member/7410758998/) 
    56楼
    
    03-23 21:38
    [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/)
    [[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e906414bd0597146.png]]]]
    [______________](https://zhiyou.smzdm.com/user/tequan/)
    
    > 1
    > 
    > [值友3977390860](https://zhiyou.smzdm.com/member/5692735915/) ：
    > 
    > @梵尘- 我很和你是同款，为什么每次都是显示磁盘空间不足呢？
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 2
    > 
    > [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/) ：
    > 
    > 在那一步提示，更换过硬盘么？或者看看磁盘的剩余空间多大
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 3
    > 
    > [值友3977390860](https://zhiyou.smzdm.com/member/5692735915/) ：
    > 
    > 更换了256g硬盘，刚做完系统，里面什么都没安装。
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    我也没太懂，我更换的是500G固态，用bootcamp装了Win7也还有340G，安装全程顺利
    
    来自 [Android 客户端](https://www.smzdm.com/push/) [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5-small.png]]](https://zhiyou.smzdm.com/member/5692735915/) 
    55楼
    
    03-23 21:01
    [值友3977390860](https://zhiyou.smzdm.com/member/5692735915/)
    
    > 1
    > 
    > [值友3977390860](https://zhiyou.smzdm.com/member/5692735915/) ：
    > 
    > @梵尘- 我很和你是同款，为什么每次都是显示磁盘空间不足呢？
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    > 2
    > 
    > [梵尘-（作者）](https://zhiyou.smzdm.com/member/7410758998/) ：
    > 
    > 在那一步提示，更换过硬盘么？或者看看磁盘的剩余空间多大
    > 
    > [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    
    更换了256g硬盘，刚做完系统，里面什么都没安装。
    
    来自 [iPhone 客户端](https://www.smzdm.com/push/) [[# | 举报]] [[# | 顶(0)]] [[# | 踩(0)]] [[# | @TA]] [[# | 回复]]
    

*   [1](https://post.smzdm.com/p/a992ln70/#comments)
*   [2](https://post.smzdm.com/p/a992ln70/p2/#comments)
*   [3](https://post.smzdm.com/p/a992ln70/p3/#comments)
*   [_\>_](https://post.smzdm.com/p/a992ln70/p2/#comments)
*   转至页
*   [[# | GO]]

#### 相关文章推荐

*   [[# | 最热]]
*   [[# | 最新]]

*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5dec56bb3aaf92044.jpg]]](https://post.smzdm.com/p/a5kl33mx/) 
    
    [18个免费文献下载网站，每一个都是学术党的春天，1秒解决你90%的论文写作难题！](https://post.smzdm.com/p/a5kl33mx/)
    
    作为一个出入科研深坑的民工，非常理解各位同学找论文时的艰苦，动不动就会遇到收费、传输速度、... [阅读全文](https://post.smzdm.com/p/a5kl33mx/)
    [[# | __ 1.4K]] [[# | __ 24.0K]] [__ _201_](https://post.smzdm.com/p/a5kl33mx/#comments)
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5dfad1733b3456495.jpg]]](https://post.smzdm.com/p/alpokeq0/) 
    
    [值无不言162期：实用至上——三十五款神级免费Windows软件推荐](https://post.smzdm.com/p/alpokeq0/)
    
    Hi，亲爱的值友们，《值无不言》栏目新的一期上线啦！无论你是想了解更多攻略还是学习更多知识... [阅读全文](https://post.smzdm.com/p/alpokeq0/)
    [[# | __ 1.9K]] [[# | __ 22.2K]] [__ _398_](https://post.smzdm.com/p/alpokeq0/#comments)
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e7c9868e6de41224.jpg]]](https://post.smzdm.com/p/av7z4zd9/) 
    
    [软件哪里去找？——安全而无广告的『神级下载网站』~~绝对不能错过](https://post.smzdm.com/p/av7z4zd9/)
    
    写在前面作为电脑达人或者效率达人，软件是必不可少之物，工欲善其事必先利其器。而随着太平洋、... [阅读全文](https://post.smzdm.com/p/av7z4zd9/)
    [[# | __ 2.1K]] [[# | __ 21.6K]] [__ _294_](https://post.smzdm.com/p/av7z4zd9/#comments)
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e3e63337dc887197.jpg]]](https://post.smzdm.com/p/az5024zn/) 
    
    [「真香警告」十五款神级浏览器插件，高效实用、不容错过](https://post.smzdm.com/p/az5024zn/)
    
    Hi~ o(￣▽￣)ブ———大家好！又见面了~~在前几期我单独分享了正式版Edge的下载安... [阅读全文](https://post.smzdm.com/p/az5024zn/)
    [[# | __ 1.5K]] [[# | __ 19.7K]] [__ _571_](https://post.smzdm.com/p/az5024zn/#comments)
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e2839fe6d3a95237.jpg]]](https://post.smzdm.com/p/a4wkoe7w/) 
    
    [『干货集结号』 篇二：多强大，才能称为神奇的网站，这些＜充满惊喜＞的网站，拿走不谢~~](https://post.smzdm.com/p/a4wkoe7w/)
    
    【写在前面】有些网站可谓是大隐隐于网，宝藏在人间！大家好，我是纵笔浮生，今天又是满满的干货... [阅读全文](https://post.smzdm.com/p/a4wkoe7w/)
    [[# | __ 1.5K]] [[# | __ 19.7K]] [__ _172_](https://post.smzdm.com/p/a4wkoe7w/#comments)
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5dd4d0123224e9973.jpg]]](https://post.smzdm.com/p/akm7o679/) 
    
    [十个让你放飞自我的良心网站推荐](https://post.smzdm.com/p/akm7o679/)
    
    1.iData（仿知网）iData知识检索—免费下载学术文献,免费论文下载。...iDat... [阅读全文](https://post.smzdm.com/p/akm7o679/)
    [[# | __ 1.4K]] [[# | __ 19.3K]] [__ _244_](https://post.smzdm.com/p/akm7o679/#comments)
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e1a8d3fe91275113.jpg]]](https://post.smzdm.com/p/a6l88erg/) 
    
    [一入B站深似海，从此游戏是路人，当初因为追番进B站，如今却因为学习沉沦其中，篇二](https://post.smzdm.com/p/a6l88erg/)
    
    前几天分享了几个我自己常常看的小破站学习UP主，没想到值友们的反响特别热烈，两天不到收藏逼... [阅读全文](https://post.smzdm.com/p/a6l88erg/)
    [[# | __ 1.4K]] [[# | __ 16.9K]] [__ _259_](https://post.smzdm.com/p/a6l88erg/#comments)
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e36b7fc06d666468.jpg]]](https://post.smzdm.com/p/a5kl493k/) 
    
    [这些年搜索引擎做的恶~~这些好用到爆的『聚合搜索引擎』推荐~请拿走](https://post.smzdm.com/p/a5kl493k/)
    
    【啰嗦两句】垄断就是作恶的原罪，自从Google退出我大中华区，从此搜索引擎界江山已定，再... [阅读全文](https://post.smzdm.com/p/a5kl493k/)
    [[# | __ 1.3K]] [[# | __ 15.5K]] [__ _148_](https://post.smzdm.com/p/a5kl493k/#comments)
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e06075ef30134078.jpg]]](https://post.smzdm.com/p/av7mrpop/) 
    
    [十个你收藏了却从未打开过的网站！](https://post.smzdm.com/p/av7mrpop/)
    
    谁人不是收藏癖你是否听过无数道理，却仍旧过不好这一生？快，社会越来越快，我们沉浸在无限的信... [阅读全文](https://post.smzdm.com/p/av7mrpop/)
    [[# | __ 1.2K]] [[# | __ 14.7K]] [__ _195_](https://post.smzdm.com/p/av7mrpop/#comments)
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e2a9163076c95839.jpg]]](https://post.smzdm.com/p/aqnl9vxx/) 
    
    [「真香警告」比谷歌浏览器更好用的新版 Edge，拓展转移篇](https://post.smzdm.com/p/aqnl9vxx/)
    
    Hi~ o(￣▽￣)ブ———大家好！自1月23号武汉封城，我想很多人已经意识到新流感的严重... [阅读全文](https://post.smzdm.com/p/aqnl9vxx/)
    [[# | __ 1.0K]] [[# | __ 12.8K]] [__ _636_](https://post.smzdm.com/p/aqnl9vxx/#comments)
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e075f05ac6e6867.jpg]]](https://post.smzdm.com/p/a78303ro/) 
    
    [值无不言170期：超实用的15个微信小程序+5个宝藏公众号分享](https://post.smzdm.com/p/a78303ro/)
    
    Hi，亲爱的值友们，《值无不言》栏目新的一期上线啦！无论你是想了解更多攻略还是学习更多知识... [阅读全文](https://post.smzdm.com/p/a78303ro/)
    [[# | __ 1.0K]] [[# | __ 12.8K]] [__ _183_](https://post.smzdm.com/p/a78303ro/#comments)
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e82aac3925db6911.jpg]]](https://post.smzdm.com/p/akmg0o04/) 
    
    [神器挖掘机 篇十四：实用至上！windows 10的必装软件，一定少不了这9款](https://post.smzdm.com/p/akmg0o04/)
    
    大家好，这里是秋叶PPT~上次分享的Office软件的操作技巧，反响很不错，没想到受到了好... [阅读全文](https://post.smzdm.com/p/akmg0o04/)
    [[# | __ 942]] [[# | __ 12.1K]] [__ _187_](https://post.smzdm.com/p/akmg0o04/#comments)
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e1c5b0a5109b4464.jpg]]](https://post.smzdm.com/p/ag827rdw/) 
    
    [#相见恨晚# 篇五：五十个涵盖工作、学习、生活、娱乐的『强大神奇』网站满足你的『不时之需』~建议收藏](https://post.smzdm.com/p/ag827rdw/)
    
    【啰嗦几句】：前面写过几期关于良心网站的推荐，可能看到好的网站攒够十个就分享给大家了，做得... [阅读全文](https://post.smzdm.com/p/ag827rdw/)
    [[# | __ 868]] [[# | __ 11.9K]] [__ _105_](https://post.smzdm.com/p/ag827rdw/#comments)
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e1b17ea9b62f3035.jpg]]](https://post.smzdm.com/p/amm5kwxk/) 
    
    [18个学习网站分享，拯救假期生活，每天进步一点点，来年工资翻番](https://post.smzdm.com/p/amm5kwxk/)
    
    写在前面小年已过，年关将至，相信很多小伙伴踏上了归家的旅程，也有不少小伙伴已经在家里床上睡... [阅读全文](https://post.smzdm.com/p/amm5kwxk/)
    [[# | __ 1.0K]] [[# | __ 11.5K]] [__ _273_](https://post.smzdm.com/p/amm5kwxk/#comments)
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5dde29d56a47c968.jpg]]](https://post.smzdm.com/p/a4wkqw37/) 
    
    [手把手教您用tMM刮削影片信息，让KODI、Jellyfin、PLEX、使用本地媒体电影墙！](https://post.smzdm.com/p/a4wkqw37/)
    
    大家好！俺又来了！上篇文章为大家简单演示了下KODI如何安装和配置及使用！本人只需要2分钟... [阅读全文](https://post.smzdm.com/p/a4wkqw37/)
    [[# | __ 1.3K]] [[# | __ 10.6K]] [__ _756_](https://post.smzdm.com/p/a4wkqw37/#comments)
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e6ede54563893603.jpg]]](https://post.smzdm.com/p/alpw24p8/) 
    
    [神器挖掘机 篇十：推荐10个值得一去的国外神器网站！登录无需任何手段，实用又有趣！](https://post.smzdm.com/p/alpw24p8/)
    
    写在前面不说废话，直接推荐10个无需任何手段，也能去的国外优秀网站。01：tunefind... [阅读全文](https://post.smzdm.com/p/alpw24p8/)
    [[# | __ 924]] [[# | __ 11.2K]] [__ _109_](https://post.smzdm.com/p/alpw24p8/#comments)
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5df63357a9af8781.jpg]]](https://post.smzdm.com/p/av7mllr4/) 
    
    [Tasker-安卓党的京东自动签到神器来了](https://post.smzdm.com/p/av7mllr4/)
    
    此文完全是借鉴了 我的“捷径”不一样 篇一：用捷径实现京东签到领豆一键完成的文章，通... [阅读全文](https://post.smzdm.com/p/av7mllr4/)
    [[# | __ 1.0K]] [[# | __ 10.2K]] [__ _450_](https://post.smzdm.com/p/av7mllr4/#comments)
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5de49c9e0d22b7591.jpg]]](https://post.smzdm.com/p/akm78lv8/) 
    
    [新装系统以后该做些什么，保姆级攻略教你安装软件思路及必备软件选择](https://post.smzdm.com/p/akm78lv8/)
    
    前言大家好，我是小刀双11刚刚结束紧跟着“黑五”和“双十二”，估计这一阵装电脑的值友不在少... [阅读全文](https://post.smzdm.com/p/akm78lv8/)
    [[# | __ 1.0K]] [[# | __ 10.1K]] [__ _358_](https://post.smzdm.com/p/akm78lv8/#comments)
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5df8363fe9b641736.jpg]]](https://post.smzdm.com/p/av7ml684/) 
    
    [装修、办公、设计、娱乐——年度神级实用网站大汇总](https://post.smzdm.com/p/av7ml684/)
    
    之前的一年中在大妈分享了两篇关于实用网站的文章，可能是因为我的推荐比较注重实用性，能切身的... [阅读全文](https://post.smzdm.com/p/av7ml684/)
    [[# | __ 735]] [[# | __ 10.5K]] [__ _111_](https://post.smzdm.com/p/av7ml684/#comments)
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e18516be809a3876.jpg]]](https://post.smzdm.com/p/aqnlll9v/) 
    
    [从系统安装到神级软件——盘点十年来Windows平台的装机必备应用](https://post.smzdm.com/p/aqnlll9v/)
    
    大家还能想起十年前用的电脑是什么配置吗？我倒是还记得一点，当时的台式机的CPU是AMD的速... [阅读全文](https://post.smzdm.com/p/aqnlll9v/)
    [[# | __ 977]] [[# | __ 9.9K]] [__ _372_](https://post.smzdm.com/p/aqnlll9v/#comments)
    

[更多精彩文章](https://post.smzdm.com/fenlei/ruanjianyingyong/)

*   [[# | 相关摘要]]

*   [软件应用使用](https://www.smzdm.com/zy/specialty/azzd7to/)

 [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/588afeafed294-big.jpg]]](https://zhiyou.smzdm.com/member/7410758998/) 

## [梵尘-](https://zhiyou.smzdm.com/member/7410758998/)
[[# | ![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5e906414bd0597146.png]]]]
_LV55_

没有

[_4__文章_](https://zhiyou.smzdm.com/member/7410758998/article/) [_3__爆料_](https://zhiyou.smzdm.com/member/7410758998/baoliao/) [_12__粉丝_](https://zhiyou.smzdm.com/member/7410758998/friendships/fans/)
__关注 打赏

作者其他文章
[查看更多](https://zhiyou.smzdm.com/member/7410758998/article/)

*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/56a5c695c613e.jpg]]](https://post.smzdm.com/p/418994/) 
    [真的是我自己开箱：小牛电动车极光特别版晒单](https://post.smzdm.com/p/418994/)
    [[# | __56]] [[# | __75]]
    
*   [晒一晒119元的 Ray·Ban 雷朋 光学镜架](https://post.smzdm.com/p/314708/)
*   [抛弃广电的机顶盒 — 数字一体机CAM卡安装记录](https://post.smzdm.com/p/282424/)

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/17018633238962151298.jpeg]]](https://www.googleadservices.com/pagead/aclk?sa=L&ai=CnU4cYErDXsrYHZK22gS20rLYAdCXz_Fc4anisdsLyq2E3aAaEAEgyrWndmDZAqABwtnxwALIAQKpAvAOq8xa6GE-qAMByAPJBKoE5QFP0FTyH_MgtVWRhEtjiNkbFzpBpoF0bdguEzwwDmlpLQk11HIQZCHoOG60daXbBOkGAhi4Bm_GjEXpFDnJx-C2QnMeTtFyxJQ4OGZBs59f9kmHKGYCPdGEJm-Y6SZbI1prDsgamOIXIRd0sv8fviN365bWdb-_7Dc2JA9tNzhW2JlHsGrZrP6CzQKJsKnNYSZg9ovDR_JenqYSWUBo6hgPmf_e0pTEwDOjINLgKP7CcjUoEYD97Trk-CB7cz3x3-YWl6NCse8wkwEz1AjNUlgnnMz6eBG_TgBXIJmDuyeol2V_OxBxwASUxon0_QKQBgGgBgKAB6amjr8BiAcBkAcCqAeOzhuoB9XJG6gHk9gbqAe6BqgH8NkbqAfy2RuoB6a-G6gH7NUbqAfz0RuoB-zVG6gHltgbqAfC2hvYBwHSCAYIABACGBqxCQpPrONLiWAvgAoBmAsByAsB2BMM&ae=1&num=1&cid=CAMSeQClSFh34Mg7UD0Ntqjl_uu3ncTdNJPFHJbSieX9iroBuubpXvfIr2NYcOtnWI80crcj7hFFSopLcV0kjZZEFsYvx1a7Zw_d7kxaKglpCfkTlzcVMK_99aUvlHF6tlPNczaiY4oX_eB4DLCY2lvpPUDTNFWEcauZiow&sig=AOD64_0YryP43pBM0enP02D9a01_E2dASg&client=ca-pub-8208359796926620&nb=17&adurl=http://p.3syuaandking.com/158mobile/101.html%3Fsubid%3Dpost.smzdm.com%26keyword%3D%26scid%3Drlwj_tw_man_f-p45695-300x250_GDN%26gclid%3DCjwKCAjw5Ij2BRBdEiwA0Frc9fJXHtA74hrinuZUJcjhsEhQ6DExAfvEB6nz3f96xgO2oLMlHrk-GhoC6BEQAvD_BwE)

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/embedded.svg]]

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/embedded.1.svg]]

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/-zoneid=65&campaignid=0&cb=1581f8c040.gif]]

相关话题

*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5ad8889fb63eb5921.jpg]]](https://post.smzdm.com/tag/tz240lm) 
    [一枚果粉的修养](https://www.smzdm.com/tag/tz240lm/post/)
    10595内容 34449人关注
    __关注
    

话题文章推荐

*   [2020 年《财富》美国 500 强排行榜发布，苹果跌出前三](https://post.smzdm.com/p/akmgl6d4/)
*   [这台红色版iPhone SE2用了一个月，我对它有了新的认识](https://post.smzdm.com/p/av7zp8qp/)
*   [差点儿被套路了？拼多多iPhone SE2安全下车的经过！](https://post.smzdm.com/p/a5kqxe8l/)
*   [苹果airpods pro耳机：降噪效果、音质评价](https://post.smzdm.com/p/ax02o72d/)
*   [iphone11用户喜提se2？ iPhonese2多多安全下车及3天](https://post.smzdm.com/p/awx0kn42/)

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/BAU_Debt_Con_20200428_Amnet_Debt_Con___1500_Coupon.jpg]]](https://adclick.g.doubleclick.net/pcs/click?xai=AKAOjst0olgY4xzTADm8c7Wshc5K6GGO2-5TquBtKGxH7cAcIBL0I_AMHxBG4wLGew_qI5RFV2N9u-miA8kpvMwez0YDhtcGxndfnFwHebFiJkvY1wk3rK03PmFFv6H72OgJmjlj6RBcGpkZoTxiUbx6IoXhvyhUpNgvowGHqKgbIU-c9ahswaGTc2bi0q7aVzlV4mHwHbNIuUgQ6hUTHma-_A4l1EHymMsRkQ3Jq8WZnw8T8ftxAsKMqjItu0ekUAWede1bqd1TlqPr0IW1YXkKJXElvlFFP15XefbfDkKqE16KmNazKUAflRRTcFafUMlG2ssm_u38n7Y7a0fuKox1gtFvKHp-5scgm8wGkphVQvX_iU3EVn00OSLt2nAcrXOnixbNaWMelMhXILv_Hi2_1pJA-zs2wbsXLcPa0EcTX1bXeiuzN-6Bs_dSau_kIdILOTGSB3Z2gQjAFTJBFgSxm_CqhNQiAeAtLwyg9JrYOIRoPZVZI3CWfxwkha1teUZZuHO_qHOI6GyqZiKKX85qh-uMeca-3VCuS3FEoWV9KkYi5EtusjEbRCT1XaDNOcF2L5SqIar0FxYzDwtvDmB_yxaMwDw5yKrejmGk539IORK1PX0ePDfCLmix0BdubAq-ab5uo11nale-AJcfFe4s55FRkx7xA8aPqj2SkA_icmyuus7HqkPnZSCB4K4ZV9Y4sJ9v7BP97oYaeK6_fjjzlzcH533Ndw4YQuV2n7D-tBFVkvrQRFP2CnV2BZlMNbkkcfoEEZbP4z7ebcJ4Mxf529QMUc3d_Z95mauTNkAKSKc93aM0zoabGsfwFH7CDtdYzI_2BmgNeNfNCr597YP5YoArWvX9cyZFksGfyiOn69i2_TmoZCfGloSevCYYjNZJmLD00wH_9gvXtxuddj93Jk-LiKkG6wlxgKWHHBfmzFjG-nngxAhCi3VejyCeNpy8a0HP4G1jXXrks8i0ukogC8JTyQFsbpUhGj79bMipM0vBapIxRtEJY0zHEx4DShgDCBfgKTZdt246Bs0L1BG9VSFr7b65CxsuxpXAT5D94wLmA-SmuCWkZVM&sai=AMfl-YST2ij3Dnu4DdI19oC_6BA0cTsFUJ4umtgIc6hzeIWEInDdRaXRwRVXsE7UAGg4TKR5VOKhqP7pQc9uDDwEhK4c0wKwmpq0APBMk3-wrqdNKxZMmiTORlug_giQY9WA-oUMGPkCo4XItEbByxoaxcMM9DAYv1c-qGX_jt7u731UcIqRnmmBFiye7Dso2wPBn-uem7G2UbC-UW6CxfazssszZkE5PondXN6Si9vm9ZusMR0sTX73yjsva0GrHt0ddSoNF9AlMBm7VEAKd1-TfDF3TPYNxYA_dNkdOWMxkv504eEU2PZSMiSJPuSmiA49-rWBIziBIQbDs6mo2eRqt-2lM-2BdShh12KvaPCIsAsBmw&sig=Cg0ArKJSzN0I6dqgBI5A&urlfix=1&adurl=https://ad.atdmt.com/c/img%3Badv%3D11062223066315%3Bec%3D11062232103276%3Badv.a%3D8114357%3Bc.a%3D20291336%3Bs.a%3D4152737%3Bp.a%3D272674739%3Ba.a%3D467329004%3Bcache%3D3634439749%3Bqpb%3D1%3B%3Fh%3Dhttps://www.citibank.com.hk/chinese/loans/card-debt-consolidation-loan.htm%3Fecid%3DPSAMNHKPLAZHAQ)

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/embedded.2.svg]]

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/embedded.3.svg]]

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/img;adv=11062223066315;ec=11062232103276;adv.a=467329004;cache=3634439749;]]![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/src=8121631;type=;cat=;u10=272674739;u11=20291336;.gif]]

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/-zoneid=65&campaignid=0&cb=1581f8c040.gif]]

相关好价

*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5d0b022f88fd04978.jpg]]](https://www.smzdm.com/p/21169914/) 
    [HUAWEI 华为 nova 5 Pro 智能手机 8GB+128GB](https://www.smzdm.com/p/21169914/)
    1789元包邮
    
*   [Apple 苹果 Pencil（一代） 手写笔](https://www.smzdm.com/p/21167420/)
*   [Redmi 红米 小爱触屏音箱 8英寸](https://www.smzdm.com/p/21163019/)
*   [KINGBANK 金百达 KM200系列 M.2 NVMe 固态硬盘 512GB](https://www.smzdm.com/p/21172428/)
*   [AMAZFIT 华米 Ares 智能手表](https://www.smzdm.com/p/21178257/)
*   [MI 小米 小米手环4 NFC版 智能手环](https://www.smzdm.com/p/21167056/)
*   [Greyes 京东自营 手机/平板 可折叠伸缩桌面支架](https://www.smzdm.com/p/21150699/)
*   [昕光瑞 懒人手机支架 通用](https://www.smzdm.com/p/21178069/)
*   [KIOXIA 铠侠 EXCERIA 极至瞬速 NVMe SSD固态硬盘 500GB](https://www.smzdm.com/p/21177777/)

热门众测
[查看更多](https://test.smzdm.com/)

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5eba58893e8c29842.jpg]]
【轻众测】罗曼（ROAMAN） 声波电动牙刷 成人情侣联名款洁面震动牙刷 T10熔岩红 立即申请](https://test.smzdm.com/p/10005/)[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5ec00048247ad7943.jpg]]
【轻众测】水密码·专研 双重胜肽紧致抗皱安瓶精华液（小紫弹） 立即申请](https://test.smzdm.com/p/10022/)[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5ec000d7a64838799.jpg]]
【轻众测】Goose Island鹅岛 + Boxing Cat 拳击猫精酿啤酒混合装355ml\*12 立即申请](https://test.smzdm.com/p/10015/)[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5ebe7cb0ec48a7865.jpg]]
宜洁 YE-07 智控净洗擦地机 立即申请](https://test.smzdm.com/p/10016/)[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5ebe70b8c537b7790.jpg]]
【轻众测】《西游记冒险手册1-3》 立即申请](https://test.smzdm.com/p/10025/)[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5ebe58fb125c88067.jpg]]
MeiLing/美菱 BCD-452WPU9CA 十字对开门家用一级变频M鲜生黛蓝灰冰箱 立即申请](https://test.smzdm.com/p/10010/)[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5ebe0ccbd0bfb8321.jpg]]
【轻众测】卡西欧stylish时尚计算器 7台 / 卡西欧xMONTAGUT国风限定礼盒 3套 立即申请](https://test.smzdm.com/p/10018/)[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5ebe06aa285792929.jpg]]
【轻众测】帮你喝得讲究、吃得地道：《饮食生活新提案系列》（套装共5册） 立即申请](https://test.smzdm.com/p/10001/)[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5eba16cb766ad7724.jpg]]
Nintendo Switch 国行续航增强版（附国行3款游戏卡+配件pro手柄或其他） 立即申请](https://test.smzdm.com/p/10004/)[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5ebe53024c42c7713.jpg]]
【值得Try·618横评周】得1000元京东E卡——Apple全家桶大赏横评 立即申请](https://test.smzdm.com/p/10019/)[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5ebcde67c478a4447.jpg]]
凯迪仕 tk2 天猫精灵联合定制 指纹锁 立即申请](https://test.smzdm.com/p/10009/)[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5ebcdac5a00b22351.jpg]]
影驰 HOF PRO M.2 SSD丨评论有奖 立即申请](https://test.smzdm.com/p/9998/)[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5ebcb0e756b77103.jpg]]
BenQ明基 GK100 家用4K短焦 投影机 立即申请](https://test.smzdm.com/p/10000/)[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5ebbb44c542719464.jpg]]
【轻众测】小米Wi-Fi 6路由器 AX1800 立即申请](https://test.smzdm.com/p/10008/)[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5eba58893e8c29842.jpg]]
【轻众测】罗曼（ROAMAN） 声波电动牙刷 成人情侣联名款洁面震动牙刷 T10熔岩红 立即申请](https://test.smzdm.com/p/10005/)[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5ec00048247ad7943.jpg]]
【轻众测】水密码·专研 双重胜肽紧致抗皱安瓶精华液（小紫弹） 立即申请](https://test.smzdm.com/p/10022/)

*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5eb441a008d1e2385.jpg]]](https://post.smzdm.com/p/aekenq5q/) 
    [扫地机高端市场竞争激烈，小狗R60凭什么卖高价？](https://post.smzdm.com/p/aekenq5q/)
    __ 22 __ 46
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5ea58dede844c205.jpg]]](https://post.smzdm.com/p/av7z7m6p/) 
    [办公室新人必备的开挂神器，考研的助推神器，开启开挂人生！](https://post.smzdm.com/p/av7z7m6p/)
    __ 17 __ 60
    
*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5ec2049b2dbc74717.jpg]]](https://post.smzdm.com/p/av7zwvk7/) 
    [Superdry 跩T你燥嘛？ 来试试就知道了](https://post.smzdm.com/p/av7zwvk7/)
    __ 16 __ 169
    

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/embedded.4.svg]]

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/embedded.5.svg]]

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/adc_cov_ThomasWimberly-StayHome_300x250_static.jpg]]](https://adclick.g.doubleclick.net/pcs/click?xai=AKAOjstLw0vJmD5BCVj_amuuAAbZHwVPdOOplXUaoHeW_LI3bgtFtUKoffYuPCToKMQZyjJGZqJOkvQuouPfj3_jXMvUwUIfceGONQMaGFgPGO6v8yHFONY2xMEy3OGwdmXUiOn2fGcs&sai=AMfl-YS4VQmkGVPOxNctwCYcyV-1PnEQI7Ix8B58APz_4TkHzzqfsib4Dgx00PmWVb8xSuS3m3biHxI8Cr6exeArQ0Zfqf4nIpmTjQk0tll9G97y&sig=Cg0ArKJSzOMNgSQzbWGe&urlfix=1&adurl=https://www.coronavirus.gov%3Futm_source%3Ddoubleverify.com%26utm_medium%3Ddisplay%26utm_campaign%3DAC_CRNA%26utm_content%3DBRND_GENA_TWSH_EN_300x250)

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/-zoneid=65&campaignid=0&cb=1581f8c040.gif]]

最新文章 热门文章

[查看更多](https://post.smzdm.com/)

*    [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5ec348983c1eb8599.jpg]]](https://post.smzdm.com/p/a9926m90/) 
    [40项运动数据、日常续航14天：华米新品 Amazfit Ares 上架预售](https://post.smzdm.com/p/a9926m90/)
    [[# | __0]] [[# | __0]]
    
*   [不用不知值不值 篇七十：JUMP!让她戴着它动起来](https://post.smzdm.com/p/a078xk3r/)
*   [存储外设 篇三：小白装机选1TB NVMe固态硬盘？是的，2020年了，这次奢侈一把！上机实测雷克沙NM610](https://post.smzdm.com/p/az5eolmo/)
*   [推荐几款自己购入的适合普通人进行长距离慢跑(LSD)锻炼的跑鞋](https://post.smzdm.com/p/ar0vr9ng/)
*   [“筋膜”枪，类文献科普+避坑指南！](https://post.smzdm.com/p/a78zp6mo/)

下一篇：

[0成本把你的小米路由器改造成BT&百度云下载机](https://post.smzdm.com/p/akm7vz59/) 
[认证作者](https://www.smzdm.com/renzheng?from=xqy) [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/xiewenzhang.png]]](https://news.smzdm.com/p/70092015/?fr=xqy) 

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/-zoneid=65&campaignid=0&cb=1581f8c040.gif]]

[关于我们](https://about.smzdm.com/)[联系我们](https://www.smzdm.com/contact-us)[招聘专区](https://www.smzdm.com/zhaopin/hot/)[网站地图](https://www.smzdm.com/sitemap.html)[机构账号](https://zhiyou.smzdm.com/shangjia/)[商业合作](https://shangjia.smzdm.com/)[用户协议](https://www.smzdm.com/user/register/provisions/)[隐私政策](https://zhiyou.smzdm.com/user/register/privacy/)

[[# | 热门分类]] [[# | 热词推荐]]

[口罩推荐](https://post.smzdm.com/fenlei/kouzhao/)[白酒](https://www.smzdm.com/fenlei/baijiu/)[游戏本什么牌子好](https://www.smzdm.com/fenlei/youxiben/post/)[空调什么牌子好](http://www.smzdm.com/fenlei/kongtiao/post/)[显卡什么牌子好](http://www.smzdm.com/fenlei/xianka/post/)[笔记本电脑什么牌子好](http://www.smzdm.com/fenlei/bijibendiannao/post/)[热水器哪个牌子好](https://www.smzdm.com/fenlei/reshuiqi/post/)[电视什么牌子好](http://www.smzdm.com/fenlei/dianshi/post/)[平板电脑什么牌子好](http://www.smzdm.com/fenlei/pingbandiannao/post/)[显示器报价](https://m.smzdm.com/fenlei/xianshiqi/p1/)[airpods](https://www.smzdm.com/tag/AirPods/post/)[手机什么牌子好](https://www.smzdm.com/fenlei/zhinengshouji/post/)[iPhone](https://www.smzdm.com/fenlei/iphone/)[拉杆箱什么牌子好](https://www.smzdm.com/fenlei/laganxiang/post/) [kindle](https://pinpai.smzdm.com/45733/)[香水](https://www.smzdm.com/fenlei/nvshixiangshui/)[口红什么牌子好](https://www.smzdm.com/fenlei/kouhong/post/)[保暖内衣报价](https://m.smzdm.com/fenlei/baonuanneiyi/p1/)[乐高](https://www.smzdm.com/fenlei/LEGO/)[iPad](https://www.smzdm.com/fenlei/ipad/)[精华液什么牌子好](https://www.smzdm.com/fenlei/jinghuaye/post/)[智能音箱](https://www.smzdm.com/fenlei/zhinengyinxiang/post/)[加湿器什么牌子好](https://www.smzdm.com/fenlei/jiashiqi/post/)[保温杯什么牌子好](https://www.smzdm.com/fenlei/baowenbaolengbei/post/)[618什么值得买](https://post.smzdm.com/sou/326/)[护手霜什么牌子好](https://www.smzdm.com/fenlei/hushoushuang/post/)[手机报价](https://m.smzdm.com/fenlei/zhinengshouji/p1/)[8英寸带屏音箱](https://post.smzdm.com/sou/1424/)[主机游戏](https://post.smzdm.com/fenlei/zhujiyouxi/)[口罩专区](https://m.smzdm.com/zhuanti/yq/yqzq/)

版权所有 本站内容未经书面许可,禁止一切形式的转载。 © copyright 2010-2020 什么值得买. All rights reserved.

[京ICP备12048526号-2](http://beian.miit.gov.cn/) [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/police.png]] 京公网安备 11010602100083](http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11010602100083) [电信与信息服务业务经营许可证：京ICP证160379号](https://www.smzdm.com/jingyingxuke/) [广播电视节目制作经营许可证（京）字第07726号](https://www.smzdm.com/shipinxuke/)

[互联网药品信息服务资格证书(京)-非经营性-2017-0107](https://www.smzdm.com/yaopinxuke/) | 违法和不良信息举报电话：4008108106-9 | 违法和不良信息举报邮箱：service@smzdm.com [营业执照](https://www.smzdm.com/yingyezhizhao)

公司名称：北京值得买科技股份有限公司 地址：北京市丰台区汽车博物馆东路1号院3号楼32层3701和33层3801 座机：010-56640700

[![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/honesty_website.png]]](https://credit.szfw.org/CX20171229037315080126.html) [![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/5ebd2d92741315053.png]]](https://www.12377.cn/)

![[./_resources/折腾下战三年，11款Macbook_Pro安装Catalina步骤指南_值客原创_什么值得买.resources/qrcode.png]]

*   __smzdm\_smzdm
*   [__关注什么值得买](http://v.t.sina.com.cn/share/share.php?url=https%3A%2F%2Fpost.smzdm.com%2Fp%2Fa992ln70%2F&title=%E6%8A%98%E8%85%BE%E4%B8%8B%E6%88%98%E4%B8%89%E5%B9%B4%EF%BC%8C11%E6%AC%BEMacbook%20Pro%E5%AE%89%E8%A3%85Catalina%E6%AD%A5%E9%AA%A4%E6%8C%87%E5%8D%97_%E5%80%BC%E5%AE%A2%E5%8E%9F%E5%88%9B_%E4%BB%80%E4%B9%88%E5%80%BC%E5%BE%97%E4%B9%B0)
*   [__Rss 订阅中心](https://www.smzdm.com/dingyue)

    Created at: 2020-05-19T10:56:16+08:00
    Updated at: 2020-05-19T10:56:16+08:00


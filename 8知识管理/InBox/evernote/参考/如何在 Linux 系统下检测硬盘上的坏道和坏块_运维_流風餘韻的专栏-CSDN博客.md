
![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/embedded.svg]]![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/embedded.1.svg]]![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/embedded.2.svg]]

# 如何在 Linux 系统下检测硬盘上的坏道和坏块

原创 [流風餘韻](https://me.csdn.net/u014743697) 最后发布于2016-11-24 08:55:20 阅读数 35316  

# 

|     |     |
| --- | --- |
| 导读  | 让我们从坏道和坏块的定义开始说起，它们是一块磁盘或闪存上不再能够被读写的部分，一般是由于磁盘表面特定的物理损坏或闪存晶体管失效导致的。随着坏道的继续积累，它们会对你的磁盘或闪存容量产生令人不快或破坏性的影响，甚至可能会导致硬件失效。同时还需要注意的是坏块的存在警示你应该开始考虑买块新磁盘了，或者简单地将坏块标记为不可用。 |

在这篇文章中，我们通过几个必要的步骤，使用特定的磁盘扫描工具让你能够判断 Linux 磁盘或闪存是否存在坏道。

操作步骤如下：
在 Linux 上使用坏块工具检查坏道

坏块工具可以让用户扫描设备检查坏道或坏块。设备可以是一个磁盘或外置磁盘，由一个如

/dev/sdc

这样的文件代表。
首先，通过超级用户权限执行 fdisk 命令来显示你的所有磁盘或闪存的信息以及它们的分区信息：

$ sudo fdisk -l<br>

![[161522zvofgpg5atqaz66q.png]]

列出 Linux 文件系统分区
然后用如下命令检查你的 Linux 硬盘上的坏道/坏块：

$ sudo badblocks -v /dev/sda10 > badsectors.txt

![[161523ae1f9efev9zmpa44.png]]

在 Linux 上扫描硬盘坏道

上面的命令中，badblocks 扫描设备/dev/sda10（记得指定你的实际设备），-v选项让它显示操作的详情。另外，这里使用了输出重定向将操作结果重定向到了文件badsectors.txt。

如果你在你的磁盘上发现任何坏道，卸载磁盘并像下面这样让系统不要将数据写入回报的扇区中。

你需要执行e2fsck（针对 ext2/ext3/ext4 文件系统）或fsck命令，命令中还需要用到badsectors.txt文件和设备文件。

\-l 选项告诉命令将在指定的文件 badsectors.txt 中列出的扇区号码加入坏块列表。

\------------ 针对 for ext2/ext3/ext4 文件系统 ------------
$ sudo e2fsck -l badsectors.txt /dev/sda10
或
------------ 针对其它文件系统 ------------
$ sudo fsck -l badsectors.txt /dev/sda10

在 Linux 上使用 Smartmontools 工具扫描坏道

这个方法对带有 S.M.A.R.T（自我监控分析报告技术Self-Monitoring, Analysis and Reporting Technology）系统的现代磁盘（ATA/SATA 和 SCSI/SAS 硬盘以及固态硬盘）更加的可靠和高效。S.M.A.R.T 系统能够帮助检测，报告，以及可能记录它们的健康状况，这样你就可以找出任何可能出现的硬件失效。
你可以使用以下命令安装smartmontools：

\------------ 在基于 Debian/Ubuntu 的系统上 ------------
$ sudo apt-get install smartmontools
------------ 在基于 RHEL/CentOS 的系统上 ------------
$ sudo yum install smartmontools

安装完成之后，使用 smartctl 控制磁盘集成的 S.M.A.R.T 系统。你可以这样查看它的手册或帮助：

$ man smartctl
$ smartctl -h

然后执行 smartctrl 命令并在命令中指定你的设备作为参数，以下命令包含了参数 -H 或 --health 以显示 SMART 整体健康自我评估测试结果。

$ sudo smartctl -H /dev/sda10

![[161523ycc1n841ncat1zz2.png]]

检查 Linux 硬盘健康

上面的结果指出你的硬盘很健康，近期内不大可能发生硬件失效。

要获取磁盘信息总览，使用 -a 或 --all 选项来显示关于磁盘所有的 SMART 信息， -x 或 --xall 来显示所有关于磁盘的 SMART 信息以及非 SMART 信息。

在这个教程中，我们涉及了有关磁盘健康诊断的重要话题，希望能够帮助你。

![[Center.jpeg]]

> 本文转载自：http://www.linuxprobe.com/check-linux-disk.html
> 
> 免费提供最新Linux技术教程书籍，为开源技术爱好者努力做得更多更好：<http://www.linuxprobe.com/>

*   [[# | ![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/embedded.4.svg]]点赞 1]]
*   [[# | ![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/embedded.5.svg]]收藏]]
*   [[# | ![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/embedded.6.svg]]分享]]
*     

 [![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/embedded.8.svg]] 站内首发文章](https://blog.csdn.net/Jack__CJ/article/details/53304064)

 [![[3_u014743697.png]] ![[6.2.png]]](https://blog.csdn.net/u014743697) 

[流風餘韻](https://blog.csdn.net/u014743697)
发布了266 篇原创文章 · 获赞 37 · 访问量 52万+

[私信](https://im.csdn.net/im/main.html?userName=u014743697) 

[![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/unknown_filename.png]]](http://mssp.baidu.com/)

[[# | ![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/unknown_filename.1.png]]]]

![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/1.3.png]]

 [[# | ![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/anonymous-User-img.png]]]] 

*   [![[3_weixin_37026320.jpeg]]](https://me.csdn.net/weixin_37026320)
    
    [疾走的风](https://me.csdn.net/weixin_37026320)1年前可以通过模拟坏道列表声明坏块的方式模拟磁盘坏道吗
    ![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/embedded.9.svg]]
    

#### [_Linux_上_检测__硬盘_上的_坏_道和_坏_块](https://blog.csdn.net/weixin_34194359/article/details/91796401)

[Linux上检测硬盘上的坏道和坏块让我们从坏道和坏块的定义开始说起，它们是一块磁盘或闪存上不再能够被读写的部分，一般是由于磁盘表面特定的物理损坏或闪存晶体管失效导致的。磁盘坏道分为三种：0磁道坏道，逻...](https://blog.csdn.net/weixin_34194359/article/details/91796401) 博文 [来自： weixin\_34194359的博客](https://blog.csdn.net/weixin_34194359)

#### [完了！Windows弱爆了！它才是程序员的首选！程序员：真的好用！](https://blog.csdn.net/CSDNedu/article/details/105386555)

[最近有很多程序员在CSDN博客发帖讨论：用Windows还是Linux？关于这个问题，其实答案很简单：做开发首选Linux。如果一个程序员从来没有在Linux上开发过程序， 一直在Windows上面开...](https://blog.csdn.net/CSDNedu/article/details/105386555) 博文 [来自： CSDN学院](https://blog.csdn.net/CSDNedu)

#### [在 _Linux_ 上_检测__硬盘_上的_坏_道和_坏_块](https://blog.csdn.net/weixin_34067049/article/details/90561353)

[让我们从坏道和坏块的定义开始说起，它们是一块磁盘或闪存上不再能够被读写的部分，一般是由于磁盘表面特定的物理损坏或闪存晶体管失效导致的。随着坏道的继续积累，它们会对你的磁盘或闪存容量产生令人不快或破坏性...](https://blog.csdn.net/weixin_34067049/article/details/90561353) 博文 [来自： weixin\_34067049的博客](https://blog.csdn.net/weixin_34067049)

#### [如何在_Linux_上_检测__硬盘_上的_坏_道和_坏_块](https://blog.csdn.net/weixin_34075268/article/details/90392440)

[让我们从坏道和坏块的定义开始说起，它们是一块磁盘或闪存上不再能够被读写的部分，一般是由于磁盘表面特定的物理损坏或闪存晶体管失效导致的。随着坏道的继续积累，它们会对你的磁盘或闪存容量产生令人不快或破坏性...](https://blog.csdn.net/weixin_34075268/article/details/90392440) 博文 [来自： weixin\_34075268的博客](https://blog.csdn.net/weixin_34075268)

[![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/unknown_filename.png]]](http://mssp.baidu.com/)

[[# | ![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/unknown_filename.1.png]]]]

![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/1.3.png]]

#### [_linux__系统_下_检测__硬盘_上的_坏_道和_坏_块](https://blog.csdn.net/chamu1921/article/details/100952274)

[磁盘坏道检测当磁盘出现以下情况：io wait 无故增高或居高不下；硬盘声音突然由原来的摩檫音变成了怪音；系统无法正常启动，出现“IO error”等提示信息；mkfs时，到某一进度停滞不前，最后报错...](https://blog.csdn.net/chamu1921/article/details/100952274) 博文 [来自： chamu1921的博客](https://blog.csdn.net/chamu1921)

#### [大学四年自学走来，这些私藏的实用工具/学习网站我贡献出来了](https://blog.csdn.net/m0_37907797/article/details/102781027)

[大学四年，看课本是不可能一直看课本的了，对于学习，特别是自学，善于搜索网上的一些资源来辅助，还是非常有必要的，下面我就把这几年私藏的各种资源，网站贡献出来给你们。主要有：电子书搜索、实用工具、在线视频...](https://blog.csdn.net/m0_37907797/article/details/102781027) 博文 [来自： 帅地](https://blog.csdn.net/m0_37907797)

#### [在中国程序员是青春饭吗？](https://blog.csdn.net/harvic880925/article/details/102850436)

[今年，我也32了 ，为了不给大家误导，咨询了猎头、圈内好友，以及年过35岁的几位老程序员……舍了老脸去揭人家伤疤……希望能给大家以帮助，记得帮我点赞哦。目录：你以为的人生 一次又一次的伤害 猎头界的真...](https://blog.csdn.net/harvic880925/article/details/102850436) 博文 [来自： 启舰](https://blog.csdn.net/harvic880925)

#### [超全Python图像处理讲解（多图预警）](https://blog.csdn.net/ZackSock/article/details/103794134)

[文章目录Pillow模块讲解一、Image模块1.1 、打开图片和显示图片1.2、创建一个简单的图像1.3、图像混合（1）透明度混合（2）遮罩混合1.4、图像缩放（1）按像素缩放（2）按尺寸缩放1.5...](https://blog.csdn.net/ZackSock/article/details/103794134) 博文 [来自： ZackSock的博客](https://blog.csdn.net/ZackSock)

#### [为什么猝死的都是程序员，基本上不见产品经理猝死呢？](https://blog.csdn.net/dfskhgalshgkajghljgh/article/details/103841693)

[相信大家时不时听到程序员猝死的消息，但是基本上听不到产品经理猝死的消息，这是为什么呢？我们先百度搜一下：程序员猝死，出现将近700多万条搜索结果：搜索一下：产品经理猝死，只有400万条的搜索结果，从搜...](https://blog.csdn.net/dfskhgalshgkajghljgh/article/details/103841693) 博文 [来自： 曹银飞的专栏](https://blog.csdn.net/dfskhgalshgkajghljgh)

#### [..._检测__硬盘__坏_道\__linux_,操作_系统_,磁盘\_流風餘韻的专栏-CSDN博客](https://blog.csdn.net/u014743697/article/details/53442422)
#### [教你摸清 _Linux_ PC 的性能底细?\_运维\_流風餘韻的专栏-CSDN博客](https://blog.csdn.net/u014743697/article/details/52747718)

[![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/unknown_filename.png]]](http://mssp.baidu.com/)

[[# | ![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/unknown_filename.1.png]]]]

![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/1.3.png]]

#### [毕业5年，我问遍了身边的大佬，总结了他们的学习方法](https://blog.csdn.net/qq_35190492/article/details/103847147)

[我问了身边10个大佬，总结了他们的学习方法，原来成功都是有迹可循的。](https://blog.csdn.net/qq_35190492/article/details/103847147) 博文 [来自： 敖丙](https://blog.csdn.net/qq_35190492)

#### [...工程师真实的工作状态到底是怎么样的?\_流風餘韻的专栏-CSDN博客](https://blog.csdn.net/u014743697/article/details/54613463)
#### [运维请注意:”非常危险“的_Linux_命令大 - 流風餘韻的专栏](https://blog.csdn.net/u014743697/article/details/53883376)

#### [推荐10个堪称神器的学习网站](https://blog.csdn.net/qing_gee/article/details/103869737)

[每天都会收到很多读者的私信，问我：“二哥，有什么推荐的学习网站吗？最近很浮躁，手头的一些网站都看烦了，想看看二哥这里有什么新鲜货。”今天一早做了个恶梦，梦到被老板辞退了。虽然说在我们公司，只有我辞退老...](https://blog.csdn.net/qing_gee/article/details/103869737) 博文 [来自： 沉默王二](https://blog.csdn.net/qing_gee)

[![[3_jack__cj.png]]](https://blog.csdn.net/Jack__CJ)关注
##### [Jack\_\_CJ](https://blog.csdn.net/Jack__CJ)

234篇文章

排名:千里之外

[![[3_weixin_34075268.gif]]](https://blog.csdn.net/weixin_34194359)关注
##### [weixin\_34194359](https://blog.csdn.net/weixin_34194359)

4537篇文章

排名:千里之外

[![[3_weixin_34067049.jpeg]]](https://blog.csdn.net/weixin_34067049)关注
##### [weixin\_34067049](https://blog.csdn.net/weixin_34067049)

4636篇文章

排名:千里之外

[![[3_weixin_34075268.gif]]](https://blog.csdn.net/weixin_34075268)关注
##### [weixin\_34075268](https://blog.csdn.net/weixin_34075268)

4559篇文章

排名:千里之外

#### [深度剖析_Linux_与Windows_系统_的区别 - 流風餘韻的专栏 - CSDN博客](https://blog.csdn.net/u014743697/article/details/53332574)
#### [...高强度密码的四大神器\__linux_,服务器\_流風餘韻的专栏-CSDN博客](https://blog.csdn.net/u014743697/article/details/54136133)

#### [阿里程序员写了一个新手都写不出的低级bug，被骂惨了。](https://blog.csdn.net/qq_35190492/article/details/103965492)

[这种新手都不会范的错，居然被一个工作好几年的小伙子写出来，差点被当场开除了。...](https://blog.csdn.net/qq_35190492/article/details/103965492) 博文 [来自： 敖丙](https://blog.csdn.net/qq_35190492)

#### [作为一名大学生，如何在B站上快乐的学习？](https://blog.csdn.net/sinat_33921105/article/details/104031977)

[B站是个宝，谁用谁知道????作为一名大学生，你必须掌握的一项能力就是自学能力，很多看起来很牛X的人，你可以了解下，人家私底下一定是花大量的时间自学的，你可能会说，我也想学习啊，可是嘞，该学习啥嘞，不...](https://blog.csdn.net/sinat_33921105/article/details/104031977) 博文 [来自： 编码之外的技术博客](https://blog.csdn.net/sinat_33921105)

#### [教你在 _Linux_ 上使用 Calibre 创建电子书 - 流風餘韻的专栏](https://blog.csdn.net/u014743697/article/details/53579408)
#### [4 种方法识别_Linux__系统_ USB 设备 - 流風餘韻的专栏](https://blog.csdn.net/u014743697/article/details/53509512)

#### [Java校招入职华为，半年后我跑路了](https://blog.csdn.net/qq_33589510/article/details/104057498)

[何来我，一个双非本科弟弟，有幸在 19 届的秋招中得到前东家华为（以下简称 hw）的赏识，当时秋招签订就业协议，说是入了某 java bg，之后一系列组织架构调整原因等等让人无法理解的神操作，最终毕业...](https://blog.csdn.net/qq_33589510/article/details/104057498) 博文 [来自： JavaEdge](https://blog.csdn.net/qq_33589510)

[![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/unknown_filename.png]]](http://mssp.baidu.com/)

[[# | ![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/unknown_filename.1.png]]]]

![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/1.3.png]]

#### [如何在 _Linux_ _系统_下_检测__硬盘_上的_坏_道和_坏_块 - 流風餘韻的专栏](https://blog.csdn.net/u014743697/article/details/53316126/)

#### [强烈推荐10本程序员必读的书](https://blog.csdn.net/qing_gee/article/details/104085756)

[很遗憾，这个春节注定是刻骨铭心的，新型冠状病毒让每个人的神经都是紧绷的。那些处在武汉的白衣天使们，尤其值得我们的尊敬。而我们这些窝在家里的程序员，能不外出就不外出，就是对社会做出的最大的贡献。有些读者...](https://blog.csdn.net/qing_gee/article/details/104085756) 博文 [来自： 沉默王二](https://blog.csdn.net/qing_gee)

#### [没有项目经验怎么办？](https://blog.csdn.net/zhongyangzhong/article/details/104120813)

[职场和学校最大的不同就是：你在学校，老师给一本书，然后你考试。如果没有通过，就要补考。你在职场，领导给你一个问题，然后你来解决。如果解决不了，就要滚蛋走人。为此，你需要每半年更新一次简历......](https://blog.csdn.net/zhongyangzhong/article/details/104120813) 博文 [来自： 微信公众号：猴子聊人物](https://blog.csdn.net/zhongyangzhong)

#### [为什么说程序员做外包没前途？](https://blog.csdn.net/kebi007/article/details/104164570)

[之前做过不到3个月的外包，2020的第一天就被释放了，2019年还剩1天，我从外包公司离职了。我就谈谈我个人的看法吧。首先我们定义一下什么是有前途 稳定的工作环境 不错的收入 能够在项目中不断...](https://blog.csdn.net/kebi007/article/details/104164570) 博文 [来自： dotNet全栈开发](https://blog.csdn.net/kebi007)

#### [B 站上有哪些很好的学习资源?](https://blog.csdn.net/JiuZhang_ninechapter/article/details/104197117)

[哇说起B站，在小九眼里就是宝藏般的存在，放年假宅在家时一天刷6、7个小时不在话下，更别提今年的跨年晚会，我简直是跪着看完的！！最早大家聚在在B站是为了追番，再后来我在上面刷欧美新歌和漂亮小姐姐的舞蹈视...](https://blog.csdn.net/JiuZhang_ninechapter/article/details/104197117) 博文 [来自： 九章算法的博客](https://blog.csdn.net/JiuZhang_ninechapter)

#### [昂，我24岁了](https://blog.csdn.net/qq_35190492/article/details/104244398)

[24岁的程序员，还在未来迷茫，不知道能不能买得起房子](https://blog.csdn.net/qq_35190492/article/details/104244398) 博文 [来自： 敖丙](https://blog.csdn.net/qq_35190492)

[![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/unknown_filename.png]]](http://mssp.baidu.com/)

[[# | ![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/unknown_filename.1.png]]]]

![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/1.3.png]]

#### [新来个技术总监，禁止我们使用Lombok！](https://blog.csdn.net/hollis_chuang/article/details/104259307)

[我有个学弟，在一家小型互联网公司做Java后端开发，最近他们公司新来了一个技术总监，这位技术总监对技术细节很看重，一来公司之后就推出了很多"政策"，比如定义了很多开发规范、日志规范、甚至是要求大家统一...](https://blog.csdn.net/hollis_chuang/article/details/104259307) 博文 [来自： HollisChuang's Blog](https://blog.csdn.net/hollis_chuang)

#### [字节跳动的技术架构](https://blog.csdn.net/Ture010Love/article/details/104272717)

[字节跳动创立于2012年3月，到目前仅4年时间。从十几个工程师开始研发，到上百人，再到200余人。产品线由内涵段子，到今日头条，今日特卖，今日电影等产品线。一、产品背景今日头条是为用户提供个性化资讯客...](https://blog.csdn.net/Ture010Love/article/details/104272717) 博文 [来自： 作一个独立连续的思考者](https://blog.csdn.net/Ture010Love)

#### [C++(STL源码)：37---仿函数(函数对象)源码剖析](https://blog.csdn.net/qq_41453285/article/details/104303680)

[待续](https://blog.csdn.net/qq_41453285/article/details/104303680) 博文 [来自： 江南、董少](https://blog.csdn.net/qq_41453285)

#### [在三线城市工作爽吗？](https://blog.csdn.net/qing_gee/article/details/104323806)

[我是一名程序员，从正值青春年华的 24 岁回到三线城市洛阳工作，至今已经 6 年有余。一不小心又暴露了自己的实际年龄，但老读者都知道，我驻颜有术，上次去看房子，业务员肯定地说：“小哥肯定比我小，我今年...](https://blog.csdn.net/qing_gee/article/details/104323806) 博文 [来自： 沉默王二](https://blog.csdn.net/qing_gee)

#### [这些插件太强了，Chrome 必装！尤其程序员！](https://blog.csdn.net/qing_gee/article/details/104340125)

[推荐 10 款我自己珍藏的 Chrome 浏览器插件](https://blog.csdn.net/qing_gee/article/details/104340125) 博文 [来自： 沉默王二](https://blog.csdn.net/qing_gee)

#### [抱歉，我觉得程序员副业赚钱并不靠谱](https://blog.csdn.net/coderising/article/details/104386237)

[我最近看到不少关于程序员副业赚钱的文章，其中出的点子有这些：1. 在网上找项目做兼职2. 录制课程，到网上平台售卖，或者免费推广，赚广告费。3. 写付费的专栏文章4. 寻找漏洞，获取赏金......](https://blog.csdn.net/coderising/article/details/104386237) 博文 [来自： 码农翻身](https://blog.csdn.net/coderising)

#### [@程序员：GitHub这个项目快薅羊毛](https://blog.csdn.net/kebi007/article/details/104399183)

[今天下午在朋友圈看到很多人都在发github的羊毛，一时没明白是怎么回事。后来上百度搜索了一下，原来真有这回事，毕竟资源主义的羊毛不少啊，1000刀刷爆了朋友圈！不知道你们的朋友圈有没有看到类似的消息...](https://blog.csdn.net/kebi007/article/details/104399183) 博文 [来自： dotNet全栈开发](https://blog.csdn.net/kebi007)

#### [程序员在家撸码的十大姿势](https://blog.csdn.net/jxq0816/article/details/104464341)

[大家好，我是帅气的算法工程师，好久不见～在家办公已经一周多了，不知各位感觉如何？曾经的你以为在家办公爽歪歪，今天的你迫不及待想回公司上班，电脑屏幕太小，椅子不舒服，网络不好，没有下班时间，被娃骑脸输出...](https://blog.csdn.net/jxq0816/article/details/104464341) 博文 [来自： 姜兴琪的博客](https://blog.csdn.net/jxq0816)

#### [又一程序员删库跑路了](https://blog.csdn.net/loongggdroid/article/details/104509009)

[loonggg读完需要2分钟速读仅需 1 分钟今天刷爆朋友圈和微博的一个 IT 新闻，估计有很多朋友应该已经看到了。程序员删库跑路的事情又发生了，不是调侃，而是真实的事情。微盟官网发布公......](https://blog.csdn.net/loongggdroid/article/details/104509009) 博文 [来自： 非著名程序员](https://blog.csdn.net/loongggdroid)

#### [我以为我学懂了数据结构，直到看了这个导图才发现，我错了](https://blog.csdn.net/qq_38646470/article/details/104547401)

[数据结构与算法思维导图](https://blog.csdn.net/qq_38646470/article/details/104547401) 博文 [来自： 龙跃十二](https://blog.csdn.net/qq_38646470)

#### [String s = new String(" a ") 到底产生几个对象？](https://blog.csdn.net/qq_44543508/article/details/104560346)

[老生常谈的一个梗，到2020了还在争论，你们一天天的，哎哎哎，我不是针对你一个，我是说在座的各位都是人才！上图红色的这3个箭头，对于通过new产生一个字符串（”宜春”）时，会先去常量池中查找是否已经有...](https://blog.csdn.net/qq_44543508/article/details/104560346) 博文 [来自： 宜春](https://blog.csdn.net/qq_44543508)

#### [面试官：什么是二叉树](https://blog.csdn.net/Java_3y/article/details/104570054)

[这怕是对新手最好的二叉树入门文章了。](https://blog.csdn.net/Java_3y/article/details/104570054) 博文 [来自： 3y](https://blog.csdn.net/Java_3y)

#### [技术大佬：我去，你写的 switch 语句也太老土了吧](https://blog.csdn.net/qing_gee/article/details/104586826)

[昨天早上通过远程的方式 review 了两名新来同事的代码，大部分代码都写得很漂亮，严谨的同时注释也很到位，这令我非常满意。但当我看到他们当中有一个人写的 switch 语句时，还是忍不住破口大骂：“...](https://blog.csdn.net/qing_gee/article/details/104586826) 博文 [来自： 沉默王二](https://blog.csdn.net/qing_gee)

#### [和黑客斗争的 6 天！](https://blog.csdn.net/ityouknow/article/details/104666810)

[互联网公司工作，很难避免不和黑客们打交道，我呆过的两家互联网公司，几乎每月每天每分钟都有黑客在公司网站上扫描。有的是寻找 Sql 注入的缺口，有的是寻找线上服务器可能存在的漏洞，大部分都......](https://blog.csdn.net/ityouknow/article/details/104666810) 博文 [来自： 纯洁的微笑](https://blog.csdn.net/ityouknow)

#### [讲一个程序员如何副业月赚三万的真实故事](https://blog.csdn.net/loongggdroid/article/details/104687629)

[loonggg读完需要3分钟速读仅需 1 分钟大家好，我是你们的校长。我之前讲过，这年头，只要肯动脑，肯行动，程序员凭借自己的技术，赚钱的方式还是有很多种的。仅仅靠在公司出卖自己的劳动时......](https://blog.csdn.net/loongggdroid/article/details/104687629) 博文 [来自： 非著名程序员](https://blog.csdn.net/loongggdroid)

#### [一大波硕士即将来袭](https://blog.csdn.net/siyuanwai/article/details/104695955)

[前几天有一个读者朋友，也是程序员，在微信和我说：研究生扩招了，他要不要把专科学历提高一下？我查了一下新闻，确实：2020 年硕士研究生扩招 18.9 万人，扩招向临床医学、公共卫生、人工智能等专业倾向...](https://blog.csdn.net/siyuanwai/article/details/104695955) 博文 [来自： siyuanwai的博客](https://blog.csdn.net/siyuanwai)

#### [你以为这样写Java代码很6，但我看不懂](https://blog.csdn.net/qing_gee/article/details/104709079)

[为了提高 Java 编程的技艺，我最近在 GitHub 上学习一些高手编写的代码。下面这一行代码（出自大牛之手）据说可以征服你的朋友，让他们觉得你写的代码很 6，来欣赏一下吧。IntStream.ra...](https://blog.csdn.net/qing_gee/article/details/104709079) 博文 [来自： 沉默王二](https://blog.csdn.net/qing_gee)

#### [别再自己抠图了，Python用5行代码实现批量抠图](https://blog.csdn.net/ZackSock/article/details/104738652)

[前言对于会PhotoShop的人来说，弄一张证件照还是非常简单的，但是还是有许多人不会PhotoShop的。今天就给你们带来一个非常简单的方法，用Python快速生成一个证件照，照片的底色随你选。实现...](https://blog.csdn.net/ZackSock/article/details/104738652) 博文 [来自： ZackSock的博客](https://blog.csdn.net/ZackSock)

#### [上班一个月，后悔当初着急入职的选择了](https://blog.csdn.net/hejjunlin/article/details/104740320)

[最近有个老铁，告诉我说，上班一个月，后悔当初着急入职现在公司了。他之前在美图做手机研发，今年美图那边今年也有一波组织优化调整，他是其中一个，在协商离职后，当时捉急找工作上班，因为有房贷供着，不能没有收...](https://blog.csdn.net/hejjunlin/article/details/104740320) 博文 [来自： 码农突围](https://blog.csdn.net/hejjunlin)

#### [女程序员，为什么比男程序员少？？？](https://blog.csdn.net/shenjian58/article/details/104744259)

[昨天看到一档综艺节目，讨论了两个话题：（1）中国学生的数学成绩，平均下来看，会比国外好？为什么？（2）男生的数学成绩，平均下来看，会比女生好？为什么？同时，我又联想到了一个技术圈经常讨......](https://blog.csdn.net/shenjian58/article/details/104744259) 博文 [来自： shenjian58的博客](https://blog.csdn.net/shenjian58)

[Java](https://java.csdn.net/) [C语言](https://c1.csdn.net/) [Python](https://python.csdn.net/) [C++](https://cplus.csdn.net/) [C#](https://csharp.csdn.net/) [Visual Basic .NET](https://vbn.csdn.net/) [JavaScript](https://js.csdn.net/) [PHP](https://php.csdn.net/) [SQL](https://sql.csdn.net/) [Go语言](https://go.csdn.net/) [R语言](https://r.csdn.net/) [Assembly language](https://assembly.csdn.net/) [Swift](https://swift.csdn.net/) [Ruby](https://ruby.csdn.net/) [MATLAB](https://matlab.csdn.net/) [PL/SQL](https://plsql.csdn.net/) [Perl](https://perl.csdn.net/) [Visual Basic](https://vb.csdn.net/) [Objective-C](https://obj.csdn.net/) [Delphi/Object Pascal](https://delphi.csdn.net/) [Unity3D](https://www.csdn.net/unity/)

©️2019 CSDN 皮肤主题: 大白 设计师: CSDN官方博客

 [![[3_u014743697.png]] ![[6.2.png]]](https://blog.csdn.net/u014743697) 

[流風餘韻](https://blog.csdn.net/u014743697)
[TA的个人主页 >](https://me.csdn.net/u014743697)

[原创](https://blog.csdn.net/u014743697)
[266](https://blog.csdn.net/u014743697)

粉丝
72

获赞
37

评论
19

访问
52万+

等级:
 [![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/embedded.10.svg]]](https://blog.csdn.net/home/help.html#level) 

周排名:
[6万+](https://blog.csdn.net/rank/writing_rank)

积分:
6869

总排名:
[7300](https://blog.csdn.net/rank/writing_rank_total)

勋章:

![[chizhiyiheng@120.png]]

[私信](https://im.csdn.net/im/main.html?userName=u014743697)

*   [![[u=3915460605,3737330242&fm=76.jpeg]]](https://cpro.baidu.com/cpro/ui/uijs.php?en=mywWUA71T1YsFh7sT7qGujYsFhPC5H0huAbqrauGTdq9TZ0qnauJp1d9nv7hnAPWmymsrHR3njDdFh_qFRc4FRRzFRcYFRm1FRFaFRD3FRfYFRcsFRcvFRu7FRPKFRfvFRcLFRFAFhkdpvbqPauVmLKV5HmLnjmsFMDqmLPbUhF9pywdgvPsTBuzmWYkFMF15HDhTvN_UANzgv-b5HDhTv-b5HDdrj04PymsmvDsmv7hmHnhTLwGujYknHThIjdYTAP_pyPouyf1gv9WFMwb5Hnsn1cdnW6hIAd15HDdrjm3Pj6sPjchIZRqIHnsn1cdnW6hIHdCIZwsTzR1fiRzwBRzwhF_UvT-nbNWTvw8FHF7UhNYFMNGUy-b5HbknjDYnjn1Pauv5HchpHY4nj-Buyc4rf&besl=-1&c=news&cf=1&cvrq=2911142&eid_list=208624&expid=6588_200019_200352_203417_205035_208624_208749&fr=1&fv=0&haacp=607&img_typ=22562&itm=0&lu_idc=nj02&lukid=4&lus=158095f0ca0cafa3&lust=5e95612a&mscf=0&mtids=8066100&n=10&nttp=1&p=baidu&pbs=228840&sce=7&sr=394&ssp2=1&tpl=baiduCustNativeADImageCarousel&tsf=dtp:1&u=%2Fu014743697%2Farticle%2Fdetails%2F53316126&uicf=lurecv&urlid=0&eot=1)
*   [![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/u=1720414796,1289281700&fm=76.jpeg]]](https://cpro.baidu.com/cpro/ui/uijs.php?en=mywWUA71T1YsFh7sT7qGujYsFhPC5H0huAbqrauGTdq9TZ0qnauJp1d9nv7hnAPWmymsrHR3njDdFh_qFRfsFRDkFRc1FRPjFRfsFRmzFRFAFRNjFRPaFRf4FRFAFR7KFRcLFRDzFhkdpvbqniuVmLKV5Hb3n16kFMDqmLPbUhF9pywdgvPsTBuzmWYkFMF15HDhTvN_UANzgv-b5HDhTv-b5HDdrj04PymsmvDsmv7hmHnhTLwGujYknHThIjdYTAP_pyPouyf1gv9WFMwb5Hnsn1cdnW6hIAd15HDdrjm3Pj6sPjchIZRqIHnsn1cdnW6hIHdCIZwsTzR1fiRzwBRzwhF_UvT-nbNWTvw8FHF7UhNYFMNGUy-b5HbknjDYnjn1Pauv5HchpHY4uWKbPAmzns&besl=-1&c=news&cf=1&cvrq=3201299&eid_list=208624&expid=6588_200019_200352_203417_205035_208624_208749&fr=1&fv=0&haacp=1405&img_typ=22562&itm=0&lu_idc=nj02&lukid=1&lus=158095f0ca0cafa3&lust=5e95612a&mscf=0&mtids=2016063787&n=10&nttp=1&p=baidu&pbs=228840&sce=7&sr=394&ssp2=1&tpl=baiduCustNativeADImageCarousel&tsf=dtp:1&u=%2Fu014743697%2Farticle%2Fdetails%2F53316126&uicf=lurecv&urlid=0&eot=1)
*   [![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/u=3033311644,2541873126&fm=76.jpeg]]](https://cpro.baidu.com/cpro/ui/uijs.php?en=mywWUA71T1YsFh7sT7qGujYsFhPC5H0huAbqrauGTdq9TZ0qnauJp1d9nv7hnAPWmymsrHR3njDdFh_qFRcYFRm1FRPKFRuDFRF7FRwDFRFAFRn4FRPKFRf1FRFaFR7AFhkdpvbqnBuVmLKV5HmYP1bLFMDqmLPbUhF9pywdgvPsTBuzmWYkFMF15HDhTvN_UANzgv-b5HDhTv-b5HDdrj04PymsmvDsmv7hmHnhTLwGujYknHThIjdYTAP_pyPouyf1gv9WFMwb5Hnsn1cdnW6hIAd15HDdrjm3Pj6sPjchIZRqIHnsn1cdnW6hIHdCIZwsTzR1fiRzwBRzwhF_UvT-nbNWTvw8FHF7UhNYFMNGUy-b5HbknjDYnjn1Pauv5HchpHdbm1PBuWIWP6&besl=-1&c=news&cf=1&cvrq=519849&eid_list=208624&expid=6588_200019_200352_203417_205035_208624_208749&fr=1&fv=0&haacp=270&img_typ=22566&itm=0&lu_idc=nj02&lukid=2&lus=158095f0ca0cafa3&lust=5e95612a&mscf=0&mtids=2001988411&n=10&nttp=1&p=baidu&pbs=228840&sce=7&sr=394&ssp2=1&tpl=baiduCustNativeADImageCarousel&tsf=dtp:1&u=%2Fu014743697%2Farticle%2Fdetails%2F53316126&uicf=lurecv&urlid=0&eot=1)

[![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/unknown_filename.png]]](http://mssp.baidu.com/)

[[# | ![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/unknown_filename.1.png]]]]

[小程序快速开发](https://cpro.baidu.com/cpro/ui/uijs.php?en=mywWUA71T1YsFh7sT7qGujYsFhPC5H0huAbqrauGTdq9TZ0qnauJp1d9nv7hnAPWmymsrHR3njDdFh_qFRfsFRDkFRc1FRPjFRfsFRmzFRFAFRNjFRPaFRf4FRFAFR7KFRcLFRDzFhkdpvbqniuVmLKV5Hb3n16kFMDqmLPbUhF9pywdgvPsTBuzmWYkFMF15HDhTvN_UANzgv-b5HDhTv-b5HDdrj04PymsmvDsmv7hmHnhTLwGujYknHThIjdYTAP_pyPouyf1gv9WFMwb5Hnsn1cdnW6hIAd15HDdrjm3Pj6sPjchIZRqIHnsn1cdnW6hIHdCIZwsTzR1fiRzwBRzwhF_UvT-nbNWTvw8FHF7UhNYFMNGUy-b5HbknjDYnjn1Pauv5HchpHY4uWKbPAmzns&besl=-1&c=news&cf=1&cvrq=3201299&eid_list=208624&expid=6588_200019_200352_203417_205035_208624_208749&fr=1&fv=0&haacp=1405&img_typ=22562&itm=0&lu_idc=nj02&lukid=1&lus=158095f0ca0cafa3&lust=5e95612a&mscf=0&mtids=2016063787&n=10&nttp=1&p=baidu&pbs=228840&sce=7&sr=394&ssp2=1&tpl=baiduCustNativeADImageCarousel&tsf=dtp:1&u=%2Fu014743697%2Farticle%2Fdetails%2F53316126&uicf=lurecv&urlid=0&eot=1)

![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/1.3.png]]

### 最新文章

*   [UNIX系统之shell 脚本之源](https://blog.csdn.net/u014743697/article/details/58584304)
*   [Linux系统从零到高手的进阶心得](https://blog.csdn.net/u014743697/article/details/57407930)
*   [u盘安装linux操作系统So Easy](https://blog.csdn.net/u014743697/article/details/57071760)
*   [锁定 Linux 用户虚拟控制台的好命令–volck](https://blog.csdn.net/u014743697/article/details/57071619)
*   [帮助Linux管理员简化任务并实现自动化的七大工具](https://blog.csdn.net/u014743697/article/details/56664662)

### 分类专栏

*    [![[20190918140053667.png]] linux（news)  18篇](https://blog.csdn.net/u014743697/category_6435362.html) 
*    [![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/20190918140012416.png]] linux(技术干货)  273篇](https://blog.csdn.net/u014743697/category_6435382.html) 

### 归档

*   [2017年2月 33篇](https://blog.csdn.net/u014743697/article/month/2017/02)
*   [2017年1月 58篇](https://blog.csdn.net/u014743697/article/month/2017/01)
*   [2016年12月 57篇](https://blog.csdn.net/u014743697/article/month/2016/12)
*   [2016年11月 63篇](https://blog.csdn.net/u014743697/article/month/2016/11)
*   [2016年10月 65篇](https://blog.csdn.net/u014743697/article/month/2016/10)
*   [2016年9月 13篇](https://blog.csdn.net/u014743697/article/month/2016/09)

### 热门文章

*   [如何选择文件系统：EXT4、Btrfs 和 XFS](https://blog.csdn.net/u014743697/article/details/54089297)
    
    阅读数 44348
    
*   [如何在 Linux 系统下检测硬盘上的坏道和坏块](https://blog.csdn.net/u014743697/article/details/53316126)
    
    阅读数 35308
    
*   [mysql中null与“空值”的坑](https://blog.csdn.net/u014743697/article/details/54136092)
    
    阅读数 26207
    
*   [深度剖析Linux与Windows系统的区别](https://blog.csdn.net/u014743697/article/details/53332574)
    
    阅读数 20471
    
*   [教你搭建你自己的Git服务器](https://blog.csdn.net/u014743697/article/details/52846360)
    
    阅读数 16988
    

### 最新评论

*   [mysql中null与“空值”的坑](https://blog.csdn.net/u014743697/article/details/54136092#comments)
    
    ... [swordtenno：](https://my.csdn.net/swordtenno)有没有大佬说明一下这文章对不对
    
*   [为什么计算机时间要从1970年1月...](https://blog.csdn.net/u014743697/article/details/54585918#comments)
    
    ... [weixin\_43590389：](https://my.csdn.net/weixin_43590389)棒(๑•̀ㅂ•́)و✧
    
*   [mysql中null与“空值”的坑](https://blog.csdn.net/u014743697/article/details/54136092#comments)
    
    ... [solidco2：](https://my.csdn.net/solidco2)一本正经的胡说八道啊
    
*   [Linux上不错的EPUB阅读软件](https://blog.csdn.net/u014743697/article/details/53389090#comments)
    
    ... [avi9111：](https://my.csdn.net/avi9111)不错不错，看看有没开源的
    
*   [10款优秀Vim插件帮你打造完美I...](https://blog.csdn.net/u014743697/article/details/52678864#comments)
    
    ... [u010391029：](https://my.csdn.net/u010391029)史上最好用的github vim-ide项目 https://github.com/Hello-Linux/Ansible-VIM-IDE 智能化简单化快速化
    

![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/1.3.png]]

![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/embedded.11.svg]][kefu@csdn.net](https://blog.csdn.net/u014743697/article/details/53316126mailto:webmaster@csdn.net) _![[./_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/embedded.12.svg]][QQ客服](https://url.cn/5epoHIm?_type=wpa&qidian=true)_

_![[./_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/embedded.13.svg]][客服论坛](http://bbs.csdn.net/forums/Service)_ ![[./_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/embedded.14.svg]]400-660-0108

工作时间 8:30-22:00

[关于我们](https://www.csdn.net/company/index.html#about)[招聘](https://www.csdn.net/company/index.html#recruit)[广告服务](https://www.csdn.net/company/index.html#advertisement) [网站地图](https://www.csdn.net/gather/A)

[京ICP备19004658号](http://beian.miit.gov.cn/publish/query/indexFirst.action) [经营性网站备案信息](https://csdnimg.cn/cdn/content-toolbar/csdn-ICP.png)

![[8知识管理/InBox/evernote/参考/_resources/如何在_Linux_系统下检测硬盘上的坏道和坏块_运维_流風餘韻的专栏-CSDN博客.resources/gongan.png]][公安备案号 11010502030143](http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11010502030143)

©1999-2020 北京创新乐知网络技术有限公司 [网络110报警服务](http://www.cyberpolice.cn/)

[北京互联网违法和不良信息举报中心](http://www.bjjubao.org/)

[中国互联网举报中心](http://www.12377.cn/)[家长监护](https://download.csdn.net/index.php/tutelage/)

[版权与免责声明](https://www.csdn.net/company/index.html#statement)[版权申诉](https://blog.csdn.net/blogdevteam/article/details/90369522)

    Created at: 2020-04-14T16:11:05+08:00
    Updated at: 2020-04-14T16:11:05+08:00


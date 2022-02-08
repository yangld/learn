
# Charles使用及mock数据

2018年08月01日 20:27:55 [小Di666](https://me.csdn.net/sinat_38679519) 阅读数 1183更多
分类专栏： [测试工具](https://blog.csdn.net/sinat_38679519/article/category/7897838)

**1、下载charles 3.9.2**【破解版地址：<https://download.csdn.net/my>】
下方有一种方法可破解4.2以前的版本
// Charles Proxy License
// 适用于Charles任意版本的注册码，谁还会想要使用破解版呢。

// Charles 4.2目前是最新版，可用。
Registered Name: [https://zhile.io](https://zhile.io/)
License Key: 48891cf209c6d32bf4
本方法通杀charlse系列激活问题
转自：[https://blog.csdn.net/qq\_25821067/article/details/79848589](https://blog.csdn.net/qq_25821067/article/details/79848589)
**2、配置手机端代理：**
Windows : 使用win +R 快捷键，唤出命令行面板,输入cmd,点击enter键;面板出来之后输入ipconfig,便会打印出对应的电脑端ip地址,如下图所示:

![[70.4.png]]

找ipv4地址的ip，然后输入手机对应的ip地址.置于端口一般是默认的【8888】,发发发。当然你可以修改喽。

流程：

![[70.7.png]]

置于其他更加高级的选项，可自行百度。。。

**3、当然手机配置之后还是不行的，charles 还得查看一下是否开启了代理模式。**

![[70.2.png]]

勾选StartRecording、Windows Proxy选项即可。

这样基本就可以看到请求的地址以及数据。

\*\*4、构造数据
4.1替换对应的url地址，返回的数据:\*\*

1>、首先需要知道对应url的真实数据模型【就是返回的数据】

![[70.5.png]]

2>、本地创建一个.txt文本，复制这块数据：

![[70.8.png]]

修改你想要修改的数据即可，notepad++,挺好用的。。。【注意编码utf-8】

3>、造好数据之后那么就可以发功了。哈哈哈：

![[70.1.png]]

重启app，那么就会发现神奇的生效了。。。

**4.2使用breakpoints**
1>选择需要修改的url，鼠标右键点击选择breakpoints

![[70.9.png]]

2>杀掉进程，重新打开应用并重新打开这个页面，操作区域点击Execute

![[8知识管理/InBox/evernote/参考/_resources/Charles使用及mock数据_-_sinat_38679519的博客_-_CSDN博客.resources/70.png]]

3> 点击EditResponse->Json Text

![[70.6.png]]

4>接下来再4区域就可以随意编辑你想要修改的数据啦，最后点击Execute，然后看一下你手机上面的数据是否更改

![[70.3.png]]

Measure
Measure

    Created at: 2019-09-23T16:57:35+08:00
    Updated at: 2019-09-23T16:57:35+08:00


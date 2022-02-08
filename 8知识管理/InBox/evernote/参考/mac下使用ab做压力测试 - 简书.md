
# mac下使用ab做压力测试

[![[8知识管理/InBox/evernote/参考/_resources/mac下使用ab做压力测试_-_简书.resources/webp.1.webp]]](https://www.jianshu.com/u/31d69495d0ef)

[可湿水程序](https://www.jianshu.com/u/31d69495d0ef)
_![[./_resources/mac下使用ab做压力测试_-_简书.resources/embedded.svg]]_0.1642017.10.31 15:54:29字数 292阅读 7,093

## 准备工作

mac自带的apache中的ab是有最大并发限制的,所以我们要重新下载一个apache并且编译
[下载地址](https://link.jianshu.com/?t=http://httpd.apache.org/download.cgi#apache24)
下载完以后我们解压
编译

    tar -zxvf httpd-2.4.29.tar.bz2
    ./configure --prefix=/usr/local/httpd/
    make
    make install
    1234

上面的语句基本都会报错,提示缺少apr, apr-util, pcrc这三个依赖
所用我们得先安装这三个
**下载地址**
[apr和apr-util](https://link.jianshu.com/?t=http://apr.apache.org/download.cgi)
[PCRE](https://link.jianshu.com/?t=https://ftp.pcre.org/pub/pcre/)

> 提前说明我的编译目标的目录为(下载目录随便在哪个盘里):
> apache: /usr/local/httpd/
> apr: /usr/local/apr/
> apr-util: /usr/local/apr-util/
> pcre: /usr/local/pcre/
> 
> #evernote

进入到**下载**的目录,
分别解压这三个安装包

    tar -zxvf [安装包的名字]
    1

分别进入这三个解压后的安装包目录
_温馨提示:如果./configure 找不到,说明下载的安装包有问题,一般重新下载就可以了_

    #进入apr解压目录
    #这里的--prefix参数就是要编译到的路径
    
    ./configure --prefix=/usr/local/apr 
    make
    make install
    
    =========分割线============
    #进入apr-util解压目录,这个安装包依赖apr
    ./configure --prefix=/usr/local/apr-util -with-apr=/usr/local/apr/
    make
    make install
    
    =========分割线============
    #进入pcrej解压目录
    ./configure --prefix=/usr/local/apr-util
    make
    make install
    123456789101112131415161718

这个时候再编译我们的apache就没问题了.

    #进入到apache的解压目录
    ./configure --prefix=/usr/local/httpd/ -with-apr=/usr/local/apr -with-apr-util=/usr/local/apr-util/ -with-pcre=/usr/local/pcre/
    make
    make install
    1234

## 替换mac的ab

替换说明:[http://www.liujingze.com/fixing-apr-socket-recv-connection-reset-by-peer-54-and-socket-too-many-open-files-on-mac-osx.html](https://link.jianshu.com/?t=http://www.liujingze.com/fixing-apr-socket-recv-connection-reset-by-peer-54-and-socket-too-many-open-files-on-mac-osx.html)
替换ab工具权限不够解决办法:[Unix/Linux 系统中的 Operation Not Permitted 问题](https://link.jianshu.com/?t=http://www.barretlee.com/blog/2016/04/06/operation-not-permitted-problem-in-linux-or-unix-system/)

_![[./_resources/mac下使用ab做压力测试_-_简书.resources/embedded.1.svg]]_
3人点赞_![[./_resources/mac下使用ab做压力测试_-_简书.resources/embedded.2.svg]]_

_![[./_resources/mac下使用ab做压力测试_-_简书.resources/embedded.3.svg]]_

[_![[./_resources/mac下使用ab做压力测试_-_简书.resources/embedded.4.svg]]_测试](https://www.jianshu.com/nb/18303613)

_![[./_resources/mac下使用ab做压力测试_-_简书.resources/embedded.5.svg]]_

"小礼物走一走，来简书关注我"
还没有人赞赏，支持一下
[![[8知识管理/InBox/evernote/参考/_resources/mac下使用ab做压力测试_-_简书.resources/webp.webp]]](https://www.jianshu.com/u/31d69495d0ef)

[可湿水程序](https://www.jianshu.com/u/31d69495d0ef)把技术搞精通, 把生活搞精致, 把社交搞起来
总资产5 (约0.49元)共写了2.5W字获得77个赞共12个粉丝

    Created at: 2020-07-30T14:51:35+08:00
    Updated at: 2020-07-30T14:51:35+08:00


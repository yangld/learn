
# HTTP之connect method

[![[8知识管理/InBox/evernote/参考/_resources/HTTP之connect_method_-_简书.resources/webp.webp]]](https://www.jianshu.com/u/f67233ce6c0c)

[wenmingxing](https://www.jianshu.com/u/f67233ce6c0c)
_![[./_resources/HTTP之connect_method_-_简书.resources/embedded.svg]]_0.0672018.05.22 15:34:53字数 366阅读 19,964

> 本文主要介绍HTTP1.1中的connect方法。

在HTTP中常用的方法有get，post，head。但也有很多不常用的method，其中就包括connect。

1、HTTP代理使用的就是connect这个方法，connect在网页开发中不会使用到。

2、connect的作用就是将服务器作为代理，让服务器代替用户去访问其他网页（说白了，就是翻墙），之后将数据返回给用户。

3、connect是通过TCP连接代理服务器的。加入我想告诉代理服务器向访问`https://www.jianshu.com/u/f67233ce6c0c`网站，就需要首先建立起一条从我的客户端到代理服务器的TCP连接，然后给代理服务器发送一个HTTP报文：

    CONNECT https://www.jianshu.com/u/f67233ce6c0c:80 HTTP/1.1
    Host: www.web-tinker.com:80
    Proxy-Connection: Keep-Alive
    Proxy-Authorization: Basic *
    Content-Length: 0
    12345

其中`Proxy-Authorization`中，为验证用户名和密码部分。

在发送完这个请求之后，代理服务器会响应请求，返回一个200的信息，但这个200并不同于我们平时见到的OK，而是Connection Established。

    HTTP/1.1 200 Connection Established
    1

如果用户名密码部分验证失败，则会返回：

    HTTP/1.1 407 Unauthorized
    1

通过验证之后，就可以做HTTP操作了，发送的HTTP请求报文会通过代理服务器请求Internet服务器。然后返回给客户端。

【参考】
\[1\] [HTTP代理协议 HTTP/1.1的CONNECT方法](https://blog.csdn.net/kobejayandy/article/details/24606521)

_![[./_resources/HTTP之connect_method_-_简书.resources/embedded.1.svg]]_
3人点赞_![[./_resources/HTTP之connect_method_-_简书.resources/embedded.2.svg]]_

_![[./_resources/HTTP之connect_method_-_简书.resources/embedded.3.svg]]_

[_![[./_resources/HTTP之connect_method_-_简书.resources/embedded.4.svg]]_你好呀 计算机网络](https://www.jianshu.com/nb/23508085)

_![[./_resources/HTTP之connect_method_-_简书.resources/embedded.5.svg]]_

"小礼物走一走，来简书关注我"
还没有人赞赏，支持一下
[![[8知识管理/InBox/evernote/参考/_resources/HTTP之connect_method_-_简书.resources/webp.1.webp]]](https://www.jianshu.com/u/f67233ce6c0c)

[wenmingxing](https://www.jianshu.com/u/f67233ce6c0c)
总资产6 (约0.44元)共写了13.6W字获得424个赞共92个粉丝

    Created at: 2020-11-13T09:40:16+08:00
    Updated at: 2020-11-13T09:40:16+08:00


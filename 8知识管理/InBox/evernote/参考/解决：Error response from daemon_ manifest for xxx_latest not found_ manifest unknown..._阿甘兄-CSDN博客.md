
# 解决：Error response from daemon: manifest for xxx:latest not found: manifest unknown...

![[8知识管理/InBox/evernote/参考/_resources/解决：Error_response_from_daemon__manifest_for_xxx_latest_not_found__manifest_unknown..._阿甘兄-CSDN博客.resources/original.png]]
[杨林伟](https://yanglinwei.blog.csdn.net/) 2020-03-23 10:53:29 ![[8知识管理/InBox/evernote/参考/_resources/解决：Error_response_from_daemon__manifest_for_xxx_latest_not_found__manifest_unknown..._阿甘兄-CSDN博客.resources/articleReadEyes.png]] 10495  

		
分类专栏： [\# 常见错误](https://blog.csdn.net/qq_20042935/category_9652253.html)

![[8知识管理/InBox/evernote/参考/_resources/解决：Error_response_from_daemon__manifest_for_xxx_latest_not_found__manifest_unknown..._阿甘兄-CSDN博客.resources/embedded.svg]]

在使用docker 拉去最新的镜像时，会提示如下错误：
![[202003231045297.png]]
这里错误的意思是docker需要我们指定下载镜像的版本号。

但是我们想下载最新的版本号，该如何得知最新的版本号呢？

我们可以登录docker hub：<https://hub.docker.com/u/library>，搜索自己想要下载的镜像名:
![[8知识管理/InBox/evernote/参考/_resources/解决：Error_response_from_daemon__manifest_for_xxx_latest_not_found__manifest_unknown..._阿甘兄-CSDN博客.resources/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_.2.png]]
点击搜索出来列表里的镜像，进入详情页面，点击Tags，第一个镜像就是最新的，可以看出，最新的镜像版本号为`7.6.1`：
![[8知识管理/InBox/evernote/参考/_resources/解决：Error_response_from_daemon__manifest_for_xxx_latest_not_found__manifest_unknown..._阿甘兄-CSDN博客.resources/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_.1.png]]

重新使用docker执行版本号拉取，可以看到正在下载：
![[8知识管理/InBox/evernote/参考/_resources/解决：Error_response_from_daemon__manifest_for_xxx_latest_not_found__manifest_unknown..._阿甘兄-CSDN博客.resources/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_.png]]

    Created at: 2021-02-01T09:03:52+08:00
    Updated at: 2021-02-01T09:03:52+08:00


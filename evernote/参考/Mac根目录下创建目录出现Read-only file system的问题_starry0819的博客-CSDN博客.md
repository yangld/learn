
# Mac根目录下创建目录出现Read-only file system的问题

![[./_resources/Mac根目录下创建目录出现Read-only_file_system的问题_starry0819的博客-CSDN博客.resources/original.png]]
[starry0819](https://blog.csdn.net/starry0819) 2019-10-16 11:37:04 ![[./_resources/Mac根目录下创建目录出现Read-only_file_system的问题_starry0819的博客-CSDN博客.resources/articleReadEyes.png]] 11919  

		
文章标签： [Mac](https://www.csdn.net/tags/OtTaMg2sNjk5Ny1ibG9n.html)

![[./_resources/Mac根目录下创建目录出现Read-only_file_system的问题_starry0819的博客-CSDN博客.resources/embedded.svg]]

首先，执行以下命令查看SIP的状态

    ➜  ~ csrutil status
    System Integrity Protection status: disabled.
    

若不是disabled状态的话，先关闭SIP

**关闭SIP的方法**

    1、重启Mac
    2、在OS X启动之前，按住 Command+R 并保持不动，
    直到看到Apple图标和进度条。发布。这将引导你进入恢复。
    3、从 “实用工具” 菜单中选择 “终端”。
    4、在提示符处输入以下内容，然后按回车键：
    csrutil disable
    5、终端应显示SIP被禁用的消息。
    6、从菜单中选择 重新启动。
    

然后执行

    sudo mount -uw /
    

此时应该可以创建目录了，执行创建命令尝试以下

    sudo mkdir /home

    Created at: 2020-12-23T14:55:59+08:00
    Updated at: 2020-12-23T14:55:59+08:00


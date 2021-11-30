
### [GoAccess将WebSocket服务器设置为侦听端口7890和localhost](https://www.thinbug.com/q/38710438)

时间：2016-08-02 01:25:52

标签： nginx goaccess

我正在尝试运行[GoAccess](https://goaccess.io/man#examples)示例：

    # goaccess -f access.log -o report.html --real-time-html
    

还有

    Parsing... [41] [0/s]
    

或终端没有输出。我等了很久然后按CTRL + C：

    ^CSIGINT caught!
    Stopping WebSocket server...
    

也许我错过了一步：

“输出HTML报告并将WebSocket服务器设置为侦听端口7890和localhost。”

`my.ip.address.here:7890`处的“连接重置”。

我猜测nginx不参与其中，因为它的日志只显示对其他网页的调用。

是否还有其他我可能想要查看的配置或日志？

更新：

更清楚一点，并且已经走到了这一步：

    $ sudo goaccess -f /var/log/nginx/access.log.1 -o /usr/share/nginx/www/report.html \\
    --real-time-html --ws-url=domain.com
    Parsing... [84] [0/s]
    

我可以：

    telnet domain.com 7890
    Trying 45.55.xxx.xxx...
    Connected to domain.com.
    Escape character is '^]'.
    

在浏览器中：domain.com:7890/report.html返回连接重置。

有人会澄清这条道路应该代表什么：

    /usr/share/nginx/www/report.html
    

`report.html`是否应该存在并且路径是否需要到服务器系统中的特定位置？

#### 3 个答案:

答案 0 :(得分：2)

从GoAccess网站引用：

>   
> 
> 生成实时HTML报告的过程非常类似于   创建静态报告的过程。
> 
>      
> 
> 只需生成静态报告并将输出html文件放在下面   您的Web服务器www公用文件夹。你需要添加几个   额外的实时标志。需要使用--real-time-html。

    # goaccess -f access.log -o /usr/share/nginx/www/rt.goaccess.io/report.html --real-time-html --ws-url=host 
    

>   
> 
> 在浏览器中打开生成的报告后，报告将尝试与主机建立WebSocket连接   由--ws-url =指定。请注意，主机应指向   运行GoAccess的位置和解析日志。另外，请确保   host是一个有效的主机，不应包含http。
> 
>      
> 
> 如果您不使用--ws-url，它将尝试建立WebSocket   连接到localhost，这意味着GoAccess应该正在运行   在本地计算机上（运行浏览器的同一台计算机）

在手册页中，默认情况下GoAccess似乎在端口7890上运行。如它所述，您可能希望指定`--ws-url`来指定GoAccess WebSocket服务器的位置，除非您的访问日志位于本地计算机上。

答案 1 :(得分：2)

我在使实时报告工作时遇到了一些问题，并最终发现了为什么他们不为我工作。这可能/可能不适用于您。

我在我的网站目录中生成实时报告，该目录通过SSL运行。不幸的是，Goaccess实时报告根本不适用于SSL。

我解决这个问题的方法是设置一个新域goaccess.mydomain.com并将其设置为在Nginx上的port80上运行。然后用.htpasswd文件保护/ location，然后我将实时报告生成到新网站的文件夹中。

静态报告通过SSL 100％工作，而不是实时。

所以我现在每天使用Cron做的是为我想要监控的网站生成实时报告。

    goaccess -f /var/log/nginx/site1-access.log -a -o /var/www/goaccess.mydomain.com/site1.html
    goaccess -f /var/log/nginx/site2-access.log -a -o /var/www/goaccess.mydomain.com/site2.html
    

然后，当我想要某个网站上的实时报告时，我就跑了

    goaccess -f /var/log/nginx/site1-access.log -a -o /var/www/goaccess.mydomain.com/site.html.html --real-time-html --ws-url=goaccess.mydomain.com
    

我已经让他们在他们的文档中记下了https问题，因为这让我在圈子里玩了很长时间。

答案 2 :(得分：0)

要通过TLS / SSL连接输出实时数据，您需要使用`--ssl-cert=<cert.crt>`和`--ssl-key=<priv.key>`。

为我工作：）

    Created at: 2020-09-18T11:19:12+08:00
    Updated at: 2020-09-18T11:19:12+08:00



### **_1_**|**_0_****docker部署neo4j**

环境：ubuntu16.04LTS

#### **_1_**|**_1_****docker安装**

详见：[菜鸟教程(docker安装)](https://www.runoob.com/docker/ubuntu-docker-install.html)

#### **_1_**|**_2_****docker国内镜像源配置**

第一步，进入[阿里云](https://cr.console.aliyun.com/)，登陆后点击左侧的镜像加速，生成自己的镜像加速地址。

[![[./_resources/docker安装部署neo4j_-_打瞌睡的布偶猫_-_博客园.resources/o_200903121433-25E9-2598-25BF-25E9-258C-25E4-25BA-.png]]](https://images.cnblogs.com/cnblogs_com/caoyusang/1840849/o_200903121433%E9%98%BF%E9%87%8C%E4%BA%91%E9%95%9C%E5%83%8F%E5%8A%A0%E9%80%9F%E5%9C%B0%E5%9D%80%E7%94%9F%E6%88%90.png)

第二步，选择ubuntu，执行阿里云推荐的终端命令，即可更新docker的镜像源为阿里云镜像。

#### **_1_**|**_3_****docker部署neo4j**

##### **_1_**|**_0_****拉取neo4j镜像**

第一步，从镜像源中找合适的镜像

docker search neo4j 

[![[./_resources/docker安装部署neo4j_-_打瞌睡的布偶猫_-_博客园.resources/o_200903121424neo4镜像.png]]](https://images.cnblogs.com/cnblogs_com/caoyusang/1840849/o_200903121424neo4%E9%95%9C%E5%83%8F.png)

第二步，拉取镜像源

docker pull neo4j(:版本号) //缺省 “:版本号” 时默认安装latest版本的 

第三步，查看本地镜像，检验是否拉取成功

docker images 

[![[./_resources/docker安装部署neo4j_-_打瞌睡的布偶猫_-_博客园.resources/o_200903121450本地镜像.png]]](https://images.cnblogs.com/cnblogs_com/caoyusang/1840849/o_200903121450%E6%9C%AC%E5%9C%B0%E9%95%9C%E5%83%8F.png)

##### **_1_**|**_0_****构建neo4j容器**

第一步，在你根目录的任意一个子目录（我这里是/home)下建立四个基本的文件夹

*   data——数据存放的文件夹
*   logs——运行的日志文件夹
*   conf——数据库配置文件夹（在配置文件**neo4j.conf**中配置包括开放远程连接、设置默认激活的数据库）
*   import——为了大批量导入csv来构建数据库，需要导入的节点文件**nodes.csv**和关系文件**rel.csv**需要放到这个文件夹下）

docker run -d --name container\_name \\  //-d表示容器后台运行 --name指定容器名字
	-p 7474:7474 -p 7687:7687 \\  //映射容器的端口号到宿主机的端口号
	-v /home/neo4j/data:/data \\  //把容器内的数据目录挂载到宿主机的对应目录下
	-v /home/neo4j/logs:/logs \\  //挂载日志目录
	-v /home/neo4j/conf:/var/lib/neo4j/conf   //挂载配置目录
	-v /home/neo4j/import:/var/lib/neo4j/import \\  //挂载数据导入目录
	--env NEO4J\_AUTH=neo4j/password \\  //设定数据库的名字的访问密码
	neo4j //指定使用的镜像 

一个可以直接复制粘贴到终端执行的代码模板

docker run -d --name container\_name -p 7474:7474 -p 7687:7687 -v /home/neo4j/data:/data -v /home/neo4j/logs:/logs -v /home/neo4j/conf:/var/lib/neo4j/conf -v /home/neo4j/import:/var/lib/neo4j/import --env NEO4J\_AUTH=neo4j/password neo4j 

其中**container\_name**可以自己指定，挂载在根目录下的子目录可以根据你自己的实际情况进行替换，我这里是**/home**。另外**NEO4J\_AUTH**也是你自己来进行设置。

执行完上述命令后就在后台把neo4j容器启动起来了，这个时候你就能在宿主机的浏览器中输入

localhost:7474 

输入用户名和密码就能登录到数据库了。

[![[./_resources/docker安装部署neo4j_-_打瞌睡的布偶猫_-_博客园.resources/o_200903121405neo4j界面.png]]](https://images.cnblogs.com/cnblogs_com/caoyusang/1840849/o_200903121405neo4j%E7%95%8C%E9%9D%A2.png)

##### **_1_**|**_0_****neo4j配置**

上述方式启动的neo4j是按照默认的配置进行启动的，而默认的数据库配置是不允许远程登陆的，这样对于在服务器上使用docker搭载neo4j的同学来说，就很不方便了。所以我们对默认配置进行一些改变，改变如下：

// 进入容器配置目录挂载在宿主机的对应目录，我这里是/home/neo4j/conf
cd /home/neo4j/conf

// vim编辑器打开neo4j.conf
vim neo4j.conf

// 进行以下更改
//在文件配置末尾添加这一行
dbms.connectors.default\_listen\_address=0.0.0.0  //指定连接器的默认监听ip为0.0.0.0，即允许任何ip连接到数据库

//修改
dbms.connector.bolt.listen\_address=0.0.0.0:7687  //取消注释并把对bolt请求的监听“地址:端口”改为“0.0.0.0:7687”
dbms.connector.http.listen\_address=0.0.0.0:7474  //取消注释并把对http请求的监听“地址:端口”改为“0.0.0.0:7474” 

保存后退出，重启neo4j容器，可以使用容器的省略id或者生成容器时指定的容器名进行重启。

docker restart 容器id（或者容器名） 

**防火墙设置**

// 查看当前防火墙状态，若为“inactive”，则防火墙已关闭，不必进行接续操作。
sudo ufw status

// 若防火墙状态为“active”，则使用下列命令开放端口
sudo ufw allow 7474
sudo ufw allow 7687

// 重启防火墙
sudo ufw reload 

#### **_1_**|**_4_****neo4j数据导入**

neo4j数据的批量导入方法

[![[./_resources/docker安装部署neo4j_-_打瞌睡的布偶猫_-_博客园.resources/o_200903121942导入方法.png]]](https://images.cnblogs.com/cnblogs_com/caoyusang/1840849/o_200903121942%E5%AF%BC%E5%85%A5%E6%96%B9%E6%B3%95.png)

为了加快速度，使用官方的**Neo4j-import**进行导入

// 数据准备
清空data/databases/graph.db文件夹(如果有),将清洗好的结点文件nodes.csv和关系文件rel.csv拷贝到宿主机/home/neo4j/import中

// docker以exec方式进入容器的交互式终端
docker exec -it container\_name(or container\_id) /bin/bash

// 停掉neo4j
bin/neo4j stop

//使用如下命令导入
bin/neo4j-admin import \\
	--database=graph.db \\	        //指定导入的数据库，没有系统则会在data/databases下自动创建一个
	--nodes ./import/nodes.csv 		//指定导入的节点文件位置
	--relationships ./import/rel.csv //指定导入的关系文件位置
	--skip-duplicate-nodes=true 	//设置重复节点自动过滤
	--skip-bad-relationships=true 	//设置bad关系自动过滤
	
//可执行一行式终端命令
bin/neo4j-admin import --database=graph.db --nodes ./import/nodes.csv --relationships ./import/rel.csv --skip-duplicate-nodes=true --skip-bad-relationships=true

// 容器内启动neo4j
bin/neo4j start

// 退出交互式终端但是保证neo4j后台继续运行
ctrl + P + Q

//保险起见，重启neo4j容器
docker restart container\_name(or container\_id) 

重启后使用另一台主机向服务器发送http请求进行远程登陆，在浏览器中输入

服务器ip:7474 

**切换连接模式**为 **bolt:/** ，输入用户名和密码进行登陆，登陆成功发现在数据库一栏没找到新导入的数据库**graph.db**

这是因为配置不够全，继续进到容器挂载到宿主机的**/home/neo4j/conf**中对**neo4j.conf**进行配置

//在文件末尾添加默认的数据库
dbms.active\_database=graph.db

// 保存后重启容器
docker restart container\_name(or container\_id) 

重新进行远程连接，此时数据库的默认选择应该就切换到了新导入的graph.db。

#### **_1_**|**_5_****数据清洗**

数据如何清洗成两个符合neo4j-import导入格式的csv文件？

*   [ownthink\_kg 1.4亿数据快速导入Neo4j](https://blog.csdn.net/muruibin88/article/details/106475757)
*   [GO语言编写的开源数据清洗工具](https://github.com/jievince/rdf-converter)

\_\_EOF\_\_

![[./_resources/docker安装部署neo4j_-_打瞌睡的布偶猫_-_博客园.resources/o_200817123614u=2302432267,1866658433&fm=15&gp=0.jpg]]
本文作者：**[打瞌睡的布偶猫](https://www.cnblogs.com/caoyusang/p/13610408.html)**
本文链接：<https://www.cnblogs.com/caoyusang/p/13610408.html>
关于博主：评论和私信会在第一时间回复。或者[直接私信](https://msg.cnblogs.com/msg/send/caoyusang)我。
版权声明：本博客所有文章除特别声明外，均采用 [BY-NC-SA](https://creativecommons.org/licenses/by-nc-nd/4.0/) 许可协议。转载请注明出处！
声援博主：如果您觉得文章对您有帮助，可以点击文章右下角**【[[# | 推荐]]】**一下。您的鼓励是博主的最大动力！

标签: [neo4j](https://www.cnblogs.com/caoyusang/tag/neo4j/), [docker](https://www.cnblogs.com/caoyusang/tag/docker/)

[[# | 好文要顶]] [[# | 关注我]] [[# | 收藏该文]] [[# | ![[./_resources/docker安装部署neo4j_-_打瞌睡的布偶猫_-_博客园.resources/icon_weibo_24.png]]]] [[# | ![[./_resources/docker安装部署neo4j_-_打瞌睡的布偶猫_-_博客园.resources/wechat.png]]]]

[![[./_resources/docker安装部署neo4j_-_打瞌睡的布偶猫_-_博客园.resources/20200817143536.png]]](https://home.cnblogs.com/u/caoyusang/)
[打瞌睡的布偶猫](https://home.cnblogs.com/u/caoyusang/)
[关注 - 2](https://home.cnblogs.com/u/caoyusang/followees/)
[粉丝 - 6](https://home.cnblogs.com/u/caoyusang/followers/)

[[# | +加关注]]

0
0

[«](https://www.cnblogs.com/caoyusang/p/13590705.html) 上一篇： [《Connecting the Dots: A Knowledgeable Path Generator for Commonsense Question Answering》一文的理解和总结](https://www.cnblogs.com/caoyusang/p/13590705.html)
[»](https://www.cnblogs.com/caoyusang/p/13636649.html) 下一篇： [B站弹幕爬取](https://www.cnblogs.com/caoyusang/p/13636649.html)

posted @ 2020-09-03 20:22  [打瞌睡的布偶猫](https://www.cnblogs.com/caoyusang/)  阅读(2180)  评论(2)  [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=13610408)  [[# | 收藏]]

    Created at: 2021-01-28T15:38:52+08:00
    Updated at: 2021-01-28T15:38:52+08:00


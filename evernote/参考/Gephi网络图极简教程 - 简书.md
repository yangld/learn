
# Gephi网络图极简教程

[![[./_resources/Gephi网络图极简教程_-_简书.resources/webp.11.webp]]](https://www.jianshu.com/u/06ae70ef31bc)

[周运来就是我](https://www.jianshu.com/u/06ae70ef31bc)[![[./_resources/Gephi网络图极简教程_-_简书.resources/d43a4246-2cc1-449d-b3a3-744924739655.png]]](https://www.jianshu.com/p/1df56761b055)
_![[./_resources/Gephi网络图极简教程_-_简书.resources/embedded.svg]]_42018.05.30 17:17:54字数 2,554阅读 84,825

![[./_resources/Gephi网络图极简教程_-_简书.resources/webp.8.webp]]

HelloWorld

###### 网络分析背景知识

1.  **图是一种数据结构**

图结构：是研究数据元素之间的**多对多**的关系。在这种结构中，任意两个元素之间可能存在关系。即结点之间的关系可以是任意的，图中任意元素之间都可能相关。

基于图论(Graph theory)的网络科学认为，**任何非连续事物之间的关系都可以用网络来表示**，通过将互联网内的电脑、社会关系中的个人、生物的基因等不同属性的实体抽象为节点(Node)，并用连接(Link)来展示实体之间的关系，通过量化以节点和连接为组件的网络结构指数(Index)，从而能够在统一的框架下寻找复杂系统的共性。

网络关系图（network analysis）是一款比较火的分析，最近频繁出现在微生物生态研究的各大论文里。其实单纯看网络关系的话，只是一种数据分析的手段，很早就应用在其他领域。然而到了2006年，Proulx等科学家在TRENDS ECOL EVOL（IF=16.74）发文，提出网络关系也可以作为一种分析手段应用在生态领域（Proulx et al. 2006）。到了2012年，Barberán等科学家在ISME发文，通过构建土壤中微生物的网络关系来研究其共生模式（Barberán et al. 2012）。

目前生态学领域大家用到的网络图多为基于群落数据相关性构建的Co-occurrence网络图。此类网络可以采用R中igraph包、Python 中的Networkx构建并实现出图。当然，除此之外，还有一些非命令行的软件，例如cytoscape，gephi，pajek，graphviz(dot)，Ucinet等。

其中 Gephi 是开源免费跨平台基于JVM的复杂网络分析软件, 其主要用于各种网络和复杂系统，因它简单、易学、出图美观而备受青睐。当你打开网络图的大门，第一个映入眼帘的可能就是它，适合入门，被誉为Networker的初恋\[扯\]。

*   节点与边
*   无向图和有向图
*   Co-occurrence网络图与 相关性网络图 （两个矩阵的相关性）
*   权：图中的边或弧上有附加的数量信息，这种可反映边或弧的某种特征的数据成为权。
*   网：图上的边或弧带权则称为网。可分为有向网和无向网。
*   度：在无向图中，与顶点v关联的边的条数成为顶点v的度。有向图中，则以顶点v为弧尾的弧的条数成为顶点v的出度，以顶点v为弧头的弧的条数成为顶点v的入度，而顶点v的度=出度+入度。图中各点度数之和是边（或弧）的条数的2倍。

*   节点数（Nodes）： 节点的个数。
*   边数（Edges）：边或连接的个数。
*   平均度（Average degree）： 表示每个节点连接边的平均数，如果络图是无向图，平均度的计算为 2\*edges/nodes。
*   平均路径长度（Average network distance）： 任意两个节点之间的距离的平均值。 反映网络中各个节点间的分离程度。 值越小代表网络中节点的连接度越大。
*   模块化指数（Modularity index）： 衡量了网络图结构的模块化程度。一般>0.44 就说明该网络图达到了一定的模块化程度 。
*   聚类系数（Clustering coefficient）： 和平均路径长度一起，能够展示所谓的‘小世界’效应，从而给出一些节点聚类或抱团的总体迹象。网络的小世界特性指网络节点的平均路径小。
*   网络直径（Diameter）： 网络图直径最大测量长度，即任意两点都有 1 个最短距离，这些最短距离之中的最大值即为该网络图直径。

###### Gephi 实现网络图绘制

1.  **Gephi 安装**
    下文Gephi官网安装（我略，你不能略）

![[./_resources/Gephi网络图极简教程_-_简书.resources/webp.15.webp]]

边文件

![[./_resources/Gephi网络图极简教程_-_简书.resources/webp.12.webp]]

节点文件

*   3.**导入数据**

当然你要打开Gephi。【文件】→【打开】选择文件，在点击下一步的同时注意一下每个参数的含义是不是你要表达的意思。分别导入节点文件与边文件。

![[./_resources/Gephi网络图极简教程_-_简书.resources/webp.1.webp]]

导入数据

输入第二个文件时 注意：

![[./_resources/Gephi网络图极简教程_-_简书.resources/webp.16.webp]]

导入数据

4.  **设置布局样式**

Gephi提供多种布局方式，一般圆形网络图选择”Fruchterman Reingold”布局格式。点击【运行】，等布局稳定后，点击 【停止】，生成圆形布局的网络图。

![[./_resources/Gephi网络图极简教程_-_简书.resources/webp.14.webp]]

布局调整

5.  **网络拓扑参数计算**
    点击【窗口-统计】面板，分别点击 【运行】-【关闭】当然你也可以选择打印、复制，保存，最终你还是要选择关闭。进行以下6个拓扑参数的计算:平均度、网络直径、图密度、模块化、平均聚类系数、平均路径长度。
    注：对于无向网络图，平均度和平均加权度 数值相同。再次注意：可能会卡。

![[./_resources/Gephi网络图极简教程_-_简书.resources/webp.7.webp]]

拓扑参数计算

6.  **节点设定**
    点击【窗口】-【外观】-【节点】-大小-数值设定，选择渲染方式为 **度**，设置节点大小的 最大尺寸和最小尺寸（此处分别为20和70），点击 **应用**。颜色设置也在外观节点中，设置渲染方式为Modularity Class注意红色方框里内容，从左到右依次为：颜色、大小，标签颜色、标签尺寸。

![[./_resources/Gephi网络图极简教程_-_简书.resources/webp.2.webp]]

节点设置

7.  **边设定**
    在【外观】中选择【边】Partition 渲染方式选择pn即我们数据中相关性标签；Ranking选择【度】。如下：

![[./_resources/Gephi网络图极简教程_-_简书.resources/webp.3.webp]]

边设置

8.  **预览修饰**

点击预览，修改如下图红色方框选项，在 预览设置 面板对网络图进行输出前的最后修饰。

*   边框宽度：设为0.0，不显示节点边框。
*   显示标签：打勾，显示节点标签。
*   字体：此处修改为 Times New Roman 23号 加粗
*   缩短标签：打勾，不然标签会过长导致相互覆盖。
*   厚度：根据显示需要修改边线厚度，此处改为5。
*   重新调整权重：打勾，根据边线权重显示不同厚度。

另外的选项可根据需要自行调整。在之前的设置中也可以通过预览来查看效果，一步一步调整。

![[./_resources/Gephi网络图极简教程_-_简书.resources/webp.5.webp]]

效果图

9.  **图像导出**

Gephi 支持多种格式的输出：SVG、PNG、PDF、gexf图文件等。

![[./_resources/Gephi网络图极简教程_-_简书.resources/webp.webp]]

导出格式

* * *

1.  节点：相同颜色是同一个门；节点大小表示连接度；
2.  边：红色正相关，蓝色负相关（spearman），粗细表示相关系数绝对值大小；

* * *

导出的矢量图可用AI等图形编辑软件进一步修改，图形文件也可以用脚本来处理，图个性化地添加图例等。图文件也是一种标签语言。

让大家见识一下，开头HelloWorld的代码：

    <?xml version="1.0" encoding="UTF-8"?>
    <gexf xmlns="http://www.gexf.net/1.3" version="1.3" xmlns:viz="http://www.gexf.net/1.3/viz" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.gexf.net/1.3 http://www.gexf.net/1.3/gexf.xsd">
      <meta lastmodifieddate="2018-05-30">
        <creator>Gephi 0.9</creator>
        <description></description>
      </meta>
      <graph defaultedgetype="directed" mode="static">
        <nodes>
          <node id="0" label="Hello">
            <viz:size value="10.0"></viz:size>
            <viz:position x="-157.09903" y="-64.66471"></viz:position>
            <viz:color r="251" g="9" b="9"></viz:color>
          </node>
          <node id="1" label="World">
            <viz:size value="10.0"></viz:size>
            <viz:position x="157.09904" y="64.66471"></viz:position>
            <viz:color r="10" g="194" b="245"></viz:color>
          </node>
        </nodes>
        <edges>
          <edge id="0" source="0" target="1">
            <viz:color r="0" g="109" b="44"></viz:color>
          </edge>
        </edges>
      </graph>
    </gexf>
    1234567891011121314151617181920212223242526

GEXF (Graph Exchange XML Format) 是一种描述复杂网络的语言，包括复杂网络的结构，数据等等。最初是由Gephi项目2007年确立。生成gexf需要用到布局算法, 常见的有 [Force-directed\_graph\_drawing](https://links.jianshu.com/go?to=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FForce-directed_graph_drawing) 力导向算法, `算法的核心思想是节点之间产生斥力,边给两个节点提供拉力,通过多次迭代最后维持一个稳定状态`，手动实现布局算法还是有一些复杂度的,好在gephi-tookit组件提供了API来处理数据, 首先在maven项目中加入gephi的仓库和依赖。

一个花的例子：[How Programmers Relate based on Google Searches](https://links.jianshu.com/go?to=https%3A%2F%2Fexploring-data.com%2Fvis%2Fprogrammers-search-relations%2F)

![[./_resources/Gephi网络图极简教程_-_简书.resources/webp.9.webp]]

How Programmers Relate

###### 难点在哪？

1.  现有的数据到Gephi需要的数据格式。
2.  布局与配色
3.  Gephi 没有生成图例

> 参考：

[gephi 中文教程|视频](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.udemy.com%2Fgephi%2Flearn%2Fv4%2Foverview)
[gephi 官网](https://links.jianshu.com/go?to=https%3A%2F%2Fgephi.org%2F)
[Co-occurrence网络图在R中的实现](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Fwoodcorpse%2Farticle%2Fdetails%2F78737867)
[从《你的名字》学做“网络关系图”——Gephi篇](https://links.jianshu.com/go?to=http%3A%2F%2Fwww.360doc.com%2Fshowweb%2F0%2F0%2F758198547.aspx)
[R||Network](https://links.jianshu.com/go?to=http%3A%2F%2Fkateto.net%2Fnetwork-visualization)
[Python · Networkx](https://links.jianshu.com/go?to=http%3A%2F%2Fnetworkx.github.io%2F)
[GEXF File Format](https://links.jianshu.com/go?to=https%3A%2F%2Fgephi.org%2Fgexf%2Fformat%2Findex.html)
[模块度Q——复杂网络社区划分评价标准](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Fwangyibo0201%2Farticle%2Fdetails%2F52048248)
[如何将枯燥的大数据呈现为可视化的图和动画？](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.zhihu.com%2Fquestion%2F23416938)
[学习新技术时你应当掌握的『最少必要知识』](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Fsjdl9396%2Farticle%2Fdetails%2F78651243)
Revelle, W. & Revelle, M. W. Package ‘psych’. The Comprehensive R Archive Network (2015).
Bastian, M., Heymann, S. & Jacomy, M. Gephi: an open source software for exploring andmanipulating networks. Icwsm 8, 361-362 (2009).
Newman, M. E. Modularity and community structure in networks. Proceedings of the national academy of sciences 103, 8577-8582 (2006).
Barberan, A., Bates, S. T., Casamayor, E. O. & Fierer, N. Using network analysis to explore cooccurrence patterns in soil microbial communities. The ISME journal 6, 343-351,doi:10.1038/ismej.2011.119 (2012）
[Gephi安装好 JAVA变量也装好，但出现 can't find java1.8 or higer错误](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Ffuy1990%2Farticle%2Fdetails%2F82141668)
[http://forum-gephi.org/viewtopic.php?t=1987](https://links.jianshu.com/go?to=http%3A%2F%2Fforum-gephi.org%2Fviewtopic.php%3Ft%3D1987) # 模块度小于零

![[./_resources/Gephi网络图极简教程_-_简书.resources/webp.6.webp]]

¥70.40(8.92折)

您看本文值多少钱↓↓↓↓↓↓↓↓↓↓↓↓↓↓

_![[./_resources/Gephi网络图极简教程_-_简书.resources/embedded.1.svg]]_
69人点赞_![[./_resources/Gephi网络图极简教程_-_简书.resources/embedded.2.svg]]_

_![[./_resources/Gephi网络图极简教程_-_简书.resources/embedded.3.svg]]_

[_![[./_resources/Gephi网络图极简教程_-_简书.resources/embedded.4.svg]]_网页设计](https://www.jianshu.com/nb/19343987)

_![[./_resources/Gephi网络图极简教程_-_简书.resources/embedded.5.svg]]_

更多精彩内容下载简书APP
![[./_resources/Gephi网络图极简教程_-_简书.resources/unknown_filename.png]]
"Free for You"
[![[./_resources/Gephi网络图极简教程_-_简书.resources/webp.13.webp]]](https://www.jianshu.com/u/b6efbd400412)[![[./_resources/Gephi网络图极简教程_-_简书.resources/webp.4.webp]]](https://www.jianshu.com/u/24b59a79d6bd)共2人赞赏

[![[./_resources/Gephi网络图极简教程_-_简书.resources/webp.10.webp]]](https://www.jianshu.com/u/06ae70ef31bc)

[周运来就是我](https://www.jianshu.com/u/06ae70ef31bc)[![[./_resources/Gephi网络图极简教程_-_简书.resources/d43a4246-2cc1-449d-b3a3-744924739655.png]]](https://www.jianshu.com/p/1df56761b055)周运来，男，长大了才会遇到的帅哥，稳健，潇洒，大方，靠谱。一段生信缘，一棵技能树。生信技能树核...
总资产491 (约22.69元)共写了111.5W字获得4,960个赞共4,162个粉丝

    Created at: 2021-01-28T11:50:55+08:00
    Updated at: 2021-01-28T11:50:55+08:00


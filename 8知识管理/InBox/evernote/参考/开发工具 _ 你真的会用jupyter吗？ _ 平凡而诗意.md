
# 开发工具 | 你真的会用jupyter吗？

__ 发表于 2019-09-14 | __ 分类于 [开发工具](https://jackpopc.github.io/categories/%E5%BC%80%E5%8F%91%E5%B7%A5%E5%85%B7/) | __ [0](https://jackpopc.github.io/2019/09/14/jupyter/#comments) | __ 浏览 410次

# <https://jackpopc.github.io/2019/09/14/jupyter/#%E5%89%8D%E8%A8%80>前言

[![[nfW7c9.jpg]]](https://s2.ax1x.com/2019/09/16/nfW7c9.jpg)

提起jupyter notebook，应该很多学习过Python的同学都不模型。虽然用jupyter notebook的同学相对较少，但是提及这款开发工具，很多人都会赞不绝口，“jupyter很强大，交互式、富文本”，很多人都知道jupyter notebook的这几个优点，但是，试问一下，你真的会用jupyter吗？

以Python开发为例，我们只需要在windows命令行或者linux/Mac终端输入“jupyter notebook”或者“ipython notebook”即可使用默认浏览器打开一个在线IDE，

[![[uh2NDO.png]]](https://s2.ax1x.com/2019/10/08/uh2NDO.png)

首先说一下交互式，

jupyter notebook中一个非常重要的概念就是cell，每个cell能够单独进行运算，这样适合于代码调试。我们开发一个完整的脚本时变量会随着代码执行的结束而从内存中释放，如果我们想看中间的变量或者结构，我们只能通过断点或者输出日志信息的方式进行调试，这样无疑是非常繁琐的，如果一个程序运行很多这种方式还可行，如果运行时间长达几个小时，这样我们调试一圈耗费的时间就太长了。

而在jupyter notebook中我们可以把代码分隔到不同的cell里逐个进行调试，这样它会持续化变量的值，我们可以交互式的在不同cell里获取到我们想要测试的变量值和类型。

[![[uh2UbD.png]]](https://s2.ax1x.com/2019/10/08/uh2UbD.png)

然后说一下富文本，

开发代码不仅是给机器去“阅读”，也需要让其他的同事、同学能够很容易的阅读，因此，注释就在开发过程中变的非常重要，一个完善的注释能够让周围人更加容易理解，协作效率也更高，避免重复性劳动。在大多数IDE中都可以进行注释，但是几乎都是相同的，只支持一些简单的文本格式注释，这显然是不够的，jupyter notebook支持Markdown编辑，它的cell不仅可以用于编码，还可以用于书写文本，Markdown可以轻松完成标题、数学公式等格式的编辑，更加有助于解释代码，适用于教学等场景。

最后在说一下轻量、触手可及，

开发过程中我经常需要测试一个小的代码块或者函数，这时候有两个选择：在IDE中新建一个测试脚本；打开命令行下的Python。我觉的这两个都不是好的选择，如果在项目下新建一个脚本后续还需要记住把它清理掉，如果写一个完善的测试脚本用于Alpha、beta测试这显然是低效不现实的。而选择在命令行下，界面不友好，操作不灵活，体验更差。

这时候就显现出jupyter notebook的优势，只需要输入jupyter notebook就会在流量器中打开一个网页，能轻量、快捷的进行开发验证，效率很好。此外，我们还可以通过搭建jupyter notebook服务使得它一直在服务器下运行来避免每次需要时都要在命令行下重复打开，我们只需要在浏览器打开对应的网页即可，这一点下文会详细介绍。

其实，除了这些我们耳熟能详的优点之外，jupyter还有很多令人惊叹的亮点：

*   丰富的插件
*   主题修改
*   多语言支持

下面就针对这3点分别介绍一下，介绍下面3个功能的前提条件是已经通过下方命令成功安装jupyter notebook，

|     |     |
| --- | --- |
| 1   | $ pip install jupyter notebook |

# <https://jackpopc.github.io/2019/09/14/jupyter/#%E4%B8%B0%E5%AF%8C%E7%9A%84%E6%8F%92%E4%BB%B6>丰富的插件

**安装插件管理器**

如果没有安装插件管理器，打开jupyter notebook后菜单栏只有如下3项，

*   Files
*   Running
*   Clusters

我们需要安装插件管理器来管理我们需要的插件，

第一步：用pip安装插件管理包，

|     |     |
| --- | --- |
| 1<br>2 | $ pip install jupyter\_contrib\_nbextensions<br>$ pip install jupyter\_nbextensions\_configurator |

第二步：安装一些插件并启用插件管理器，

|     |     |
| --- | --- |
| 1<br>2 | $ jupyter nbextensions\_configurator install --user<br>$ jupyter nbextensions\_configurator enable --user |

然后再次打开jupyter notebook会发现菜单栏多了一个选项**Nbextensions**,

[![[nffsUK.png]]](https://s2.ax1x.com/2019/09/16/nffsUK.png)

记得勾选disable configuration for nbextensions without explicit compatibility (they may break your notebook environment, but can be useful to show for nbextension development)，否则下方插件是不可选状态。

我们可以通过命令来管理开启或关闭某个插件，但是我觉得还是通过直接勾选我们需要的插件效率更高。

**选择插件**

我们从上面可以看出，jupyter notebook有很多插件，我们该用哪一个呢？我推荐5款个人认为不错的插件。

*   **Table of Contents**
*   **Execute Time**
*   **Nofity**
*   **Codefolding**
*   **Hinterland**

下面分别介绍一下它们的功能，

[![[nffhDI.png]]](https://s2.ax1x.com/2019/09/16/nffhDI.png)

**Table of Contents**是一款自动生成目录的工具，它能够通过我们我们富文本中定义的标题自动生成目录，这样我们能够通过点击左侧目录快速定位到我们想要的到达的代码片段。

[![[nffXKs.png]]](https://s2.ax1x.com/2019/09/16/nffXKs.png)

**Execute Time**顾名思义，执行时间，我觉得这是一款非常实用的插件，在企业项目开发中，效率是永远无法越过的一个门槛，和学术上理论效果足够优秀即可不同，在企业项目中对效率要求也很高，因此，我们需要统计代码的运行时间，其中最初级的用法就是在每个函数开始和结尾处写一个计时语句，这样比较繁琐。然后再高阶一些的用法就是通过装饰器写一些计时器，在每个函数上调用这个装饰器。其实，如果用jupyter notebook完全没必要这么麻烦。我们只需要打开**Execute Time**，它就能统计每个cell的运行耗费时间，结束时间等，非常详细，一目了然。

[![[nfhGqI.png]]](https://s2.ax1x.com/2019/09/16/nfhGqI.png)

**Nofity**同样是一款非常实用的插件，当我们运行一个耗时较长的代码时，我们不可能一直盯着屏幕等待，但是我们又希望及时知道它运行结束了，Notify这款插件就可以实现这个功能，它能够在代码运行结束时发出通知，及时告知你代码运行结束了。

[![[nfhNIf.png]]](https://s2.ax1x.com/2019/09/16/nfhNIf.png)

**Codefolding**是一款代码折叠工具，有时候我们写的一个函数非常长，但是我们又不关注 ，这样在阅读过程中会使得效率很低，代码折叠就是一个不错的选择，折叠我们不关注的代码块，**Codefolding**能够像其他IDE那样让你轻松自如的折叠代码块。

[![[nfhHdx.gif]]](https://s2.ax1x.com/2019/09/16/nfhHdx.gif)

**Hinterland**是一款自动补全插件，称一个IDE“优秀”，如果没有自动补全显然是说不过去的。jupyter notebook自带补全功能，但是每次都需要点击**tab**键来补全，这样效率比较低，我们可以通过勾选**Hinterland**让jupyter notebook具备自动补全功能，当我们输入几个包含字母后它能够快速补全我们想要的函数，补全速度堪比pycharm。

# <https://jackpopc.github.io/2019/09/14/jupyter/#%E4%B8%BB%E9%A2%98%E4%BF%AE%E6%94%B9>主题修改

很多同学使用jupyter notebook都会觉得，这款开发工具界面太单调了，只有纯白色的主题，其实并不是这样，jupyter notebook也支持主题修改，而且非常方便。

首先在命令行下输入下面命令安装主题，

|     |     |
| --- | --- |
| 1   | $ pip install jupyterthemes |

jupyter notebook的主题管理工具叫做**jt**，我们可以通过下面命令查看可用主题，

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11 | $ jt -l<br>Available Themes:<br> chesterish<br> grade3<br> gruvboxd<br> gruvboxl<br> monokai<br> oceans16<br> onedork<br> solarizedd<br> solarizedl |

然后通过下面命令设置主题，

|     |     |
| --- | --- |
| 1   | $ jt -t <theme\_name> |

其中theme\_name为主题名称。

[![[nf4FFf.png]]](https://s2.ax1x.com/2019/09/16/nf4FFf.png)

如果觉得不满意，想退回默认主题，可以通过下方命令实现，

|     |     |
| --- | --- |
| 1   | $ jt -r |

# <https://jackpopc.github.io/2019/09/14/jupyter/#%E5%A4%9A%E8%AF%AD%E8%A8%80%E6%94%AF%E6%8C%81>多语言支持

很多同学是因为Python而解除到jupyter notebook的，因此会认为这就是一款Python专属的开发工具，如果这样的话，那么也不足以我专门用一篇文章来介绍这款开发工具。

它更像是eclipse、IDEA、vscode，是一款综合的开发工具，它不仅支持Python，还支持C++、julia、R、ruby、Go、Scala、C#、Perl、PHP、Octave、Matlab、Lua、Tcl、等多种编程语言，功能十分强大，支持语言详情，请查看下方链接，

<https://github.com/jupyter/jupyter/wiki/Jupyter-kernels>

不同语言的配置方式各不相同，这里不再一一介绍，可以根据自己需要的语言自行在网上搜索相关配置资料进行配置。

# <https://jackpopc.github.io/2019/09/14/jupyter/#jupyter-notebook%E6%9C%8D%E5%8A%A1>jupyter notebook服务

如果非要找出使用jupyter notebook的缺点，我认为就是每次启动的时候相对繁琐，我们启动本地安装的IDE，一个命令或者点击一下图标即可，但是如果启动jupyter notebook就需要进入命令行或终端，输入“jupyter notebook”进行打开，如果使用的是虚拟环境，首先还要激活虚拟环境，这无疑是非常繁琐的，而且启动后它会占用一个终端或命令行窗口，如果意外关闭则会终止jupyter notebook服务。其实，这也是有解决方法的，我们搭建一个持续化的jupyter notebook服务，让它一直在服务器后台运行，这样既不占用窗口，也不需要繁琐的打开步骤，我们只需要把对应的URL收藏，每次需要时能够秒级速度打开，下面就来介绍一下jupyter notebook的搭建步骤。

**第一步：获取sha1密码**

在命令行下输入ipython，

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5 | In \[1\]: from IPython.lib import passwd<br>In \[2\]: passwd()<br>Enter password:<br>Verify password:<br>Out\[2\]: 'sha1:746cf729d33f:0af9cda409de9791f237a6c46c3c76a3237962fc' |

导入passwd函数，调用后会让你输入密码，你可以设置一个明文密码，例如123，然后它会生成一个sha1密码串，这个很重要，后面会用到。

修改jupyter配置文件，linux系统配置文件路径为**~/.jupyter/jupyter\_notebook\_config.py**，windows系统配置文件路径为**C:\\\\Users\\\\User\\.jupyter\\\\jupyter\_notebook\_config.py**，如果没有这个文件，可以使用下面命令生成，

|     |     |
| --- | --- |
| 1   | $ jupyter notebook --generate-config |

这个配置文件很长，以linux为例，主要关注的是如下几项，

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5 | c.NotebookApp.ip = '\*' <br>c.NotebookApp.password = u'sha1:xxx:xxx' <br>c.NotebookApp.open\_browser = False <br>c.NotebookApp.port = 8888<br>c.NotebookApp.enable\_mathjax = True |

**c.NotebookApp.ip**、**c.NotebookApp.port**，ip要和服务器保持一致，端口可以自行设定，不和其他端口冲突即可，后续访问时在浏览器输入**ip:port**即可。

**c.NotebookApp.password**就是前面生成的sha1密码串，复制过来即可。

**c.NotebookApp.open\_browser = False** 的含义为是每次启动命令时是否打开浏览器，由于我们用的时候直接输入URL即可，所以这里不需要打开浏览器。

**c.NotebookApp.enable\_mathjax**的含义为是否用mathjax，它是一种用于数学公式显示的工具，这里选True。

配置好这几项之后保存退出，输入下面命令即可启动，

|     |     |
| --- | --- |
| 1   | $ nohup jupyter notebook > /dev/null 2>&1 & |

nohup的含义是后台运行，这样就不用占用一个窗口来了。

配置好之后只要服务器不关机，jupyter notebook的服务会一直处于运行状态，我们随时可以使用，只需要打开**ip:port**即可。

[\# 工具](https://jackpopc.github.io/tags/%E5%B7%A5%E5%85%B7/) [\# 实用](https://jackpopc.github.io/tags/%E5%AE%9E%E7%94%A8/) [\# 插件](https://jackpopc.github.io/tags/%E6%8F%92%E4%BB%B6/) [\# 开发工具](https://jackpopc.github.io/tags/%E5%BC%80%E5%8F%91%E5%B7%A5%E5%85%B7/)

[__ 【动手学计算机视觉】第十五讲：卷积神经网络之LeNet](https://jackpopc.github.io/2019/09/13/lenet/)
[通用技术 | 正则表达式 __](https://jackpopc.github.io/2019/09/21/regex/)

    Created at: 2021-02-08T11:27:00+08:00
    Updated at: 2021-02-08T11:27:00+08:00


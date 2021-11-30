
# 使用Postman循环调用接口

[![[./_resources/使用Postman循环调用接口_-_简书.resources/3-9a2bcc21a5d89e21dafc73b39dc5f582.jpg]]](https://www.jianshu.com/u/306e28e58ace)

[有巨大福的长颈鹿](https://www.jianshu.com/u/306e28e58ace)
_![[./_resources/使用Postman循环调用接口_-_简书.resources/embedded.svg]]_0.0582019.06.13 20:48:07字数 300阅读 1,835

    今天遇到个问题，需要重复调用一个http接口刷数据，每次调用接口时需要改变传入的参数，于是想到用postman来完成。

    首先，新建一个Collections

![[./_resources/使用Postman循环调用接口_-_简书.resources/webp.4.webp]]

![[./_resources/使用Postman循环调用接口_-_简书.resources/webp.2.webp]]

   然后点击Add requests创建请求：

![[./_resources/使用Postman循环调用接口_-_简书.resources/webp.7.webp]]

    填写请求相关的url和参数，然后点击保存，一定别忘了保存哦～

![[./_resources/使用Postman循环调用接口_-_简书.resources/webp.webp]]

    在运行之前我们需要准备传入参数的文件，txt 、json和csv格式的文件都是可以的，我准备了txt和json格式的文件：

![[./_resources/使用Postman循环调用接口_-_简书.resources/webp.1.webp]]

![[./_resources/使用Postman循环调用接口_-_简书.resources/webp.3.webp]]

    然后点击Collection的运行按钮，点击Run

![[./_resources/使用Postman循环调用接口_-_简书.resources/webp.5.webp]]

    点击run后进入下边的页面：首先选择我们刚才新建的Collection，然后选择我们写好参数的文件，这里如果我们用的是txt文件，那我们还需要选择一下数据文件的类型和迭代的次数，如果是json文件或csv文件，那么文件类型和迭代次数会自动识别，最后我们可以点击preview查看数据。

![[./_resources/使用Postman循环调用接口_-_简书.resources/webp.6.webp]]

都填写完毕后点击Run，就会循环执行我们的接口啦～

![[./_resources/使用Postman循环调用接口_-_简书.resources/webp.8.webp]]

_![[./_resources/使用Postman循环调用接口_-_简书.resources/embedded.1.svg]]_
1人点赞_![[./_resources/使用Postman循环调用接口_-_简书.resources/embedded.2.svg]]_

_![[./_resources/使用Postman循环调用接口_-_简书.resources/embedded.3.svg]]_

[_![[./_resources/使用Postman循环调用接口_-_简书.resources/embedded.4.svg]]_烂笔头](https://www.jianshu.com/nb/37761013)

_![[./_resources/使用Postman循环调用接口_-_简书.resources/embedded.5.svg]]_

"小礼物走一走，来简书关注我"
还没有人赞赏，支持一下
[![[./_resources/使用Postman循环调用接口_-_简书.resources/3-9a2bcc21a5d89e21dafc73b39dc5f582.jpg]]](https://www.jianshu.com/u/306e28e58ace)

[有巨大福的长颈鹿](https://www.jianshu.com/u/306e28e58ace)
总资产0.197 (约0.01元)共写了300字获得1个赞共1个粉丝

    Created at: 2020-09-30T11:12:28+08:00
    Updated at: 2020-09-30T11:12:28+08:00


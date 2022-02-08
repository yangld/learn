
[博客园](https://www.cnblogs.com/) | [首页](https://www.cnblogs.com/guangjiao/) | [新随笔](https://i.cnblogs.com/EditPosts.aspx?opt=1) | [联系](https://msg.cnblogs.com/send/%E6%9A%AE%E9%9B%A8%E7%BB%B5%E7%BB%B5) | [[# | 订阅]] [![[8知识管理/InBox/evernote/参考/_resources/使用postmant做自动化测试_-_暮雨绵绵_-_博客园.resources/xml.gif]]](https://www.cnblogs.com/guangjiao/rss/) | [管理](https://i.cnblogs.com/)

# [使用postmant做自动化测试](https://www.cnblogs.com/guangjiao/p/11453262.html)

	

**以请求方式为post的登录接口为例，接口文档包括：请求url，请求参数，请求方式**

接口文档如下:

![[716435-20190903213958416-448869404.png]]

**1.在postmant输入url，请求方式，参数；**

**![[716435-20190903214401352-692225433.png]]**

 2）保存接口测试工程

![[716435-20190903214652190-773878521.png]]

**2.编写测试数据：包含具体的测试用例数据，列名，检查点；**

 用文档编写测试数据，并上传，eg：

![[716435-20190903215514166-1114532349.png]]

测试数据文档预览：

![[716435-20190903215711995-2022909954.png]]

**3.参数的value不能写死，调用测试数据中的变量列名；**

**![[716435-20190903215932064-362217266.png]]**

**4.编写检验结果；**

   1）获取参数；

![[716435-20190903221227888-1073477308.png]]

   2）设置结果检验参数（即返回结果包含某些参数）；

![[716435-20190903221722736-944042095.png]]

 **5.获取变量，设置检验变量**

 1）获取变量；

![[716435-20190903222453475-1796366646.png]]

 2）设置检验变量；

![[716435-20190903222555130-1454739226.png]]

 保存后重新runner，查看运行结果

![[716435-20190903231255396-804174009.png]]

[[# | 好文要顶]] [[# | 关注我]] [[# | 收藏该文]] [[# | ![[8知识管理/InBox/evernote/参考/_resources/使用postmant做自动化测试_-_暮雨绵绵_-_博客园.resources/icon_weibo_24.png]]]] [[# | ![[8知识管理/InBox/evernote/参考/_resources/使用postmant做自动化测试_-_暮雨绵绵_-_博客园.resources/wechat.png]]]]

[![[sample_face.gif]]](https://home.cnblogs.com/u/guangjiao/)
[暮雨绵绵](https://home.cnblogs.com/u/guangjiao/)
[关注 - 0](https://home.cnblogs.com/u/guangjiao/followees/)
[粉丝 - 1](https://home.cnblogs.com/u/guangjiao/followers/)

[[# | +加关注]]

0
0

[«](https://www.cnblogs.com/guangjiao/p/11452025.html) 上一篇： [使用postmant做接口测试](https://www.cnblogs.com/guangjiao/p/11452025.html)
[»](https://www.cnblogs.com/guangjiao/p/11456412.html) 下一篇： [python的安装与环境变量配置](https://www.cnblogs.com/guangjiao/p/11456412.html)

发表于 2019-09-03 23:16  [暮雨绵绵](https://www.cnblogs.com/guangjiao/)  阅读(2142)  评论(0)  [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=11453262)  [[# | 收藏]]

[[# | 刷新评论]][刷新页面](https://www.cnblogs.com/guangjiao/p/11453262.html#)[返回顶部](https://www.cnblogs.com/guangjiao/p/11453262.html#top)

登录后才能发表评论，立即 [[# | 登录]] 或 [[# | 注册]]， [访问](https://www.cnblogs.com/) 网站首页。

*   [首页](https://www.cnblogs.com/)
*   [新闻](https://news.cnblogs.com/)
*   [博问](https://q.cnblogs.com/)
*   [专区](https://brands.cnblogs.com/)
*   [闪存](https://ing.cnblogs.com/)
*   [班级](https://edu.cnblogs.com/)

[【推荐】超50万行C++/C#: 大型组态工控、电力仿真CAD与GIS源码库](http://www.softbam.com/index.htm)
[【推荐】博客园派送云上的免费午餐，AWS新用户立享12个月免费套餐](https://www.amazonaws.cn/en/campaign/?sc_channel=ba&sc_campaign=cnblogs2020&sc_detail=640x480&sc_country=cn&sc_geo=chna&sc_outcome=acq)
[【推荐】未知数的距离，毫秒间的传递，声网与你实时互动](https://brands.cnblogs.com/agora)

**最新 IT 新闻**:
· [蚂蚁万亿IPO：少数人的盛宴？有没有“抽血效应”？](https://news.cnblogs.com/n/676213/)
· [FB财报电话会议实录：扎克伯格称疫情让用户对平台社区需求不断增加](https://news.cnblogs.com/n/676212/)
· [Alphabet财报电话会议实录：将持续对谷歌云进行大规模投资](https://news.cnblogs.com/n/676211/)
· [苹果财报电话会议实录：库克称中国区表现不佳因九月没推新iPhone](https://news.cnblogs.com/n/676210/)
· [霍尼韦尔公司宣布推出10量子比特的H1量子计算机](https://news.cnblogs.com/n/676209/)
» [更多新闻...](https://news.cnblogs.com/)

    Created at: 2020-10-30T15:59:18+08:00
    Updated at: 2020-10-30T15:59:18+08:00


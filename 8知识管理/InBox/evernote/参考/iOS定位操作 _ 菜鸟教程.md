
# [菜鸟教程 -- 学的不仅是技术，更是梦想！](https://www.runoob.com/)

*   [首页](https://www.runoob.com/)
*   [HTML](https://www.runoob.com/html/html-tutorial.html)
*   [CSS](https://www.runoob.com/css/css-tutorial.html)
*   [JavaScript](https://www.runoob.com/js/js-tutorial.html)
*   [jQuery](https://www.runoob.com/jquery/jquery-tutorial.html)
*   [Bootstrap](https://www.runoob.com/bootstrap/bootstrap-tutorial.html)
*   [Python3](https://www.runoob.com/python3/python3-tutorial.html)
*   [Python2](https://www.runoob.com/python/python-tutorial.html)
*   [Java](https://www.runoob.com/java/java-tutorial.html)
*   [C](https://www.runoob.com/cprogramming/c-tutorial.html)
*   [C++](https://www.runoob.com/cplusplus/cpp-tutorial.html)
*   [C#](https://www.runoob.com/csharp/csharp-tutorial.html)
*   [SQL](https://www.runoob.com/sql/sql-tutorial.html)
*   [MySQL](https://www.runoob.com/mysql/mysql-tutorial.html)
*   [PHP](https://www.runoob.com/php/php-tutorial.html)
*   [本地书签](https://www.runoob.com/browser-history)

iOS 教程 [[# | __]]

[iOS 教程](https://www.runoob.com/ios/ios-tutorial.html) [iOS 简介](https://www.runoob.com/ios/ios-intro.html) [iOS环境搭建](https://www.runoob.com/ios/ios-setup.html) [Objective C 基础知识](https://www.runoob.com/ios/ios-objective-c.html) [创建第一款iPhone应用程序](https://www.runoob.com/ios/ios-first-iphone-application.html) [iOS操作（action）和输出口（Outlet）](https://www.runoob.com/ios/ios-action-outlet.html) [iOS - 委托（Delegates）](https://www.runoob.com/ios/ios-delegates.html) [iOS UI元素](https://www.runoob.com/ios/ios-ui.html) [iOS加速度传感器(accelerometer)](https://www.runoob.com/ios/ios-accelerometer.html) [iOS通用应用程序](https://www.runoob.com/ios/ios-universal-applications.html) [iOS相机管理](https://www.runoob.com/ios/ios-camera.html) [iOS定位操作](https://www.runoob.com/ios/ios-location.html) [iOS SQLite数据库](https://www.runoob.com/ios/ios-sqlite.html) [iOS发送电子邮件](https://www.runoob.com/ios/ios-sending-email.html) [iOS音频和视频(Audio & Video)](https://www.runoob.com/ios/ios-audio-video.html) [iOS文件处理](https://www.runoob.com/ios/ios-file.html) [iOS地图开发](https://www.runoob.com/ios/ios-maps.html) [iOS应用内购买](https://www.runoob.com/ios/ios-in-app-purchase.html) [iOS整合iAD](https://www.runoob.com/ios/ios-iad.html) [iOS GameKit](https://www.runoob.com/ios/ios-gamekit.html) [iOS 故事板(Storyboards)](https://www.runoob.com/ios/ios-storyboards.html) [iOS自动布局](https://www.runoob.com/ios/ios-auto-layouts.html) [iOS Twitter和Facebook](https://www.runoob.com/ios/ios-twitter-facebook.html) [iOS内存管理](https://www.runoob.com/ios/ios-memory.html) [iOS应用程序调试](https://www.runoob.com/ios/ios-application-debugging.html)

[__](https://www.runoob.com/ios/ios-camera.html) [iOS相机管理](https://www.runoob.com/ios/ios-camera.html)
[iOS SQLite数据库](https://www.runoob.com/ios/ios-sqlite.html) [__](https://www.runoob.com/ios/ios-sqlite.html)

# IOS定位操作

* * *

## 简介

在IOS中通过CoreLocation定位，可以获取到用户当前位置，同时能得到装置移动信息。

### 实例步骤

1、创建一个简单的View based application（视图应用程序）。

2、择项目文件，然后选择目标，然后添加CoreLocation.framework,如下所示

![[8知识管理/InBox/evernote/参考/_resources/iOS定位操作___菜鸟教程.resources/unknown_filename.png]]

3、在ViewController.xib中添加两个标签，创建ibOutlet名为latitudeLabel和longtitudeLabel的标签

4、现在通过选择" File-> New -> File... -> "选择Objective C class 并单击下一步

5、把"sub class of"作为NSObject，将类命名为LocationHandler

6、选择创建

7、更新LocationHandler.h，如下所示

#evernote <Foundation/Foundation.h> #evernote <CoreLocation/CoreLocation.h> @protocol LocationHandlerDelegate <NSObject\> @required \-(void) didUpdateToLocation:(CLLocation\*)newLocation 
 fromLocation:(CLLocation\*)oldLocation; @end @interface LocationHandler : NSObject<CLLocationManagerDelegate\> { CLLocationManager \*locationManager; } @property(nonatomic,strong) id<LocationHandlerDelegate\> delegate; +(id)getSharedInstance; \-(void)startUpdating; \-(void) stopUpdating; @end

8、更新LocationHandler.m,如下所示

#evernote "LocationHandler.h" static LocationHandler \*DefaultManager \= nil; @interface LocationHandler() \-(void)initiate; @end @implementation LocationHandler +(id)getSharedInstance{ if (!DefaultManager) { DefaultManager \= \[\[self allocWithZone:NULL\]init\]; \[DefaultManager initiate\]; } return DefaultManager; } \-(void)initiate{ locationManager \= \[\[CLLocationManager alloc\]init\]; locationManager.delegate \= self; } \-(void)startUpdating{ \[locationManager startUpdatingLocation\]; } \-(void) stopUpdating{ \[locationManager stopUpdatingLocation\]; } \-(void)locationManager:(CLLocationManager \*)manager didUpdateToLocation: (CLLocation \*)newLocation fromLocation:(CLLocation \*)oldLocation{ if (\[self.delegate respondsToSelector:@selector (didUpdateToLocation:fromLocation:)\]) { \[self.delegate didUpdateToLocation:oldLocation 
        fromLocation:newLocation\]; } } @end

9、更新ViewController.h,如下所示

#evernote <UIKit/UIKit.h> #evernote "LocationHandler.h" @interface ViewController : UIViewController<LocationHandlerDelegate\> { IBOutlet UILabel \*latitudeLabel; IBOutlet UILabel \*longitudeLabel; } @end

10、更新ViewController.m,如下所示

#evernote "ViewController.h" @interface ViewController () @end @implementation ViewController \- (void)viewDidLoad { \[super viewDidLoad\]; \[\[LocationHandler getSharedInstance\]setDelegate:self\]; \[\[LocationHandler getSharedInstance\]startUpdating\]; } \- (void)didReceiveMemoryWarning { \[super didReceiveMemoryWarning\]; // Dispose of any resources that can be recreated. } \-(void)didUpdateToLocation:(CLLocation \*)newLocation 
 fromLocation:(CLLocation \*)oldLocation{ \[latitudeLabel setText:\[NSString stringWithFormat: @"Latitude: %f",newLocation.coordinate.latitude\]\]; \[longitudeLabel setText:\[NSString stringWithFormat: @"Longitude: %f",newLocation.coordinate.longitude\]\]; } @end

### 输出

当我们运行该应用程序，会得到如下的输出:

![[8知识管理/InBox/evernote/参考/_resources/iOS定位操作___菜鸟教程.resources/unknown_filename.1.png]]

[__](https://www.runoob.com/ios/ios-camera.html) [iOS相机管理](https://www.runoob.com/ios/ios-camera.html)
[iOS SQLite数据库](https://www.runoob.com/ios/ios-sqlite.html) [__](https://www.runoob.com/ios/ios-sqlite.html)

### __ 点我分享笔记

[![[13063754865781208952.png]]](https://www.googleadservices.com/pagead/aclk?sa=L&ai=CKTeNnHvDXrfhKMuG8ALA6rCADu299oNao7Su-rcJv5a7gMIQEAEgi8zLImDZAqABst6nwAPIAQKpAnVG4Bkj4YI-qAMByAPJBKoE6gFP0McbSFvlneNXIJtEaVOo8sCNzKNYW4eR7FpaoUWVaBjJDzqUimR_6YJQx2-hKIxZZRpDgNoetZOPQmsG1j8snH2mIk6Dt8vjcAhnE_4SGLdsdv5nbGnSHCa3ahtpGQt-e9bgcY1paidlmym2LSiO1zQ6CAJQ0X-BGWPuRtqoKcCMqwbdCgYraC0x6Ase24PoHDH_edebe1mfOkXLAjzUx-sj7v-vXBsKZlBv6ZQvqmi7Auem3Jh9AHtEorN-3yn4YyhfCBuOWDtzrkK5G-1BXWz2AVesxQgMVHc0Jn9ok3-OFZDxYBPjMIPABMG1tZ7lAZAGAaAGAoAHtqHYP4gHAZAHAqgHjs4bqAfVyRuoB5PYG6gHugaoB_DZG6gH8tkbqAemvhuoB-zVG6gH89EbqAfs1RuoB5bYG6gHwtob2AcB0ggGCAAQAhgasQmU8c5ckllHT4AKAZgLAcgLAdgTDA&ae=1&num=1&cid=CAMSeQClSFh3TM_UQ39ev7t8hM_zXVtvgqlLI-oravvIRNVKgjnrRTsskdWpy2zuVFqyqlbeNlado-O7CTlVdXSsePB5vVG4NTg4BnjAc98_OB2i0KCQifAS4XXUL0sBPvu8JuNmW-NkKmaIvP0rkcZoehJF0irF-yaM_ms&sig=AOD64_33SDJ9_gtHnnO0KRJ2ehX_hLvkTQ&client=ca-pub-5751451760833794&nb=17&adurl=https://cloud.tencent.com/act/campus%3FfromSource%3Dgwzcw.1735651.1735651.1735651%26gclid%3DCjwKCAjw5Ij2BRBdEiwA0Frc9VBeuw6CGngfu2RP3lbqUXlEI9uiEi2RmROPUTFUEI3UHQPhnuWykxoCxXgQAvD_BwE)

![[8知识管理/InBox/evernote/参考/_resources/iOS定位操作___菜鸟教程.resources/embedded.svg]]

![[8知识管理/InBox/evernote/参考/_resources/iOS定位操作___菜鸟教程.resources/embedded.1.svg]]

[[# | __ 分类导航]]

*   [[# | HTML / CSS]]
*   [[# | JavaScript]]
*   [[# | 服务端]]
*   [[# | 数据库]]
*   [[# | 移动端]]
*   [[# | XML 教程]]
*   [[# | ASP.NET]]
*   [[# | Web Service]]
*   [[# | 开发工具]]
*   [[# | 网站建设]]

[[# | Advertisement]]

![[8知识管理/InBox/evernote/参考/_resources/iOS定位操作___菜鸟教程.resources/embedded.2.svg]]

![[8知识管理/InBox/evernote/参考/_resources/iOS定位操作___菜鸟教程.resources/embedded.3.svg]]

在线实例
·[HTML 实例](https://www.runoob.com/html/html-examples.html)
·[CSS 实例](https://www.runoob.com/css/css-examples.html)
·[JavaScript 实例](https://www.runoob.com/js/js-examples.html)
·[Ajax 实例](https://www.runoob.com/ajx/ajax-examples.html)
·[jQuery 实例](https://www.runoob.com/jquery/jquery-examples.html)
·[XML 实例](https://www.runoob.com/xml/xml-examples.html)
·[Java 实例](https://www.runoob.com/java/java-examples.html)

字符集&工具
· [HTML 字符集设置](https://www.runoob.com/charsets/html-charsets.html)
· [HTML ASCII 字符集](https://www.runoob.com/tags/html-ascii.html)
· [HTML ISO-8859-1](https://www.runoob.com/tags/ref-entities.html)
· [HTML 实体符号](https://www.runoob.com/tags/html-symbols.html)
· [HTML 拾色器](https://www.runoob.com/tags/html-colorpicker.html)
· [JSON 格式化工具](https://c.runoob.com/front-end/53)

最新更新
· [Django 简介](http://www.runoob.com/django/django-intro.html)
· [字节与字符的区别](http://www.runoob.com/w3cnote/byte-character.html)
· [Redis HSCAN 命令](http://www.runoob.com/redis/hashes-hscan.html)
· [Redis SCAN 命令](http://www.runoob.com/redis/keys-scan.html)
· [Python Tkinter ...](http://www.runoob.com/python/python-tk-label.html)
· [Python Tkinter ...](http://www.runoob.com/python/python-tk-frame.html)
· [Python3 os.pard...](http://www.runoob.com/python3/python3-os-pardir.html)

站点信息
· [意见反馈](https://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=ssbDyoOAgfLU3crf09venNHd3w)
· [免责声明](https://www.runoob.com/disclaimer)
· [关于我们](https://www.runoob.com/aboutus)
· [文章归档](https://www.runoob.com/archives)

**关注微信**

![[8知识管理/InBox/evernote/参考/_resources/iOS定位操作___菜鸟教程.resources/unknown_filename.2.png]]

Copyright © 2013-2020 **[菜鸟教程](https://www.runoob.com/)**  **[runoob.com](https://www.runoob.com/)** All Rights Reserved. 备案号：[闽ICP备15012807号-1](http://www.beian.miit.gov.cn/)

    Created at: 2020-05-19T14:24:51+08:00
    Updated at: 2020-05-19T14:24:51+08:00


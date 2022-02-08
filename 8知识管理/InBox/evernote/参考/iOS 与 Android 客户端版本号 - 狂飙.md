
[狂飙](https://networm.me/)

*   [标签](https://networm.me/tags/)
*   [分类](https://networm.me/categories/)
*   [关于](https://networm.me/about/)

# iOS 与 Android 客户端版本号

2018-11-18 22:14:30 +0800
[· client](https://networm.me/categories/client/)
· 约 945 字 · 预计阅读 2 分钟

## 文章目录

*   [介绍](https://networm.me/2018/11/18/ios-android-client-version/#%E4%BB%8B%E7%BB%8D)
*   [iOS](https://networm.me/2018/11/18/ios-android-client-version/#ios)
*   [Android](https://networm.me/2018/11/18/ios-android-client-version/#android)
*   [区别与联系](https://networm.me/2018/11/18/ios-android-client-version/#%E5%8C%BA%E5%88%AB%E4%B8%8E%E8%81%94%E7%B3%BB)
*   [建议](https://networm.me/2018/11/18/ios-android-client-version/#%E5%BB%BA%E8%AE%AE)
*   [统一策略](https://networm.me/2018/11/18/ios-android-client-version/#%E7%BB%9F%E4%B8%80%E7%AD%96%E7%95%A5)

## [__](https://networm.me/2018/11/18/ios-android-client-version/#%E4%BB%8B%E7%BB%8D)介绍

由于游戏需要同时支持 iOS 与 Android 平台，那么版本号也建议同时支持。

## [__](https://networm.me/2018/11/18/ios-android-client-version/#ios)iOS

以下内容是苹果开发者网站对 `Version Numbers` 与 `Build Numbers` 的定义：

> For each new version of your App, you will provide a Version Number to differentiate it from previous versions. The Version Number works like a name for each release of your App. For example, Version 1.0.0 may name the first release, Version 2.0.1 will name the second, and so on. When submitting a new release of your App to the App Store, it is normal to have some false starts. You may forget an icon in one build, or perhaps there is a problem in another build. As a result, you may produce many builds during the process of submitting a new release of your App to the App Store. Because these builds will be for the same release of your App, they will all have the same Version Number. But, each of these builds must have a unique Build Number associated with it so it can be differentiated from the other builds you have submitted for the release. The collection of all of the builds submitted for a particular version is referred to as the ‘release train’ for that version.

也就是说，每一个 `Version Numbers` 指定将要发布到 AppStore 的版本，`Build Numbers` 指定此版本的子版本。

[Technical Note TN2420: Version Numbers and Build Numbers](https://developer.apple.com/library/content/technotes/tn2420/_index.html)

## [__](https://networm.me/2018/11/18/ios-android-client-version/#android)Android

以下内容是 Android 官网对 `versionName` 的定义：

> versionName — A string used as the version number shown to users. This setting can be specified as a raw string or as a reference to a string resource. The value is a string so that you can describe the app version as a .. string, or as any other type of absolute or relative version identifier. The versionName has no purpose other than to be displayed to users.

以下内容是 Android 官网对 `versionCode` 的定义：

> versionCode — An integer used as an internal version number. This number is used only to determine whether one version is more recent than another, with higher numbers indicating more recent versions. This is not the version number shown to users; that number is set by the versionName setting, below.

由此可见，`versionCode` 必须使用整数，同时官网也指出了最大值：

> Warning: The greatest value Google Play allows for versionCode is 2100000000.

[Version Your App | Android Studio](https://developer.android.com/studio/publish/versioning.html)

## [__](https://networm.me/2018/11/18/ios-android-client-version/#%E5%8C%BA%E5%88%AB%E4%B8%8E%E8%81%94%E7%B3%BB)区别与联系

iOS 与 Android 采用了不同的策略，确定一个版本：iOS 需要两个字符串参数；Android 需要一个整型数字 `versionCode`。

## [__](https://networm.me/2018/11/18/ios-android-client-version/#%E5%BB%BA%E8%AE%AE)建议

将版本号分为两类：

*   显示版本号 - 需要满足显示的需求，用以定位版本、查找 Bug、发布更新等等
*   内部版本号 - 需要满足平台的要求，必须每个版本号都不相同

## [__](https://networm.me/2018/11/18/ios-android-client-version/#%E7%BB%9F%E4%B8%80%E7%AD%96%E7%95%A5)统一策略

版本号采用 [语义化版本 2.0.0 - Semantic Versioning](http://semver.org/lang/zh-CN/)，尽量使其标准化。以 `major.minor.patch` 表示。

构建号是由打包机产生，每次构建递增。以 `build` 表示。

所以最终的版本信息为：

|     | Base | Extend |
| --- | --- | --- |
| iOS | Version Number: major.minor.patch | Build Number: {d}.{d}.{d}.{d3}:major, minor, patch, build |
| Android | versionName: major.minor.patch | versionCode: {d}{d2}{d2}{d3}:major, minor, patch, build |

最终，Android 平台的 `versionCode` 变为了版本号的转化，而其中的转化规则对版本号增加了限制：

*   `major` 部分最大不能超过 210。
*   `minor` 与 `patch` 部分最大不能超过 99，建议超过时提升上级版本号。
*   `build` 部分不能超过 999，建议超过时提升上级版本号，同时将其取余。

版本号采用 Extend 模式有一个额外好处，某些情况下需要将对外发布的版本固定在某一 Base 版本上，但是实际的版本号还需要变化，那么通过增加额外一段的 Extend 版本号，可以方便地控制分离显示版本号与内部版本号。即保留了两种版本号之间的对应关系，又能进行部分自定义。

文章作者 : [狂飙](https://networm.me/)

初次发布 : 2018-11-18 22:14:30 +0800

永久链接 : <https://networm.me/2018/11/18/ios-android-client-version/>

许可协议 : [署名-非商业性使用-相同方式共享 4.0 国际 (CC BY-NC-SA 4.0)](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.zh)

[#evernote](https://networm.me/tags/client/) [#evernote](https://networm.me/tags/ios/) [#evernote](https://networm.me/tags/android/)
[__ Git 团队协作流程](https://networm.me/2018/11/25/git-for-teamwork/) [为什么写博客？ __](https://networm.me/2018/11/11/why-write-blog/)

Login

[Commento](https://commento.io/)

[](https://networm.me/2018/11/18/ios-android-client-version/mailto:zzjbcn@gmail.com) [](https://github.com/networm) [](https://networm.me/index.xml)
由 [Hugo](https://gohugo.io/) 强力驱动 | 主题 - [Even](https://github.com/olOwOlo/hugo-theme-even) © 2011 - 2020 __ 狂飙

    Created at: 2020-05-07T15:15:21+08:00
    Updated at: 2020-05-07T15:15:21+08:00


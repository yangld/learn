
![[8知识管理/InBox/evernote/参考/_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/embedded.svg]]

# iOS 版本号大小判断(升级判断)

[![[8知识管理/InBox/evernote/参考/_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/webp.13.webp]]](https://www.jianshu.com/u/f93674a68449)

[朱\_源浩](https://www.jianshu.com/u/f93674a68449)
2018.01.24 17:31:04字数 179阅读 1,454

需要做升级判断，or 要用到审核开关，就需要用到版本号的大小判断。
（之后找篇文章写写iOS审核开关的事情<有点风险，不轻易乱学>

下面简单写了个版本字符串对比的小方法，
适用的格式是：1.2.2>1.2.1、1.2 > 1.1.9 、1.2 = 1.2.0 。。。也就是适用于xx.xx.xx.xx.....的纯数字版本格式

以下是代码：

    + (NSInteger)compareVersion:(NSString *)version1 toVersion:(NSString *)version2
    {
        NSArray *list1 = [version1 componentsSeparatedByString:@"."];
        NSArray *list2 = [version2 componentsSeparatedByString:@"."];
        for (int i = 0; i < list1.count || i < list2.count; i++)
        {
            NSInteger a = 0, b = 0;
            if (i < list1.count) {
                a = [list1[i] integerValue];
            }
            if (i < list2.count) {
                b = [list2[i] integerValue];
            }
            if (a > b) {
                return 1;//version1大于version2
            } else if (a < b) {
                return -1;//version1小于version2
            }
        }
        return 0;//version1等于version2
        
    }
    12345678910111213141516171819202122

接下来，说说我自己做版本升级判断的方式：
主要是思路是：

1.  将版本号存在本地NSUserDefaults里
2.  和目前的CFBundleShortVersionString 进行对比

    /*
        检查首次安装/升级
     */
    + (void)checkVersionFirstInstall:(void(^)())firstInstall
                                    updateInstall:(void(^)())updateInstall
                                                 other:(void(^)())other
    {
        NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        NSUserDefaults *persistentDefaults = [NSUserDefaults standardUserDefaults];    
        NSString *localVersion = [persistentDefaults objectForKey:@"localVersion"];
        
        if(!localVersion){
            //首次安装打开
            NSLog(@"首次安装打开");
            if(firstInstall){
                firstInstall();
            }
            //[self setLocalAppVersion]; 按需求看是否在这里就更新本地版本号
        } else if([self compareVersion:appVersion toVersion:localVersion] == 1){
            //升级打开
            NSLog(@"升级打开");
            if(updateInstall){
                updateInstall();
            }
            //[self setLocalAppVersion];
        } else {
            //普通打开
            NSLog(@"普通打开");
            if(other){
                other();
            }
        }
    }
    
    //将版本号存到本地
    + (void)setLocalAppVersion
    {
        NSString *localVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        NSUserDefaults *persistentDefaults = [NSUserDefaults standardUserDefaults];  
        [persistentDefaults setObject: localVersion forKey:@"localVersion"];
        [persistentDefaults synchronize];
    }
    
    12345678910111213141516171819202122232425262728293031323334353637383940414243

_![[./_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/embedded.1.svg]]_
4人点赞_![[8知识管理/InBox/evernote/参考/_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/embedded.2.svg]]_

_![[./_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/embedded.3.svg]]_

[_![[./_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/embedded.4.svg]]_iOS相关](https://www.jianshu.com/nb/5029385)

_![[./_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/embedded.5.svg]]_

"打赏太夸张了，喜欢的话点个喜欢或关注就是很大的动力了！"
还没有人赞赏，支持一下
[![[8知识管理/InBox/evernote/参考/_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/webp.7.webp]]](https://www.jianshu.com/u/f93674a68449)

[朱\_源浩](https://www.jianshu.com/u/f93674a68449)稀饭。。。
总资产4 (约0.40元)共写了2.4W字获得607个赞共648个粉丝

![[934c722a3771.bin]]

### 
全部评论0只看作者

按时间倒序
按时间正序

### 被以下专题收入，发现更多相似内容

[![[8知识管理/InBox/evernote/参考/_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/webp.1.webp]]程序员](https://www.jianshu.com/c/NEt52a)[![[8知识管理/InBox/evernote/参考/_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/webp.11.webp]]首页投稿（暂停...](https://www.jianshu.com/c/bDHhpK)[![[8知识管理/InBox/evernote/参考/_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/webp.12.webp]]iOS Dev...](https://www.jianshu.com/c/ee25d429d275)[![[8知识管理/InBox/evernote/参考/_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/webp.9.webp]]调试界面](https://www.jianshu.com/c/f467274a9805)[![[8知识管理/InBox/evernote/参考/_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/webp.2.webp]]iOS收藏](https://www.jianshu.com/c/2157065d9cbd)

### 推荐阅读[更多精彩内容_![[./_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/embedded.6.svg]]_](https://www.jianshu.com/)

*   [Java面试宝典Beta5.0](https://www.jianshu.com/p/fb7d48083e5e)
    pdf下载地址：Java面试宝典 第一章内容介绍 20 第二章JavaSE基础 21 一、Java面向对象 21 ...
    [![[8知识管理/InBox/evernote/参考/_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/webp.4.webp]]王震阳](https://www.jianshu.com/u/773a782d9d83)阅读 86,699评论 26赞 532
    
*   [面向对象的用电信息数据交换协议](https://www.jianshu.com/p/94caedb70f65)
    国家电网公司企业标准（Q/GDW）- 面向对象的用电信息数据交换协议 - 报批稿：20170802 前言： 排版 ...
    [![[8知识管理/InBox/evernote/参考/_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/webp.webp]]庭说](https://www.jianshu.com/u/a0d04c114c89)阅读 4,158评论 4赞 7
    
*   [当你像个孩子一样的参与，你会更快乐](https://www.jianshu.com/p/f275d653d8c0)
    乐点之行11(记3.13日） 我在想我的童年肯定没有玩够，看到孩子在游乐场玩我想奔上去玩，看着孩子玩玩具我也很想玩...
    [![[6-fd30f34c8641f6f32f5494df5d6b8f3c.jpg]]元yuan](https://www.jianshu.com/u/effeab6b94f5)阅读 161评论 2赞 3
    [![[8知识管理/InBox/evernote/参考/_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/webp.5.webp]]](https://www.jianshu.com/p/f275d653d8c0)
*   [安卓开发中获取服务器网络延迟(ping)](https://www.jianshu.com/p/e42d056f1403)
    在开中,突然遇到了一套根据服务器的网络延迟(ping),分为不同的等级<,然后根据等级做出不同的处理,在网上找资料...
    [![[8知识管理/InBox/evernote/参考/_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/webp.8.webp]]进击de小黑](https://www.jianshu.com/u/e40475aab40a)阅读 1,727评论 2赞 5
    
*   [谁在绿茵深处，许谁一世荣光。](https://www.jianshu.com/p/0b92cc306978)
    罗纳尔多——这个名字在不同的时代抒写了不同的传奇。现今时代，这个名字只属于克里斯蒂亚诺·罗纳尔多。 四座金球奖，四...
    [![[8知识管理/InBox/evernote/参考/_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/webp.10.webp]]叶落yeluo](https://www.jianshu.com/u/4f79e62f10b8)阅读 152评论 12赞 4
    [![[8知识管理/InBox/evernote/参考/_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/webp.6.webp]]](https://www.jianshu.com/p/0b92cc306978)

[![[2408285059676372656.gif]]](https://googleads.g.doubleclick.net/aclk?sa=L&ai=Cd5MkZbOzXsDyI5LmgQO6p52YBNSzvI5dgerM0M8L2tkeEAEgmcqVe2DZAsgBA6kCLDuACNRQgT6oAwHIA8kEqgTTAU_Q8m109FVa5rUQjqgEW23D2B8dLFSk4STPqmbZsfIEsx4WxTzQC5gw20cJe-kh75bJhT270sVKFLVa2jiHxJlrdh-Xi0vV1LJeVoc-7K7omeJEzUMhZegVPOWQCQbUQWi1fefr9sKNO-Vjxp_hTh2GhgS3S89I7tfllES1g8zbj00Q422MzDZ_GBgnCBbKKG9Z6tlEfcBqtWGwfSUBfHU-6r-ehhGrKZZRt78pf77BLL5IBOzKdqLJBxQr3_nqwt36QFUEHJ9bJN0GqR4rzgyEbmjABPax6eKFA5AGAaAGA4AHmKutsgGIBwGQBwKoB47OG6gH1ckbqAeT2BuoB7oGqAfw2RuoB_LZG6gHpr4bqAfs1RuoB_PRG6gH7NUbqAeW2BuoB8LaG9gHAdIIBggAEAIYGrEJFh0K-HT1ilaACgGYCwHICwHYEwM&ae=1&num=1&cid=CAMSeQClSFh3tQKdTmZkm6Kcwmt8mgzBV2beR7TwldbA6yIKvTgxL69IsJyb5kPUJE0k_p5fl4wUDPJahpgX2eJirIx__4iaBJwIE4l0B_aPYK-or_5kNHGBBPQgZgD3CfBilqkELqOcOXr-buJ7-S8Je7WJKRhX8JSCRIU&sig=AOD64_1IG1olCt59N8oeXPLX3O3M-z85Zw&client=ca-pub-3077285224019295&nb=17&adurl=https://www.chp.gov.hk/tc/r/520)

![[8知识管理/InBox/evernote/参考/_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/embedded.7.svg]]

![[8知识管理/InBox/evernote/参考/_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/embedded.8.svg]]

[![[8知识管理/InBox/evernote/参考/_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/webp.3.webp]]](https://www.jianshu.com/u/f93674a68449)

[朱\_源浩](https://www.jianshu.com/u/f93674a68449)

总资产4 (约0.40元)

[python 获取零点的时间戳](https://www.jianshu.com/p/8fb16fc863ce)
阅读 3,026

[iOS控件 — 状态栏 Status Bar](https://www.jianshu.com/p/32d0048ff2bb)
阅读 3,525

### 推荐阅读

[iOS高级开发工程师-荔枝-笔试](https://www.jianshu.com/p/66ea69c1d361)
阅读 4,544

[KVO底层原理](https://www.jianshu.com/p/1ace2d32fe66)
阅读 923

[runloop总结](https://www.jianshu.com/p/e04f647de92f)
阅读 2,965

[UICollectionView设置header悬浮效果](https://www.jianshu.com/p/f6a3e5b9e4fc)
阅读 455

[iOS根据hex值获取颜色UIColor](https://www.jianshu.com/p/8d205e51650c)
阅读 78

[![[8知识管理/InBox/evernote/参考/_resources/iOS_版本号大小判断(升级判断)_-_简书.resources/unknown_filename.png]]](https://www.googleadservices.com/pagead/aclk?sa=L&ai=C9FiHZbOzXszRJoPdrQSj95LgA82l0NNcttqR3bsLy6vz5fUKEAEgmcqVe2DZAqABoYSqzgPIAQmpAiw7gAjUUIE-qAMByAPDBKoE3wFP0LWvD-m4ZQK0-fZzjxZKUywaZ2EUigF-0xuMhh0U0AYM2k2x-swCw1bqdBxEcAnjAcQkQ706LxrmuxDCHAfK6pcNBYPgiONv3jdYIGcMVUHVYLNLJEB7mIuG4AQ1pIRfz4TmIM6kni9TcXfV-rYyH1NZAqLfzQiSKTL1ddSnCwAOX9ZEmRz_m_sNCDObYq1gjTWwck2fWuW7TBx_5pdIL5EBrS-_HHHOKrHl2-dWBXuO_G36GrPV_g6dMxI0KA5Nctg4zK2LoCBNyb6ERCMSThNnee4UrlxNQAzDX1PwwATtgc_v6QKQBgGgBi6AB8f71TGIBwGQBwKoB47OG6gH1ckbqAeT2BuoB7oGqAfw2RuoB_LZG6gHpr4bqAfs1RuoB_PRG6gH7NUbqAeW2BuoB8LaG9gHANIIBggAEAIYGrEJeasXnuI1ItaACgGYCwHICwGADAHYEwM&ae=1&num=1&cid=CAMSeQClSFh3D1m_ueQjE7WSlhmWAzH0muUE3WCMCRWqSxPVTidFXxTjHVzkWBq-agmFgmPUrdtImvvrbblYCtXvTog43s5OiBceFDkeDzzvLX7X4txY0gmJgy30DuCOeXCJsBU90aL_gyw8bSrpQ-_k2r1-x07MowCH8-M&sig=AOD64_3aa2aRe6uBOI5LGGey5UxejUE4EQ&client=ca-pub-3077285224019295&nb=19&adurl=http://www.centalinesurveyors.com.hk/property-investment%3Fgclid%3DCjwKCAjw4871BRAjEiwAbxXi26bbnvbB_cUawjUTj7e1SjaOGbS-hBdMOu6UA1tVKsL8N9yyzNUbaxoCcQ4QAvD_BwE)<https://www.googleadservices.com/pagead/aclk?sa=L&ai=C9FiHZbOzXszRJoPdrQSj95LgA82l0NNcttqR3bsLy6vz5fUKEAEgmcqVe2DZAqABoYSqzgPIAQmpAiw7gAjUUIE-qAMByAPDBKoE3wFP0LWvD-m4ZQK0-fZzjxZKUywaZ2EUigF-0xuMhh0U0AYM2k2x-swCw1bqdBxEcAnjAcQkQ706LxrmuxDCHAfK6pcNBYPgiONv3jdYIGcMVUHVYLNLJEB7mIuG4AQ1pIRfz4TmIM6kni9TcXfV-rYyH1NZAqLfzQiSKTL1ddSnCwAOX9ZEmRz_m_sNCDObYq1gjTWwck2fWuW7TBx_5pdIL5EBrS-_HHHOKrHl2-dWBXuO_G36GrPV_g6dMxI0KA5Nctg4zK2LoCBNyb6ERCMSThNnee4UrlxNQAzDX1PwwATtgc_v6QKQBgGgBi6AB8f71TGIBwGQBwKoB47OG6gH1ckbqAeT2BuoB7oGqAfw2RuoB_LZG6gHpr4bqAfs1RuoB_PRG6gH7NUbqAeW2BuoB8LaG9gHANIIBggAEAIYGrEJeasXnuI1ItaACgGYCwHICwGADAHYEwM&ae=1&num=1&cid=CAMSeQClSFh3D1m_ueQjE7WSlhmWAzH0muUE3WCMCRWqSxPVTidFXxTjHVzkWBq-agmFgmPUrdtImvvrbblYCtXvTog43s5OiBceFDkeDzzvLX7X4txY0gmJgy30DuCOeXCJsBU90aL_gyw8bSrpQ-_k2r1-x07MowCH8-M&sig=AOD64_3aa2aRe6uBOI5LGGey5UxejUE4EQ&client=ca-pub-3077285224019295&nb=9&adurl=http://www.centalinesurveyors.com.hk/property-investment%3Fgclid%3DCjwKCAjw4871BRAjEiwAbxXi26bbnvbB_cUawjUTj7e1SjaOGbS-hBdMOu6UA1tVKsL8N9yyzNUbaxoCcQ4QAvD_BwE>

    Created at: 2020-05-07T15:07:10+08:00
    Updated at: 2020-05-07T15:07:10+08:00


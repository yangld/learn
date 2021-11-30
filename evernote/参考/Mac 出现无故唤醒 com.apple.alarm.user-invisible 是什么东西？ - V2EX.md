
[![[./_resources/Mac_出现无故唤醒_com.apple.alarm.user-invisible_是什么东西？_-_V2EX.resources/111002_large.png]]](https://www.v2ex.com/member/Awes0me)
[V2EX](https://www.v2ex.com/)  ›  [macOS](https://www.v2ex.com/go/macos)

# Mac 出现无故唤醒 com.apple.alarm.user-invisible 是什么东西？

[[# | *   ]] [[# | *   ]]
  [Awes0me](https://www.v2ex.com/member/Awes0me) · 2019-10-06 21:29:30 +08:00 · 4697 次点击
这是一个创建于 448 天前的主题，其中的信息可能已经有所发展或是发生改变。

关于本机-系统报告-电源

我查了下提醒事项和日历都没有这个时间点的计划，这是哪来的呢？

电源事件：

下一个计划的事件：

appPID： 341 类型： 唤醒 计划安排： com.apple.alarm.user-invisible 时间： 2019/10/13 07:26 UserVisible： 0

appPID： 341 类型： 唤醒 计划安排： com.apple.alarm.user-visible 时间： 2019/12/5 09:00 UserVisible： 1

[*   
apppid](https://www.v2ex.com/tag/apppid)[*   
invisible](https://www.v2ex.com/tag/invisible)[*   
唤醒](https://www.v2ex.com/tag/%E5%94%A4%E9%86%92)[*   
计划](https://www.v2ex.com/tag/%E8%AE%A1%E5%88%92)
4 条回复  **•**  2020-05-23 22:44:19 +08:00

|     |     |     |
| --- | --- | --- |
| ![[./_resources/Mac_出现无故唤醒_com.apple.alarm.user-invisible_是什么东西？_-_V2EX.resources/3d7214b634676e83a6308d63eae4179e.png]] |     | 1<br><br>**[tinsula](https://www.v2ex.com/member/tinsula)**   2019-10-16 17:25:31 +08:00<br><br>我也有，是升级到 macos 10.15 有的 你也是吗<br>电源事件：<br>下一个计划的事件：<br>appPID： 367<br>类型： 唤醒<br>计划安排： com.apple.alarm.user-visible<br>时间： 2019/10/18 09:00<br>UserVisible： 1<br>appPID： 367<br>类型： 唤醒<br>计划安排： com.apple.alarm.user-visible<br>时间： 2019/10/18 09:00<br>UserVisible： 1 |

|     |     |     |
| --- | --- | --- |
| ![[./_resources/Mac_出现无故唤醒_com.apple.alarm.user-invisible_是什么东西？_-_V2EX.resources/111002_normal.png]] |     | 2<br><br>**[Awes0me](https://www.v2ex.com/member/Awes0me)**   2019-10-16 17:35:12 +08:00<br><br>@[tinsula](https://www.v2ex.com/member/tinsula) 是的, 很奇怪 |

|     |     |     |
| --- | --- | --- |
| ![[./_resources/Mac_出现无故唤醒_com.apple.alarm.user-invisible_是什么东西？_-_V2EX.resources/71356_normal.png]] |     | 3<br><br>**[turandot](https://www.v2ex.com/member/turandot)**   2019-10-21 07:27:08 +08:00<br><br>我也遇到了，但是我确实是设置的提醒事项的时间，找半天没找到怎么关闭提醒事项唤醒睡眠中的电脑 |

|     |     |     |
| --- | --- | --- |
| ![[./_resources/Mac_出现无故唤醒_com.apple.alarm.user-invisible_是什么东西？_-_V2EX.resources/b1a315beb4f705b594f5a80eb9ac32cd.png]] |     | 4<br><br>**[yinxianwei](https://www.v2ex.com/member/yinxianwei)**   218 天前<br><br>pmset schedule cancelall |

[![[./_resources/Mac_出现无故唤醒_com.apple.alarm.user-invisible_是什么东西？_-_V2EX.resources/3233101948030752826.png]]](https://googleads.g.doubleclick.net/aclk?sa=L&ai=CwYYlrDXpX9exGtaLrQHbzoqQAuC4-d9gjLOrhb8M2tkeEAEggKvwO2DpAsgBAqkC7PYEVpYXYz6oAwHIA8kEqgTOAU_QvQxchsPLBBKw_FcFMllPZR47qm3SYMApPPtEpFtLUTYPG9BVF0GG_IbMXwvHQFYrnGdaJqU-Z-2g2E4_NQkTgP4Aw_L48NjghVur219IQYPJTH29lbxDAqdUVOSYyIlJLGsBeRQYM5kRHpGGrD6UXb_BhZgd3fjOJj-oP41nZpoXrkqekFt0Nqn3mwsnxbqorXMb7QAjqC3zY9Ch_vJ_pblrEXiDPdBoZMyOxp93t7iT9MzhA-qYDz0VsbhiVoed_ucOOBffzr4c6XNPwATf75iSpwOQBgGgBgKAB4S6_ZICiAcBkAcCqAfVyRuoB_DZG6gH8tkbqAeUmLECqAel3xuoB47OG6gHk9gbqAe6BqgH7paxAqgHpr4bqAfs1RuoB_PRG6gH7NUbqAeW2BvYBwHSCAYIABACGBqxCbti1ahctkLJgAoBmAsByAsB2BMD&ae=1&num=1&cid=CAMSeQClSFh3ge_xB-_OUZAMZ4lAoBTm5vKt0a0ssJOo9iQepWUO8CuBvm6rttG9n6yA5ogSHh2tBIgVSK4YSD1TSQMQBB35ujVSUuHE40aKqOtK1zFEgTYZ3TO1gzPFD56wK33WlGTiH9vQGnbpm3FROc2iWHgKf_mr7l8&sig=AOD64_2EOndYAzxjpeoNDi1wjH6O0X_S2A&client=ca-pub-3465543440750523&nb=17&adurl=https://exam.ncnu.edu.tw/GTran.html)

![[./_resources/Mac_出现无故唤醒_com.apple.alarm.user-invisible_是什么东西？_-_V2EX.resources/embedded.svg]]

![[./_resources/Mac_出现无故唤醒_com.apple.alarm.user-invisible_是什么东西？_-_V2EX.resources/embedded.1.svg]]

    Created at: 2020-12-28T09:32:46+08:00
    Updated at: 2020-12-28T09:32:46+08:00


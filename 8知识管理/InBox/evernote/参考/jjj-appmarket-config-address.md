
mysql> select \* from api\_info where org\_code='010000000000' and api\_address like '%4399%';

|     |     |     |     |     |
| --- | --- | --- | --- | --- |
| 部平台CODE | API-CODE | 描述  | 旧访问地址 | 替换访问地址 |
| 010000000000 | IF-MAM-SVC-01 | 获取应用简项信息列表 | <http://10.2.120.158:4399/appmarket/v1/getApps.do> | [http://10.2.120.214:10014/appmarket/v1/getApps.do](http://10.2.120.158:4399/appmarket/v1/getApps.do) |
| 010000000000 | IF-MAM-SVC-02 | 获取应用详情列表 | <http://10.2.120.158:4399/appmarket/v1/getAppInfo.do> | [http://10.2.120.214:10014/appmarket/v1/getAppInfo.do](http://10.2.120.158:4399/appmarket/v1/getAppInfo.do) |

    Created at: 2019-12-10T14:08:28+08:00
    Updated at: 2019-12-10T15:23:07+08:00


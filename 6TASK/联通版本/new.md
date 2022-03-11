![[新老应用发布合并#联通升级]]


mysql> use ass_depmon_es;
+----------------------------------+-------------------------------+----------------+
| id                               | kaf_topic                     | kaf_msg_offset |
+----------------------------------+-------------------------------+----------------+
| 40288b0c7abe59ee017ac2e1b2890020 | police_sync_device            |             42 |
| 40288b0c7ac2fdcf017ac392dd97000c | ass_sync_app_download_install |            141 |
| 40288b0c7ac2fdcf017ac6b5e8340018 | ass_sync_app_version          |             83 |
| 40288b0c7ac2fdcf017ac6b61564001a | ass_sync_app                  |             84 |
+----------------------------------+-------------------------------+----------------+

mysql> use ass_app_market
+----------------------------------+----------------------+----------------+
| id                               | kaf_topic            | kaf_msg_offset |
+----------------------------------+----------------------+----------------+
| 40288b0c7abe5963017abe598f270003 | police_sync_org      |             19 |
| 40288b0c7ac2fcf1017ac6b5e8a2000b | ass_sync_app_version |             83 |
| 40288b0c7ac2fcf1017ac6b615690012 | ass_sync_app         |             84 |
+----------------------------------+----------------------+----------------+

需要使用depmon数据库的ass_sync_app_download_install

mysql> use ass_base;
+----------------------------------+---------------------------+----------------+
| id                               | kaf_topic                 | kaf_msg_offset |
+----------------------------------+---------------------------+----------------+
| 40288b0c7abe5872017abe587fc2000d | police_sync_user          |             46 |
| 40288b0c7abe5872017abe5880fa000e | police_sync_admin         |            197 |
| 40288b0c7abe5872017abe5880ff000f | police_sync_org           |             19 |
| 40288b0c7abe5872017abe8bd929003d | pekall_sync_org_conf      |             34 |
| 40288b0c7abe5872017ac2df1dc60089 | police_sync_code_level    |              2 |
| 40288b0c7abe5872017ac2dfb06c008c | police_sync_code_position |              4 |
+----------------------------------+---------------------------+----------------+

group_id 不能随便改变传递
## 结论
appmanage 使用ass_app_manage  这个group
market使用ass_market  这个group
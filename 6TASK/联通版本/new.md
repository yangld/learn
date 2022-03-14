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
需要使用depmon数据库的ass_sync_app_download_install


--- 

select distinct object_id, sm.`code` from uni_auth_authorization u , uni_auth_app a, service_code_package_map sm

where u.app_id = a.id and a.app_package = sm.package_name and u.app_type_code='web' and authorize_user_org_name not like '%\_0\_%';


select distinct  a.app_package from uni_auth_authorization u , uni_auth_app a

where u.app_id = a.id  and u.app_type_code='web' and authorize_user_org_name not like '%\_0\_%';


--- 


SELECT DISTINCT
	108,
	u.com_id,
	u.op_tenant_id,
	concat( u.NAME, '角色' ) role_name,
	0,
	'test',
	o2.id create_user_org_id,
	substring( o2.NAME, 12 ) create_user_org_name,
	u.create_user_id create_user_id,
	u2.NAME creaet_user_name,
	now() create_time,
	now() update_time 
FROM
	mdm_user u,
	uni_auth_authorization a,
	mdm_org o,
	mdm_org o2,
	mdm_user u2 
WHERE
	u.org_code = o.id 
	AND u.id = a.object_id 
	AND a.app_type_code = 'web' 
	AND authorize_user_org_name NOT LIKE '%_0__%' 
	AND a.manage_org_id = o2.id 
	AND u.create_user_id = u2.id 
	AND u.create_user_id IS NOT NULL;
--- 

--- 
	
SELECT DISTINCT
	u.com_id,
	u.op_tenant_id,
	u.id user_id,
 	u.account,
 	u.NAME user_name,
 	u.mobile_phone,
	o.id user_org_id,
	substring( o.NAME, 12 ) user_org_name,
	o2.id manage_org_id,
	substring( o2.NAME, 12 ) manage_org_name,
	u.create_user_id create_user_id,
	u2.name,
	now() create_time,
	now() update_time,
	0 can_edit 
FROM
	mdm_user u,
	uni_auth_authorization a,
	mdm_org o,
	mdm_org o2, 
	mdm_user u2
WHERE
	u.org_code = o.id 
	AND u.id = a.object_id 
	AND a.app_type_code = 'web' 
	AND authorize_user_org_name NOT LIKE '%_0__%' 
	AND a.manage_org_id = o2.id 
	and u.create_user_id = u2.id
	and u.create_user_id is not null;
	
	
	-- 0c8b2dd0db474dc78419ae95b071f9d5


---

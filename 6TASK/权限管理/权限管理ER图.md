## ER图
```mermaid
erDiagram
	TENANT					||--|| ORG_CONFIG			   : ont-to-one
	TENANT					||--|{ SERVICE_INFO			   : ont-to-many
    ORG_CONFIG  			||--|{ FINE_AUTH_PERM_RELATION : one-to-many
    SERVICE_INFO     		||--|{ FUNCTION     		   : ont-to-many
	SERVICE_INFO     		}|--|| FINE_AUTH_PERM_RELATION : many-to-one
	SERVICE_INFO     		}|--|| SERVICE_CODE_PAC_MAP : many-to-one
    FUNCTION    			}|--|| FINE_AUTH_PERM_RELATION : many-to-one
	FINE_AUTH_ADMIN        	}|--|{ FINE_AUTH_ROLE   	   :many-to-many
	FINE_AUTH_ROLE        	}|--|{ FINE_AUTH_PERM   	   :many-to-many
	FINE_AUTH_ADMIN        	||--|| MDM_USER   			   : one-to-one
	MDM_USER    			||--|{ UNI_AUTH_AUTHORIZATION  : ont-to-many
	UNI_AUTH_AUTHORIZATION 	}|--|| UNI_AUTH_APP      	   : many-to-one
    FINE_AUTH_PERM_RELATION ||--|| FINE_AUTH_PERM          : one-to-one
	UNI_AUTH_APP     		}|--|| SERVICE_CODE_PAC_MAP    : many-to-one
	SERVICE_CODE_PAC_MAP  	||--|| FINE_AUTH_PERM_RELATION : one-to-one
	FINE_AUTH_ROLE        	||--|{ FINE_AUTH_RECORD   	   : one-to-many 
	
	FINE_AUTH_RECORD {
		string user_id
		string role_id
		string manage_org_id
	}
	
	UNI_AUTH_AUTHORIZATION {
	    string user_id
        string app_id
    }
	MDM_USER {
	    string id
        string account
    }
	UNI_AUTH_APP {
	    string id
        string app_package
		string def_code_real
    }
	SERVICE_CODE_PAC_MAP {
        string code
		string package_name
    } 
	FINE_AUTH_ADMIN {
        string id
		string user_account
		string op_tenant_id
    } 
    ORG_CONFIG {
        string id
		string func_ids
		string nop_tenant_id
    } 
	SERVICE_INFO {
        string id
		string code
		string tenant_id
    }
    FUNCTION {
        string id
		string code
		string tenant_id
    }
    FINE_AUTH_PERM {
        long id
        string module
        string category
        string menu
        string code
        string name
        string type
		long   seq
    }
    FINE_AUTH_PERM_RELATION {
        string id
		string type
        string type_code
        long FINE_AUTH_PERM_id
    }
    FINE_AUTH_ROLE {
        long id
		string tennant_id
    }
```

## 说明
1. 系统初始化的时候
	1. 初始化FINE_AUTH_PERM,FINE_AUTH_PERM_RELATION
2. 后续增加按钮,菜单等权限控制信息的时候
	1. 需要增加对应的FINE_AUTH_PERM,FINE_AUTH_PERM_RELATION
	2. 对于老租户, 需要手动触发租户的变更, 才会把新增的权限同步到租户管理员上
	3. 租户下的其它管理员不会拥有新增的权限, 需手动添加
3. 租户创建和修改时
	1. 创建或更新对应的fine_auth_admin和fine_auth_role(系统角色)
	2. 创建和更新admin和role
	3. 创建和更新role和perm的关系
		1. tenant >> service_info >> fine_auth_perm_relation >> fine_auth_perm
		2. tenant >> service_info >> function >> fine_auth_perm_relation >> fine_auth_perm
		3. tenant >> org_config >> fine_auth_perm_relation >> fine_auth_perm
	3. 创建和更新对应的uni_auth_authorization记录
		1. fine_auth_perm >> fine_auth_perm_relation >> service_info >> service_code_pac_map >> uni_auth_app
		2. fine_auth_perm >> fine_auth_perm_relation >> org_config(func_ids)  >> uni_auth_app 
4.  增加服务,功能时
	1.  如果需要权限控制, 参考2
5.   删除服务,功能时
		1.    也需要删除对应的信息 
6.   创建系统管理员
		1.   uasadmin, opadmin, cdsadmin等系统管理员
		2.   手动创建管理员,角色,及管理员角色关系, 角色权限关系
7.   创建普通角色和管理员
		1.   web端返回, 租户管理员对应的权限列表
		2.   选择权限, 设置角色名称, 保存
		3.   选择用户, 选择角色, 生成管理员, 保存
8.   老用户管理员生成
		1.   mdm_user >> uni_auth_authorization >> uni_auth_app >> service_code_pac_map >> fine_auth_perm_relation >> fine_auth_perm
		2.   根据上面找到的权限, 生成角色, 绑定权限
		3.   生成管理员, 绑定角色


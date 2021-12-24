## ER图
```mermaid
erDiagram
	TENANT			||--o{ FUNCTIONID			: ont-to-many
	TENANT			||--o{ SERVICE				: ont-to-many
    FUNCTIONID  	||--|{ RIGHT_RELATION       : one-to-many
    SERVICE     	||--|{ FUNCTION     		: ont-to-many
	SERVICE     	||--|{ RIGHT_RELATION     	: ont-to-many
    FUNCTION    	||--|{ RIGHT_RELATION       : one-to-many
    ROLE        	}|--|{ RIGHT   				: many-to-many
    RIGHT_RELATION  }o--|| RIGHT        		: one-to-many
    FUNCTIONID {
        string id
		string code
    } 
	SERVICE {
        string id
		string code
    }
    FUNCTION {
        string id
        string service_id
    }
    RIGHT {
        long id
        string module
        string category
        string menu
        string code
        string name
        string type
		long   seq
    }
    RIGHT_RELATION {
        string id
		string type
        string type_code
        long right_id
    }
    ROLE {
        long id
    }
```

## 说明
- 系统初始化的时候, 会初始化right表,right_relation表-------
- 增加服务,功能的时候, 也需要增加对应的right_role表
- 删除服务,功能的时候, 也需要同步删除对应的right_role表
- 管理员创建角色时, 根据租户信息, 获取所有的权限, 然后根据当前系统, 过滤权限返回
- 删除角色, 需要删除对应的right_relation表
- right的type有read, write
- right_relation的type有funcId, func,service,role, type_code为关联表的code

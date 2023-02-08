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
	
	
	
	
    FINE_AUTH_PERM_RELATION ||--|| FINE_AUTH_PERM          : one-to-one
	UNI_AUTH_APP     		}|--|| SERVICE_CODE_PAC_MAP    : many-to-one
	SERVICE_CODE_PAC_MAP  	||--|| FINE_AUTH_PERM_RELATION : one-to-one
	 

	


	UNI_AUTH_APP {
	    string id
        string app_package
		string def_code_real
    }
	SERVICE_CODE_PAC_MAP {
        string code
		string package_name
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

```


```mermaid
erDiagram
	
	
   
    
	
	
    
	FINE_AUTH_ADMIN        	}|--|{ FINE_AUTH_ROLE   	   :many-to-many
	FINE_AUTH_ROLE        	}|--|{ FINE_AUTH_PERM   	   :many-to-many
	FINE_AUTH_ADMIN        	||--|| MDM_USER   			   : one-to-one
	MDM_USER    			||--|{ UNI_AUTH_AUTHORIZATION  : ont-to-many
	UNI_AUTH_AUTHORIZATION 	}|--|| UNI_AUTH_APP      	   : many-to-one
   
	
	
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

	FINE_AUTH_ADMIN {
        string id
		string user_account
		string op_tenant_id
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

    FINE_AUTH_ROLE {
        long id
		string tennant_id
    }
```



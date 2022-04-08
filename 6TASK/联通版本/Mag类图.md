## ER图
```mermaid
erDiagram

	Policy  		||--|| 	AppWhiteList 		:one-to-one
	Policy			||--|| 	IpRangeList 		:one-to-one
	Policy 			||--|| 	DeviceWhiteList 	:one-to-one
	Policy 			||--|| 	UserWhiteList 		:one-to-one
	Policy 			||--|| 	ResourcePolicyRel 	:one-to-one
	
	Resource		||--|| 	ResourcePolicyRel 	:one-to-one
	Resource		||--|| 	Endpoint 			:one-to-one
	
	AppItem 		||--|| 	AppWhiteList 		:one-to-one
	UserWhiteList 	||--|| 	UserInfo 			:one-to-one
	UserInfo 		||--|| 	DeviceInfo 			:one-to-one

	DeviceWhiteList	||--|| 	DeviceInfo 			:one-to-one
	IpRangeList		||--|| 	Listener 			:one-to-one
	IpRangeList		||--|| 	DataNode 			:one-to-one
	IpRangeList		||--|| 	Cluster 			:one-to-one

	Policy {
	    string id
		string name
		string userPolicy
		string devicePolicy
		string appPolicy
		string osPolicy
		string deviceStatPolicy
		string netTypePolicy
		string ipRangePolicy
    }
	
	UserWhiteList {
	    string id
		string user_id
		string account
		string policyId
	}
	
	ResourcePolicyRel {
	    string id
        string resourceId
		string policyId
    }
	
	DeviceWhiteList {
        string id
		string deviceId
		string policyId
    }
	
	IpRangeList {
        string id
		string policyId
		string ip
		string port
    } 
	
	AppWhiteList {
        string id
		string appId
		string policyId
    }
	
	UserInfo {
	    string id
        string account
		string orgId
		string status
		string magStatus
    }
	
	AppItem {
        string id
		string name
		string category
		string appId
		string accessStat
    }
	
	Resource {
        string id
		string name
		string policyStat
    } 
	
	DeviceInfo {
        string id
        string deviceUuid
		string userId
		string orgId
		string status
		string magStatus
    }
	
	Listener {
        string id
		string name
		string address
		string port
    } 

	Endpoint {
        string id
		string resourceId
		string name
		string ip
		string port
    }

    DataNode {
        string id
		string name
		string hostname
		string address
		string port
    }
	
    Cluster {
        string id
		string hostname
		string address
		string port
    }
	
	SyncConfig {
	    string id
		string syncObject
		string syncType
		string syncInterval
		string configContent
		string syncStatus
    }
	
	Snapshot {
	    string id
		string version
    }
```

## 影响租户权限的因素和关系
1. 系统： 706， 联通， 标准版
2. 部署方式： 没有运维运营， 有运维没有运营， 都有， 影响客户端升级权限
3. 租户类型： CB， 普通
4. 租户级别： 是系统管理员，还是租户管理员
5. 没有一个地方，可以看到所有的菜单和权限
6. 没有一个地方，可以看到各个系统间有哪些不同
7. 

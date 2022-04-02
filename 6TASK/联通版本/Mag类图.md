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


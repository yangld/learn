## ER图
```mermaid
erDiagram
	MdmPolicyTemplate		||--|{ MdmDeviceInfo		: ont-to-many
	MdmPolicyTemplate		||--|{ WhiteGroupPolicy		: ont-to-many
	WhiteGroupPolicy		}|--|| WhiteGroupInfo		: many-to-one
    WhiteGroupInfo 			||--|{ BluetoothWhiteInfo	: ont-to-many 
	
	MdmPolicyTemplate {
		string controlGroupId
		string policyTemplateId
		string id
	}
	
	WhiteGroupPolicy {
	    string whiteGroupId
        string whiteGroupType
	    string policyId
        string policyGroupId
		string id
    }
	WhiteGroupInfo {
	    string groupType
        string name
		string description
    }
	BluetoothWhiteInfo {
	    string groupId
		string name
		string mac
    }
```

## 说明
1. 数据的变化对设备的影响
2. web端操作的变化对数据的影响
3. 模型-ER-接口-交互-已有模型的影响


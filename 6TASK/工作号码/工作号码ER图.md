## ER图
```mermaid
erDiagram
	MdmPolicyTemplate		||--|{ MdmDeviceInfo		: ont-to-many
	MdmPolicyTemplate		||--|{ BluetoothWhiteGroupPolicy		: ont-to-many
	BluetoothWhiteGroupPolicy		}|--|| BluetoothWhiteGroupInfo		: many-to-one
    BluetoothWhiteGroupInfo 			||--|{ BluetoothWhiteInfo	: ont-to-many 
	
	MdmPolicyTemplate {
		string controlGroupId
		string policyTemplateId
		string id
	}
	
	BluetoothWhiteGroupPolicy {
	    string bluetoothWhiteGroupId
	    string policyId
        string policyGroupId
		string id
    }
	BluetoothWhiteGroupInfo {
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
1. 接口
	1. 获取蓝牙白名单组分页信息
		1. BluetoothWhiteGroupInfo
	2. 获取蓝牙白名单组信息
		1. BluetoothWhiteGroupInfo， BluetoothWhiteInfo数量
	3. 添加蓝牙白名单组
		1. BluetoothWhiteGroupInfo
	4. 更新蓝牙白名单组
		1. BluetoothWhiteGroupInfo
	5. 删除蓝牙白名单组
		1. BluetoothWhiteGroupInfo， BluetoothWhiteGroupPolicy， MdmNewPolicyTemplate， 判断是否有策略
		2. 删除BluetoothWhiteGroupInfo， BluetoothWhiteInfo
	6. 获取蓝牙白名单分页信息
		1. BluetoothWhiteInfo
	7. 获取蓝牙白名单信息
		1. BluetoothWhiteInfo
	8. 添加蓝牙白名单
		1. BluetoothWhiteGroupInfo， BluetoothWhiteInfo
		2. 分发设备
	9. 更新蓝牙白名单
		1. 	BluetoothWhiteGroupInfo， BluetoothWhiteInfo
		2. 分发设备
	10. 删除蓝牙白名单（支持批量删除）
		1. 	BluetoothWhiteGroupInfo， BluetoothWhiteInfo
		2. 分发设备
	11. 获取蓝牙白名单汇总分页信息
		1. BluetoothWhiteTotalInfo
	12. 检查导入文件
		1. BluetoothWhiteGroupInfo,BluetoothWhiteInfo
	13. 批量导入
		1. 	BluetoothWhiteGroupInfo,BluetoothWhiteInfo
		2. 分发设备
	14. ActionHistoryAop
		1. 记录日志
		2. BluetoothWhiteLogger
		3. BluetoothWhiteGroupVo
		4. BluetoothWhiteClientVo
	15. 获取蓝牙白名单分页信息
		1. MdmDeviceInfo   ， BluetoothWhiteInfo
	16. 添加策略
		1. MdmNewPolicyTemplate， BluetoothWhiteGroupPolicy
		2. updateBluetoothWhitePolicy
	17. 修改策略
		1. MdmNewPolicyTemplate， BluetoothWhiteGroupPolicy
		2. updateBluetoothWhitePolicy
	18. 命令
		1. NewUpdateBluetoothWhiteCommand
2. 新增功能对现有模型的影响
	1. 策略内容和策略表中都增加是否开启亲情号码字段
		1. 新增和修改策略
	2. 新增工作号码组策略，记录策略和工作号码组的关系
		1. 新增和修改策略
	3. 新增工作号码组
	4. 新增工作号码

3. web端操作的变化对数据的影响
4. 模型-ER-接口-交互-已有模型的影响

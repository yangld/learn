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
1. 数据的变化对设备的影响
2. web端操作的变化对数据的影响
3. 模型-ER-接口-交互-已有模型的影响
4. web接口
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
		1. BluetoothWhiteGroupInfo， BluetoothWhiteInfo
	13. 批量导入
		1. 	BluetoothWhiteGroupInfo， BluetoothWhiteInfo
		2. 分发设备
	14. 
5. 相关接口
	1. 安卓策略
		2. editPolicy-->newPolicyService.editPolicy-->updatePolicyRelations-->updateBluetoothWhitePolicy
		3. addPolicy-->newPolicyService.addPolicy-->updatePolicyRelations-->updateBluetoothWhitePolicy
	2. 蓝牙白名单组
		1. deleteBluetoothWhiteGroupInfos-->deleteBluetoothWhiteGroups-->
			1. bluetoothWhiteGroupInfoManager.getBluetoothWhiteGroupInfosByIds
			2. bluetoothWhiteGroupPolicyManager.getPolicyIdsByBluetoothWhiteGroupId
		2. getBluetoothWhiteGroupInfo-->bluetoothWhiteGroupInfoManager.getR
		3. addBluetoothWhiteGroupInfo-->bluetoothWhiteGroupInfoManager.saveW
		4. updateBluetoothWhiteGroupInfo-->bluetoothWhiteGroupInfoManager.saveW
		5. addBluetoothWhiteInfo-->bluetoothWhiteGroupInfoManager.getR
		6. updateBluetoothWhiteInfo-->bluetoothWhiteGroupInfoManager.getR
		7. deleteBluetoothWhiteInfos-->bluetoothWhiteGroupInfoManager.getR
		8. uploadFile-->bluetoothWhiteGroupInfoManager.getR
		9. addBatch-->bluetoothWhiteGroupInfoManager.getR
		10. addRestfulApiLog-->mdmActionHistoryService.logOperationRecord
		11. deleteBluetoothWhiteGroupInfos-->bluetoothWhiteService.deleteBluetoothWhiteGroups-->bluetoothWhiteGroupInfoManager.getBluetoothWhiteGroupInfosByIds
	3. 蓝牙白名单
		5. addBatch-->dispatchDevices-->bluetoothWhiteGroupPolicyManager.getPolicyIdsByBluetoothWhiteGroupId
		6. deleteBluetoothWhiteInfos-->dispatchDevices-->bluetoothWhiteGroupPolicyManager.getPolicyIdsByBluetoothWhiteGroupId
		7. updateBluetoothWhiteInfo-->dispatchDevices-->bluetoothWhiteGroupPolicyManager.getPolicyIdsByBluetoothWhiteGroupId
		8. addBluetoothWhiteInfo-->dispatchDevices-->bluetoothWhiteGroupPolicyManager.getPolicyIdsByBluetoothWhiteGroupId


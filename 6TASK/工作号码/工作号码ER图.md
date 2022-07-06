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
	1. 复用现在的模型表
		1. BluetoothWhiteGroupPolicy中增加类型， 蓝牙白名单组/工作号码组/亲情号码
		2. BluetoothWhiteGroupInfo中增加类型， 蓝牙白名单组/工作号码组/亲情号码
		3. 亲情号码也是一种组，组名称和描述为用户名和姓名
		4. 工作号码和亲情号码，可以使用BluetoothWhiteInfo，name和mac可以对应姓名和用户名
	2. 增加新命令，用于通知设备亲情号码变更，工作号码变更
	3. 增加根据设备和组id获取工作号码的接口
	4. 增加获取亲情号码的接口
	5. 亲情号码
		1. 增加查询亲情号码接口，关联查询用户的姓名和用户名
			1. 直接根据管理员管辖机构，查询亲情号码组，亲情号码，用户，返回数据
		2. 增加和导入时
			1. 如果没有组则创建组，有则在组下直接添加亲情号码
	6. 工作号码
		1. 扫帚形查询，当选择机构后，不查询扫帚把
3. 计划
	1. 修改原有代码，增加白名单类型，修改后，蓝牙白名单正常可用
	2. 编写新的controller接口，支持工作号码和亲情号码的接口
	3. 修改plist，支持添加和编辑策略
	4. 增加亲情号码和工作号码的命令
	5. 增加获取亲情号码和工作号码的接口
	6. 增加菜单和按钮相关权限
4. 疑问
	1. 是否需要创建者？
	2. 工作号码列表搜索条件是否需要联系人和电话号码？
	3. 不选择机构的时候， 需要查询上级的工作号码组，当选择机构的时候，如何处理？
5. 问题列表
	1. 


## 序列图
![[Sequence Diagram1.jpg]]

## ER图
```mermaid
erDiagram
	MdmPolicyTemplate	||--|{ MdmDeviceInfo		    : ont-to-many
	MdmPolicyTemplate	||--|{ BluetoothWhiteGroupPolicy: ont-to-many
	BluetoothWhiteGroupPolicy}|--|| BluetoothWhiteGroupInfo: many-to-one
    BluetoothWhiteGroupInfo ||--|{ BluetoothWhiteInfo	: ont-to-many
	
	MdmPolicyTemplate	||--|{ WorkTelWhiteGroupPolicy: ont-to-many
	WorkTelWhiteGroupPolicy}|--|| WorkTelWhiteGroupInfo: many-to-one
    WorkTelWhiteGroupInfo ||--|{ WorkTelWhiteInfo	: ont-to-many
	
	MdmPolicyTemplate	||--|{ FamTelWhiteGroupPolicy: ont-to-many
	
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
	
	WorkTelWhiteGroupPolicy {
	    string whiteGroupId
	    string policyId
        string policyGroupId
		string id
    }
	WorkTelWhiteGroupInfo {
        string name
		string description
    }
	WorkTelWhiteInfo {
	    string groupId
		string linkman
		string tel
    }
	
	FamTelWhiteGroupPolicy {
	    boolean useFamTel
	    string policyId
        string policyGroupId
		string id
    }
```

## 参考蓝牙白名单
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
	1. BluetoothWhiteGroupInfo， BluetoothWhiteInfo
	2. 分发设备
10. 删除蓝牙白名单（支持批量删除）
	1. BluetoothWhiteGroupInfo， BluetoothWhiteInfo
	2. 分发设备
11. 获取蓝牙白名单汇总分页信息
	1. BluetoothWhiteTotalInfo
12. 检查导入文件
	1. BluetoothWhiteGroupInfo,BluetoothWhiteInfo
13. 批量导入
	1. BluetoothWhiteGroupInfo,BluetoothWhiteInfo
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

## 新增功能
1. 新增功能：总共30个功能
	1. 工作号码同蓝牙白名单，供18个功能
	2. 工作号码同蓝牙白名单的区别
		1. 查询工作号码白名单组列表，需要返回父机构的白名单组
	3. 亲情号码，11个功能
	4. 权限管理，1个功能
2. 计划：开发时间共7天
	1. 编写web端新接口，供20个接口， 支持工作号码和亲情号码的接口：1天
	2. 修改plist，支持工作号码和亲情号码
	3. 增加亲情号码和工作号码的命令
	4. 增加获取亲情号码和工作号码的接口：1天
	5. 工作号码功能开发：1.5天
	6. 亲情号码功能开发：1.5天
	7. 增加菜单和按钮相关权限：1天
	8. 差缺补漏：1天
3. 疑问
	1. 是否需要创建者？不需要
	2. 工作号码列表搜索条件是否需要联系人和电话号码？会返回详情信息
	3. 不选择机构的时候， 需要查询上级的工作号码组，当选择机构的时候，如何处理？
		1. 选择机构后，只返回管辖范围内的
		2. 机构可以选择为空



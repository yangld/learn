## TT学习
### 录制信息
| 参数 | 描述 | 例子 |
| ---- | ---- | ---- |
| -t   | 后跟类名和方法名      |      |
| -n   |      |      |
| 表达式     |      |      |
### 检索信息
### 查看详情
1. -t 记录方法调用
	`tt -t -n 1com.pekall.mdm.restfulapi.service.impl.FineAuthServiceImpl deltt -t -n 1com.pekall.mdm.restfulapi.service.impl.FineAuthServiceImpl deleteRole`
1. -n 次数, 避免多次记录, 导致内存占满
	 `tt -t -n 3 com.pekall.mdm.restfulapi.service.impl.FineAuthServiceImpl deleteRole`
1. 表达式的使用
	1. 解决重载
	  `tt -t -n 1 *Test print params.length==1` 
	1. 指定参数类型
		`tt -t -n 1 *Test print params[1] instanceof Integer`
	1. 指定参数数值
		`tt -t -n 1 *Test print params[0].mobile="15800000000"`

3. -i 查看记录详情
4. `tt -i 1000`
5. -l 检索
6. `tt -l`
1. -s 搜索记录
2. `tt -s method.name=='deleteRole'`
3. -p 重做一次
4. `tt -i 1002 -p`
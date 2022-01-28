## TT学习
### 录制信息
| 参数   | 描述                     | 例子                                                |   
| ------ | ------------------------ | --------------------------------------------------- | 
| -t     | 后跟类名和方法名         | tt -t com.test.Test test                            |     
| -n     | 记录次数,避免溢出        | tt -n 3 -t com.test.Test test                       |   
| 表达式 | 过滤重载方法,参数,特定值 | tt -t *Test print params.length==1                |     |     |
|        |            参数              | tt -t *Test print params[1] instanceof Integer |    
|        |          特定值                |    tt -t *Test print params[0].mobile="15800000000"   |
### 检索信息
| 参数 | 描述 | 例子 |
| ---- | ---- | ---- |
| -l   | 检索记录列表     | tt -l      |
| -s   | 搜索记录     |  tt -s method.name=='deleteRole'    |
| -i   | 查看详情     | tt -i 1000     |
### 重放
| 参数 | 描述     | 例子           |
| ---- | -------- | -------------- |
| -p  | 重放 | tt -i 1000  -p |

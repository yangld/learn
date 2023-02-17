	任务: 
	项目: 
	阶段: 
	输入: 
	输出: 
	日期: 2023-02-17
	时间: 11:38
	截止日期: 

## 目标
目标版本： 6.0.16
现在版本： 3.2.12

## 过程
1. centos版本
	1. cat /etc/centos-release
2. gcc升级
	1. gcc -v
	2. yum install centos-release-scl
	3. yum install devtoolset-7-gcc*
	4. scl enable devtoolset-7 bash
3. 下载源码安装
	1. wget https://download.redis.io/releases/redis-6.0.16.tar.gz
	2. tar -zxvf redis-6.0.16.tar.gz
	3. cd redis-6.0.16
	4. make
	5. make install
4. 启动服务
	1. 拷贝配置文件到/etc/redis.conf
	2. 启动服务
		1. /usr/local/bin/redis-server /etc/redis.conf
	3. 测试
		1. redis-cli -a Pekallrds12#$

## 问题
1. 
2. 

## 参考
1. https://blog.csdn.net/cplvfx/article/details/116278895
2. https://redis.io/docs/getting-started/installation/install-redis-from-source/
3. 
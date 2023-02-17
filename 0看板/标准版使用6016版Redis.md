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
5. 修改配置
	1. 修改host，去掉sensential
	2. 重新部署uas
	3. 重新部署mdm
	4. 重新部署统一日志系统
	5. 重新部署新基础应用
	6. 重新部署三权分立
	7. 手动部署ios， 扩展服务，
	8. 手动部署应用市场

## 问题


## 参考
1. https://blog.csdn.net/cplvfx/article/details/116278895
2. https://redis.io/docs/getting-started/installation/install-redis-from-source/
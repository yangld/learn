1. 生成相关证书,并验证
	1. ![[ios.tar.gz]]
	2. openssl verify -CAfile cacert.crt server.crt
	3. openssl verify -CAfile cacert.crt client.crt
2. mysql配置相关证书
	1. /etc/my.cnf
	2. mysqld
		ssl-ca=/etc/mysql/cacert.crt
		ssl-cert=/etc/mysql/server.crt
		ssl-key=/etc/mysql/server.key
	3. client
		ssl-ca=/etc/mysql/cacert.crt
		ssl-cert=/etc/mysql/client.crt
		ssl-key=/etc/mysql/client.key
3. 创建测试用户ssl_test
	1. grant all on *.* to 'ssl_test'@'%' identified by 'Pekall12#$' require SSL;
4. 登录
	1. mysql --ssl-ca="/root/havessl/ios/cacert.crt" --ssl-cert="/root/havessl/ios/client.crt" --ssl-key="/root/havessl/ios/client.key" -ussl_test -p -h 192.168.11.153
	2. 
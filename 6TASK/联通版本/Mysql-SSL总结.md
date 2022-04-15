
## 总结
1. mysql支持使用ssl
	1. 生成根证书，服务端证书，客户端证书![[cert.sh]]
	2. 生成证书时，客户端证书和服务端证书的cn需要配置成对应的ip，根证书的cn使用默认值即可
	3. 将证书放到固定位置，在my.cnf中配置![[copy.sh]]
		```
		ssl-ca=/var/lib/mysql/ca.pem
		ssl-cert=/var/lib/mysql/server-cert.pem
		ssl-key=/var/lib/mysql/server-key.pem
		require_secure_transport=ON
		```
	4. 重启mysql
	5. 服务的配置, keystoremysql和truststoremysql的生成逻辑在![[cert.sh]]
		```
		mysql_connection_url=jdbc:mysql://127.0.0.1:3306/download_server
		?serverTimezone=GMT&useUnicode=true
		&characterEncoding=utf-8
		&useSSL=true
		&verifyServerCertificate=true
		&requireSSL=true
		&clientCertificateKeyStoreUrl=file:/root/mysql-ssl/keystoremysql
		&clientCertificateKeyStorePassword=pekall1234
		&trustCertificateKeyStoreUrl=file:/rot/mysql-ssl/truststoremysql
		&trustCertificateKeyStorePassword=pekall1234
		&autoReconnect=true&failOverReadOnly=false
		&secondsBeforeRetrySource=0&queriesBeforeRetrySource=0
		```
	6. 重启服务
	7. 当my.cnf不使用sock，而是使用tcp时，且数据库和服务在同一个机器上
		1. 配置my.cnf        
			```
			[mysqld]
			#socket=/var/lib/mysql/mysql.sock
			
			[client] 
			protocol=tcp
			```
		2. 重启mysql服务
		3. 修改服务的配置, 只需要修改useSSL为true即可
			```mysql_connection_url=jdbc:mysql://192.168.9.36:3306/download_server?serverTimezone=GMT&useUnicode=true&characterEncoding=utf-8&useSSL=true&autoReconnect=true&failOverReadOnly=false&secondsBeforeRetrySource=0&queriesBeforeRetrySource=0```
		
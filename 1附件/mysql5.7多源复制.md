	卸载
		https://blog.csdn.net/u012329294/article/details/80561532
		yum remove  mysql mysql-server mysql-libs mysql-server
		rpm -ev mysql-community-embedded-5.7.40-1.el7.x86_64
		rpm -ev mysql-community-embedded-compat-5.7.40-1.el7.x86_64
		rpm -ev mysql-community-common-5.7.40-1.el7.x86_64
		rm -f /etc/my.cnf
		rpm -qa|grep mysql
	下载
	安装
	启动
	配置
	主服务配置
	从服务配置
	统计需要修改的数据库及配置文件


	下载
		wget https://cdn.mysql.com//Downloads/MySQL-5.7/mysql-5.7.40-linux-glibc2.12-x86_64.tar.gz
	安装
		
	配置
		从主服务器导出数据库
		 mysqldump -uroot -ppekall1234 --master-data=2 --single-transaction --databases  --add-drop-database  uni_auth  >uni_auth.sql
		 在从数据库中导入数据
		  mysql -uroot -pPekall12#$ < ~/uni_auth.sql
		  创建复制账号
		  grant replication slave on *.* to 'repl'@'192.168.10.130' identified by '123456';
		  配置从服务
		  my.cnf
		  master_info_repository=TABLE
		  relay_log_info_repository=TABLE
		  找到binlog位置
		  [root@Slave mysql]# cat xuanzhi.sql |grep " CHANGE MASTER"
-- CHANGE MASTER TO MASTER_LOG_FILE='Master_1-bin.000001', MASTER_LOG_POS=1539;
[root@Slave mysql]# cat xuanzhi_2.sql |grep " CHANGE MASTER"
-- CHANGE MASTER TO MASTER_LOG_FILE='Master_2-bin.000003', MASTER_LOG_POS=630;
[root@Slave mysql]# 
		  启动从服务,可配置多个
		  CHANGE MASTER TO MASTER_HOST='192.168.11.153',MASTER_USER='root', MASTER_PASSWORD='pekall1234',MASTER_LOG_FILE='mysql-bin.000480',MASTER_LOG_POS=3069 FOR CHANNEL 'Master_153’;
		  查看从服务
		  SHOW SLAVE STATUS FOR CHANNEL 'Master_1'\G
		  SELECT * FROM performance_schema.replication_connection_status; 

	主服务
		my.cnf
		server-id=991
		binlog_do_db=uni_auth
		
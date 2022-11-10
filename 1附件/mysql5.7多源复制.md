	卸载
		https://blog.csdn.net/u012329294/article/details/80561532
		yum remove  mysql mysql-server mysql-libs mysql-server
		rpm -ev mysql-community-embedded-5.7.40-1.el7.x86_64
		rpm -ev mysql-community-embedded-compat-5.7.40-1.el7.x86_64
		rpm -ev mysql-community-common-5.7.40-1.el7.x86_64
		rm -f /etc/my.cnf
		rpm -qa|grep mysql
	下载
		wget https://cdn.mysql.com//Downloads/MySQL-5.7/mysql-5.7.40-1.el7.x86_64.rpm-bundle.tar
	安装
		rm -rf /var/run/mysqld
	    mkdir /var/run/mysqld
	    chmod 777 /var/run/mysqld
		rpm  -ivh mysql-community-common-5.7.40-1.el7.x86_64.rpm
		rpm -ivh mysql-community-libs-5.7.40-1.el7.x86_64.rpm
		rpm -ivh mysql-community-client-5.7.40-1.el7.x86_64.rpm
		rpm -ivh mysql-community-server-5.7.40-1.el7.x86_64.rpm
		systemctl start mysqld.service
		systemctl status mysqld.service
		grep 'temporary password' /var/log/mysqld.log 
		mysql_secure_installation 
		mysql -uroot -p'Pekall12#$' -e "GRANT ALL PRIVILEGES ON *.* TO 'pekall'@'127.0.0.1' IDENTIFIED BY 'Apple12#$' WITH GRANT OPTION;"
	    mysql -uroot -p'Pekall12#$' -e "GRANT ALL PRIVILEGES ON *.* TO 'pekall'@'localhost' IDENTIFIED BY 'Apple12#$' WITH GRANT OPTION;"
	    mysql -uroot -p'Pekall12#$' -e "GRANT ALL PRIVILEGES ON *.* TO 'pekall'@'%' IDENTIFIED BY 'Apple12#$' WITH GRANT OPTION;"
	    mysql -uroot -p'Pekall12#$' -e "GRANT ALL PRIVILEGES ON *.* TO 'pekall'@'mdm' IDENTIFIED BY 'Apple12#$' WITH GRANT OPTION;"
	    mysql -uroot -p'Pekall12#$' -e "GRANT ALL PRIVILEGES ON *.* TO 'pekall'@'uas' IDENTIFIED BY 'Apple12#$' WITH GRANT OPTION;"
	    mysql -uroot -p'Pekall12#$' -e "GRANT ALL PRIVILEGES ON *.* TO 'pekall'@'unilog' IDENTIFIED BY 'Apple12#$' WITH GRANT OPTION;"
	    systemctl enable mysqld.service
	启动
		systemctl start mysqld.service
		systemctl status mysqld.service
		systemctl enable mysqld.service
		systemctl stop mysqld.service
	配置
		 show variables like '%validate_password%';    
		 show variables like '%timeout%';
		 ## SET wait_timeout = 14400;
		 show variables like '%connection%control%';
		 INSTALL PLUGIN connection_control SONAME 'connection_control.so';
		 ## SET GLOBAL connection_control_max_connection_delay = 86400;
		 show variables like '%have_ssl%';   
		 select user,host from mysql.user;           
		 update mysql.user set host=192.168.11.37 where user='pekall' and host='%';
		 
		 interactive_timeout=14400
		 wait_timeout=14400
		 connection_control_max_connection_delay=86400000
		 server_id=1000
		 master_info_repository=TABLE
		 relay_log_info_repository=TABLE
		 binlog-do-db=mdm_reactor1
		 binlog-do-db=mdm_reactor2
	主服务
		导出数据
		mysqldump -uroot -ppekall1234 --master-data=2 --single-transaction --databases  --add-drop-database  uni_auth  > uni_auth.sql
	从服务
		mysql -uroot -pPekall12#$ < ~/uni_auth.sql
		cat uni_auth.sql |grep " CHANGE MASTER"
			-- CHANGE MASTER TO MASTER_LOG_FILE='mysql-bin.000481', MASTER_LOG_POS=120;
		CHANGE MASTER TO MASTER_HOST='192.168.11.153',MASTER_USER='root', MASTER_PASSWORD='pekall1234',MASTER_LOG_FILE='mysql-bin.000481',MASTER_LOG_POS=120 FOR CHANNEL 'Master_153';
		start slave for channel 'master_153';
		show slave status for channel 'master_153'\G
		SELECT * FROM performance_schema.replication_connection_status;
	统计需要修改的数据库及配置文件
		rsync同步
			安装
			配置
			启动
		配置文件
		 mkdir -p /opt/config_bakcup/uni_auth
		 cp -rf /apps/uni_auth/config/ /opt/config_backup/uni_auth/
		 cp -rf /apps/uni_auth/cert /opt/config_backup/uni_auth/
		 mkdir -p /opt/config_backup/mdm
		 cp -rf /apps/pekall/config /opt/config_backup/mdm/
		 cp -rf /apps/pekall/cert /opt/config_backup/mdm/
		 mkdir -p /opt/config_backup/web/admin
		 cp /apps/web/admin/js/deploy-config.js /opt/config_backup/web/admin
		mkdir -p /opt/config_backup/web/uni_auth
		 cp /apps/web/uni_auth/web/js/deploy-config.js /opt/config_backup/web/uni_auth/
		  mkdir -p /opt/config_backup/service/ana
		 cp -rf /apps/pekall/service/appRunMonitorAnalyse/config/ /opt/config_backup/service/coll
		  mkdir -p /opt/config_backup/service/coll
		 cp -rf /apps/pekall/service/appRunMonitorCollection/config/ /opt/config_backup/service/run
		  mkdir -p /opt/config_backup/service/run
		 cp -rf /apps/pekall/service/runtime_diagram/config/ /opt/config_backup/service/run
		  mkdir -p /opt/config_backup/service/unilog
		 cp -rf /apps/pekall/service/unilog/config/ /opt/config_backup/service/unilog
		   mkdir -p /opt/config_backup/nginx
		  cp -rf /etc/nginx/conf.d /opt/config_backup/nginx/
		  cp -rf /etc/nginx/mdm /opt/config_backup/nginx/
		  cp -rf /etc/nginx/nginx.conf /opt/config_backup/nginx/
	问题列表
		数据库同名的问题,修改数据库名

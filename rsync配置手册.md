	rsync卸载和安装
		rpm -qa |grep rsync
		rpm -ev rsync-3.0.6-9.el6_4.1.x86_64 --nodeps
		rpm -ivh rsync-3.0.6-12.el6.x86_64.rpm
	主服务配置和启动
		rsyncd.conf
```
log file = /var/log/rsyncd.log
pidfile = /var/run/rsyncd.pid
lock file = /var/run/rsync.lock
secrets file = /etc/rsyncd.password
port = 5873

[sync_uas1]
	path = /apps/
	comment = sync uas data
	uid = root
	gid = root
	ignore errors
	use chroot = no
	read only = no
	list = no
	max connections = 200
	timeout = 600
	auth users = root
	hosts allow = 192.168.100.197
	exclude = lost+found upload_data* *bak* *bk work *war* *jar* *log*

[sync_uas2]
        path = /etc/nginx/
        comment = sync nginx
        uid = root
        gid = root
        ignore errors
        use chroot = no
        read only = no
        list = no
        max connections = 200
        timeout = 600
        auth users = root
        hosts allow = 192.168.100.197
```
		rsyncd.password
```
root:pekall12#$
```
		 复制到/etc/目录下
		 启动
			 /usr/bin/rsync --daemon
			 ps -ef | grep rsync
			 kill -9 12412
			 rm -f /var/run/rsyncd.pid
			 tail -f /var/log/rsyncd.log
	 从服务配置和定时任务启动
		vim /opt/rsync.password
		pekall12#$
		mkdir -p /data/153/apps
		mkdir -p /data/153/nginx
		chmod 600 /opt/rsync.password
		crontab -e
```
*/5 * * * *  rsync -avH --port 5873 --delete root@192.168.11.153::sync_uas1 /data/153/apps --password-file=/opt/rsync.password
*/5 * * * *  rsync -avH --port 5873 --delete root@192.168.11.153::sync_uas2 /data/153/nginx --password-file=/opt/rsync.password
```
		service  crond   restart
		
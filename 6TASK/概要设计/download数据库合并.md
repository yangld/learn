1. 导出应用管理中download的数据, 生成file_info1.sql文件
mysql -upekall -pApple12#$ -hdownload.pekall.com download_server -e "drop table if exists file_infos_bak"
mysql -upekall -pApple12#$ -hdownload.pekall.com download_server -e "create table file_infos_bak select * from file_infos"
mysql -upekall -pApple12#$ -hdownload.pekall.com download_server -e "alter table file_infos_bak drop column id"
mysqldump -upekall -pApple12#$ --no-create-info -hdownload.pekall.com download_server file_infos_bak > file_infos1.sql
sed -i -e 's/INSERT INTO `file_infos_bak`/insert into `file_infos`(auth_id,uuid,file_name,file_size,time,content_type,use_fzzs,fzzs_type,reason)/g' file_infos1.sql
2. 将file_infos.sql导入mdm的download数据库
mysql -upekall -pApple12#$ -hdownload.pekall.com download_server < file_infos1.sql
3. 合并upload_data文件
4. 将应用管理的download的数据库配置成mdm的download数据库
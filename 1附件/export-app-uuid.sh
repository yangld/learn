mysql -umanage_db_user -pPekalldb12#$ ass_app -h mysql.ass.pekall.com -P 6612 -e "select distinct file_uuid from ass_package" > pac_file.txt
mysql -umanage_db_user -pPekalldb12#$ ass_app -h mysql.ass.pekall.com -P 6612 -e "select distinct icon from ass_package" > pac_icon.txt
mysql -umanage_db_user -pPekalldb12#$ ass_app -h mysql.ass.pekall.com -P 6612 -e "select distinct attachment from ass_package" > pac_att.txt
mysql -umanage_db_user -pPekalldb12#$ ass_app -h mysql.ass.pekall.com -P 6612 -e "select distinct ori_file_uuid from ass_package" > pac_ori.txt

mysql -umanage_db_user -pPekalldb12#$ ass_app -h mysql.ass.pekall.com -P 6612 -e "select distinct icon from ass_app_info" > app_icon.txt
mysql -umanage_db_user -pPekalldb12#$ ass_app -h mysql.ass.pekall.com -P 6612 -e "select distinct screen_shot from ass_app_info" > app_pic.txt
mysql -umanage_db_user -pPekalldb12#$ ass_app -h mysql.ass.pekall.com -P 6612 -e "select distinct video from ass_app_info" > app_video.txt

mysql -umanage_db_user -pPekalldb12#$ ass_app -h mysql.ass.pekall.com -P 6612 -e "select distinct key_store_uuid from ass_app_policy" > poy_key.txt
mysql -umanage_db_user -pPekalldb12#$ ass_app -h mysql.ass.pekall.com -P 6612 -e "select distinct security_policy_uuid from ass_app_policy" > poy_uuid.txt

mysql -umanage_db_user -pPekalldb12#$ ass_app -h mysql.ass.pekall.com -P 6612 -e "select distinct key_store_uuid from ass_key_store" > store_uuid.txt

mysql -umanage_db_user -pPekalldb12#$ ass_app -h mysql.ass.pekall.com -P 6612 -e "select distinct file_uuid from h5_info" > h5_file.txt
mysql -umanage_db_user -pPekalldb12#$ ass_app -h mysql.ass.pekall.com -P 6612 -e "select distinct icon from h5_info" > h5_icon.txt

mysql -umanage_db_user -pPekalldb12#$ ass_app -h mysql.ass.pekall.com -P 6612 -e "select distinct file_uuid from service_app_info" > svc_file.txt
mysql -umanage_db_user -pPekalldb12#$ ass_app -h mysql.ass.pekall.com -P 6612 -e "select distinct icon_uuid from service_app_info" > svc_icon.txt
mysql -umanage_db_user -pPekalldb12#$ ass_app -h mysql.ass.pekall.com -P 6612 -e "select distinct video_uuid from service_app_info" > svc_video.txt
mysql -umanage_db_user -pPekalldb12#$ ass_app -h mysql.ass.pekall.com -P 6612 -e "select distinct pic_uuid from service_app_info" > svc_pic.txt
mysql -umanage_db_user -pPekalldb12#$ ass_app -h mysql.ass.pekall.com -P 6612 -e "select distinct attach_uuid from service_app_info" > svc_att.txt

mysql -umarket_db_user -pPekalldb12#$ ass_app_market -h mysql.ass.pekall.com -P 6612 -e "select distinct icon from ass_app_market" > mar_icon.txt
mysql -umarket_db_user -pPekalldb12#$ ass_app_market -h mysql.ass.pekall.com -P 6612 -e "select distinct file_uuid from ass_app_market" > mar_file.txt
mysql -umarket_db_user -pPekalldb12#$ ass_app_market -h mysql.ass.pekall.com -P 6612 -e "select distinct screen_shot from ass_app_market" > mar_pic.txt
mysql -umarket_db_user -pPekalldb12#$ ass_app_market -h mysql.ass.pekall.com -P 6612 -e "select distinct video from ass_app_market" > mar_video.txt
mysql -umarket_db_user -pPekalldb12#$ ass_app_market -h mysql.ass.pekall.com -P 6612 -e "select distinct security_policy_uuid from ass_app_market" > mar_policy.txt


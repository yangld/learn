mysql -uop_db_user -pPekalldb12#$ cloud_operation_server -h 172.16.5.43 -P 6612 -e "select distinct file_uuid from app_info" > op_file.txt
mysql -uop_db_user -pPekalldb12#$ cloud_operation_server -h 172.16.5.43 -P 6612 -e "select distinct pic_uuid from app_info" > op_pic.txt
mysql -uop_db_user -pPekalldb12#$ cloud_operation_server -h 172.16.5.43 -P 6612 -e "select distinct video_uuid from app_info" > op_video.txt
mysql -uop_db_user -pPekalldb12#$ cloud_operation_server -h 172.16.5.43 -P 6612 -e "select distinct attach_uuid from app_info" > op_attach.txt
mysql -uop_db_user -pPekalldb12#$ cloud_operation_server -h 172.16.5.43 -P 6612 -e "select distinct icon_uuid from app_info" > op_icon.txt

mysql -uop_db_user -pPekalldb12#$ cloud_operation_server -h 172.16.5.43 -P 6612 -e "select distinct icon_uuid from service_info" > op_service_icon.txt

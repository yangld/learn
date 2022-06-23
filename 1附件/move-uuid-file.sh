cat op_service_icon.txt opi_file.txt op_icon.txt op_pic.txt op_video.txt op_attach.txt pac_file.txt pac_icon.txt pac_att.txt pac_ori.txt app_icon.txt app_pic.txt app_video.txt poy_key.txt poy_uuid.txt store_uuid.txt h6_file.txt h5_icon.txt svc_file.txt svc_icon.txt svc_video.txt svc_pic.txt svc_att.txt mar_icon.txt mar_file.txt mar_pic.txt mar_video.txt mar_policy.txt > test.txt
grep -v "^$" test.txt > test2.txt
cat test2.txt | sort -rn | uniq -c | awk -F ' ' '{print $2}' > test3.txt
cat test3.txt | while read line
do

    if [ "attach_uuid" == $line ] || [ "ori_file_uuid" == $line ] || [ "key_store_uuid" == $line ] || [ "video_uuid" == $line ] || [ "icon_uuid" == $line ] || [ "pic_uuid" == $line ] || [ "attachment" == $line ] || [ "video" == $line ] || [ "screen_shot" == $line ] || [ "security_policy_uuid" == $line ] || [ "file_uuid" == $line ] || [ "icon" == $line ] || [ "NULL" == $line ]; then
       continue;
    else
       #echo $line;
       arr=$(echo $line|tr "," "\n")
       for i in ${arr[@]}
       do
          echo $i
          mv $i ../temp
       done
    fi
done

rm -f policy.txt
mysql -upekall -pApple12#$ -h mgr1.mysql.pekall.com -P 6446 mdm_reactor -e "select name,description,id,com_id from mdm_new_policy_template" > policy.txt
./login.sh
cat policy.txt | while read line
do
 echo $line
 arr=(`echo $line | tr '\t' ' '`)
 echo ${arr[0]}
 echo ${arr[1]}
 echo ${arr[2]}
 echo ${arr[3]}
 body='{"name":"'${arr[0]}'","description":"'${arr[1]}'","templateId":"'${arr[2]}'"}'
 echo $body
 curl -k   --location --request PUT 'https://192.168.11.78:4432/adminweb/mdm/v1/new/policys/edit_policy' \
        --header 'Nop-Tenant-Id: 3' \
        --header 'Content-Type: application/json' \
        --header 'Pekall-Lang: zh-CN' \
        --cookie /tmp/cookie.txt \
        -d '{"name":"'${arr[0]}'","description":"'${arr[1]}'","templateId":"'${arr[2]}'"}'
done


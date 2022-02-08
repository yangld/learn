#!/usr/bin/env bash
set -xe

uas_url=https://192.168.11.78:4434
mdm_url=https://192.168.11.78:4432

username=yld01
password=pekall12#$

fullServiceName=HTTP/com.pekall.mdm.webapp
shortServiceName=${fullServiceName#HTTP/}
nopTenantId=7

# Nop-Tenant-Id: 8

login_ret=$(curl -i -k -s -X POST -d userName=${username} -d password=${password} \
  -H 'clientId:4ad8f0fd-de52-4221-a63f-903d1c4c5906' \
  -H 'Nop-Tenant-Id:7' \
  ${uas_url}/uni_auth/v1/login/loginIn|grep errorCode)

echo $login_ret|jq .

login_id=$(echo $login_ret|jq '.loginId'|sed 's/"//g')

ticket_ret=$(curl -i -k -s -G -X GET -d serviceName=${shortServiceName} -d loginId=$login_id \
${uas_url}/uni_auth/v1/login/ticket)
ticket=$(echo $ticket_ret|sed 's/^.*ticket":"\(.*\)"}/\1/')

echo $ticket

curl -i -k -s -c /tmp/cookie.txt -H "Authorization: $ticket" \
  ${mdm_url}/mdm/v1/enterprise_admin/login_user

curl -i -k -s -b /tmp/cookie.txt ${mdm_url}/mdm/v1/orgs/top?pageNum=1

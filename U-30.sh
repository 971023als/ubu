#!/bin/bash

 

. function.sh

 
TMP1=`SCRIPTNAME`.log

> $TMP1
 
 

BAR

CODE [U-30] Sendmail 버전 점검

cat << EOF >> $result

[양호]: Sendmail 버전이 최신버전인 경우 

[취약]: Sendmail 버전이 최신버전이 아닌 경우

EOF

BAR

# Sendmail이 실행 중인지 확인
sendmail_status=$(systemctl is-active sendmail)

if [ "$sendmail_status" == "active" ]; then
  INFO "전송 메일 서비스 중지 중"
  systemctl stop sendmail
else
  OK "메일 보내기 서비스가 이미 중지되었습니다."
fi





cat $result

echo ; echo
 

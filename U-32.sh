#!/bin/bash

. function.sh

BAR

CODE [U-32] 일반사용자의 Sendmail 실행 방지		

cat << EOF >> $result

[양호]: SMTP 서비스 미사용 또는, 일반 사용자의 Sendmail 실행 방지가 설정된
경우

[취약]: SMTP 서비스 사용 및 일반 사용자의 Sendmail 실행 방지가 설정되어 
있지 않은 경우

EOF

BAR

# Sendmail이 실행 중인지 확인
sendmail_status=$(systemctl stuatus sendmail)

if [ "$sendmail_status" == "active" ]; then
  INFO "전송 메일 서비스 중지 중"
  service stop sendmail
else
  OK "메일 보내기 서비스가 이미 중지되었습니다."
fi



cat $result

echo ; echo


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

# Sendmail 서비스 중지
sudo systemctl stop sendmail

# 부팅 시 Sendmail 서비스가 자동으로 시작되지 않도록 설정
sudo systemctl disable sendmail

# Sendmail 서비스가 성공적으로 비활성화되었는지 확인합니다
if [ $(sudo systemctl is-enabled sendmail) == "disabled" ]; then
  OK "Sendmail 서비스가 성공적으로 비활성화."
else
  WARN "Sendmail 서비스가 비활성화 실패."
fi




cat $result

echo ; echo
 

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
sudo service sendmail stop

# Sendmail 서비스가 중지되었는지 확인합니다
if [ $? -eq 0 ]; then
  OK "메일 보내기 서비스가 성공적으로 중지됨"
else
  WARN "Sendmail 서비스를 중지하지 못했습니다"
fi

# 부팅 시 Sendmail 서비스를 시작하지 않도록 설정
systemctl disable sendmail

# Sendmail 서비스가 부팅 시 시작되지 않도록 설정되었는지 확인합니다
if [ $(chkconfig --list sendmail | grep on | wc -l) -eq 0 ]; then
  OK "부팅 시 메일 보내기 서비스를 시작할 수 없음"
else
  WARN "부팅 시 Sendmail 서비스를 시작하지 않도록 설정하지 못했습니다."
fi





cat $result

echo ; echo
 

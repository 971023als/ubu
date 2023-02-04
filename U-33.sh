#!/bin/bash

. function.sh

BAR

CODE [U-33]  DNS 보안 버전 패치 '확인 필요'

cat << EOF >> $result
[양호]: DNS 서비스를 사용하지 않거나 주기적으로 패치를 관리하고 있는 경우

[취약]: DNS 서비스를 사용하며 주기적으로 패치를 관리하고 있지 않는 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

#DNS 서비스 중지
sudo service named stop

#부팅 시 DNS 서비스를 시작하지 않도록 설정
sudo chkconfig named off

#DNS 서비스가 중지되었는지 확인합니다

if [ $(sudo service named status | grep -c "is running") -eq 0 ]; then
OK "DNS 서비스가 중지되었습니다."
else
WARN "DNS 서비스가 아직 실행 중입니다."
fi

#부팅 시 DNS 서비스가 사용되지 않도록 설정되었는지 확인
if [ "$(sudo chkconfig --list named | grep -c "3:off")" -eq 1 ]; then
OK "DNS 서비스가 부팅 시 비활성화됩니다."
else
WARN "부팅 시 DNS 서비스가 사용되지 않도록 설정되지 않았습니다."
fi


cat $result

echo ; echo
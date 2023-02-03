#!/bin/bash

. function.sh

BAR

CODE [U-34] DNS Zone Transfer 설정

cat << EOF >> $result

[양호]: DNS 서비스 미사용 또는, Zone Transfer를 허가된 사용자에게만 허용한 경우

[취약]: DNS 서비스를 사용하며 Zone Transfer를 모든 사용자에게 허용한 경우

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
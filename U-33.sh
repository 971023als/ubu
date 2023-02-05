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
sudo systemctl stop named

#부팅 시 DNS 서비스를 시작하지 않도록 설정
sudo systemctl disable named

#DNS 서비스가 중지되었는지 확인합니다

if [ $(sudo systemctl is-active named) == "inactive" ]; then
    OK "DNS 서비스가 중지되었습니다."
else
    WARN "DNS 서비스가 아직 실행 중입니다."
fi


cat $result

echo ; echo
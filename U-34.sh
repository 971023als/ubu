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




# 서비스 중지
systemctl stop named

# /etc/bind/name.conf에 전송 허용 설정이 있는지 확인하십시오
if grep -q "allow-transfer" /etc/bind/named.conf; then
  OK "allow-transfer 설정이 /etc/bind/name.conf에 이미 있습니다"
else
  # /etc/bind/name.conf에 전송 허용 설정을 추가합니다
  echo "allow-transfer { any; };" >> /etc/bind/named.conf
  INFO "allow-transfer 설정이 /etc/bind/name.conf에 추가되었습니다"
fi

# xfrnets 설정이 /etc/bind/name.conf에 있는지 확인합니다
if grep -q "xfrnets" /etc/bind/named.conf; then
  OK "xfrnets 설정이 /etc/bind/name.conf에 이미 있습니다"
else
  # xfrnets 설정을 /etc/bind/name.conf에 추가합니다
  read -p "영역 전송을 허용할 IP 주소 또는 네트워크 입력: " xfr_ip
  echo "xfrnets { $xfr_ip; };" >> /etc/bind/named.conf
  echo "xfrnets 설정이 /etc/bind/name.conf에 추가되었습니다"
fi



cat $result

echo ; echo
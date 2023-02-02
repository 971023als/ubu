#!/bin/bash

. function.sh

BAR

CODE [U-18] 접속 IP 및 포트 제한

cat << EOF >> $result

[양호]: 접속을 허용할 특정 호스트에 대한 IP 주소 및 포트 제한을 설정한 경우

[취약]: 접속을 허용할 특정 호스트에 대한 IP 주소 및 포트 제한을 설정하지 않은 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  


# IP 범위 192.168.1.0/24에서 포트 22로 들어오는 TCP 연결 허용192.168.1.0/24
sudo iptables -A INPUT -p tcp -s 192.168.1.0/24 --dport 22 -j ACCEPT

# 포트 22에서 다른 모든 수신 TCP 연결 삭제
sudo iptables -A INPUT -p tcp --dport 22 -j DROP



cat $result

echo ; echo
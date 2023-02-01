#!/bin/bash

. function.sh

BAR

CODE [U-01] root 계정 원격 접속 제한

cat << EOF >> $result

[양호]: 원격 서비스를 사용하지 않거나 사용시 직접 접속을 차단한 경우

[취약]: root 직접 접속을 허용하고 원격 서비스를 사용하는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  


# 백업 원본 파일
sudo cp /etc/security /etc/security.bak

# pts/0 tops/x 설정 제거 또는 주석 달기
sudo sed -i '/^pts\/[0-9]/s/^/#/' /etc/security


# (Telnet 서비스 사용시 auth required /lib/security/pam_securetty.so 새로 삽입하는 방법으로 함)
sudo sed -i '$ a auth required /lib/security/pam_securety.so' /etc/pam.d/login


# (SSH 서비스 사용시 PermitRootLogin No 새로 삽입하는 방법으로 함)
sudo sh -c "echo 'PermitRootLogin No' >> /etc/ssh/sshd_config"



cat $result

echo ; echo
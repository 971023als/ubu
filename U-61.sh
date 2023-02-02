#!/bin/bash

 

. function.sh

 

BAR

CODE [U-61] ftp 서비스 확인

cat << EOF >> $result

[양호]: FTP 서비스가 비활성화 되어 있는 경우

[취약]: FTP 서비스가 활성화 되어 있는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1   

# FTP 서비스를 중지합니다:
sudo service ftpd stop

# 부팅 시 FTP 서비스를 시작하지 않도록 설정합니다
sudo chkconfig ftpd off

# FTP 서비스가 중지되고 비활성화되었는지 확인합니다:
sudo service ftpd status


cat $result

echo ; echo 

#!/bin/bash

 

. function.sh

TMP1=`SCRIPTNAME`.log

> $TMP1   

 

BAR

CODE [U-61] ftp 서비스 확인

cat << EOF >> $result

[양호]: FTP 서비스가 비활성화 되어 있는 경우

[취약]: FTP 서비스가 활성화 되어 있는 경우

EOF

BAR


# Stop FTP service
service vsftpd stop

# Remove FTP package
apt remove vsftpd -y

# Disable vsftpd service from starting at boot time
systemctl disable vsftpd


cat $result

echo ; echo 

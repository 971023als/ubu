#!/bin/bash

. function.sh

BAR

CODE [U-20] Anonymous FTP 비활성화

cat << EOF >> $result

[양호]: Anonymous FTP (익명 ftp) 접속을 차단한 경우

[취약]: Anonymous FTP (익명 ftp) 접속을 차단하지 않은 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# vsftpd 구성 파일 백업
cp /etc/vsftpd.conf /etc/vsftpd.conf.bak

# 익명 FTP 연결 사용 안 함
sed -i 's/^anonymous_enable=YES/anonymous_enable=NO/' /etc/vsftpd.conf

# FTP 서비스를 다시 시작하여 변경 사항 적용
service vsftpd restart 
if [ "$?" -ne 0 ]; then
  INFO "FTP 서비스를 다시 시작하지 못했습니다."
else
  OK "FTP 서비스가 다시 시작되었습니다."
fi




cat $result

echo ; echo
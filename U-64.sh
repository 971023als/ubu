#!/bin/bash

 

. function.sh
 

BAR

CODE [U-64] ftpusers 파일 설정

cat << EOF >> $result

[양호]: FTP 서비스가 비활성화 되어 있거나, 활성 시 root 계정 접속을 차단한 경우

[취약]: FTP 서비스가 활성화 되어 있고, root 계정 접속을 허용한 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1 

# FTP 서비스가 실행 중인지 확인합니다
if service is-active --quiet vsftpd; then
  # FTP 서비스가 실행 중입니다. 루트 로그인을 차단
  sed -i 's/#PermitRootLogin.*/PermitRootLogin no/g' /etc/ssh/sshd_config
else
  # FTP 서비스가 실행되고 있지 않습니다. 루트 로그인 허용
  sed -i 's/PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config
fi



cat $result

echo ; echo 


 

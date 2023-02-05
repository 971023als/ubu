#!/bin/bash

 

. function.sh

  
 

BAR

CODE [U-60] ssh 원격접속 허용

cat << EOF >> $result

[양호]: 원격 접속 시 SSH 프로토콜을 사용하는 경우

[취약]: 원격 접속 시 Telnet, FTP 등 안전하지 않은 프로토콜을 사용하는 경우

EOF

BAR


TMP1=`SCRIPTNAME`.log

> $TMP1  

sudo apt-get install openssh-server -y

sudo service start ssh

sudo service enable ssh

service status ssh


cat $result

echo ; echo 

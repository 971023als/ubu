#!/bin/bash

 

. function.sh

 
TMP1=`SCRIPTNAME`.log

> $TMP1 
 

BAR

CODE [U-65] at 파일 소유자 및 권한 설정

cat << EOF >> $result

[양호]: at 접근제어 파일의 소유자가 root이고, 권한이 640 이하인 경우

[취약]: at 접근제어 파일의 소유자가 root가 아니거나, 권한이 640 이하가 아닌 경우

EOF

BAR


sudo chmod 4750 /usr/bin/at

sudo chown root /etc/at.deny

sudo chmod 640 /etc/at.deny

cat $result

echo ; echo 
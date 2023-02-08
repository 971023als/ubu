#!/bin/bash

. function.sh

BAR

CODE [U-03] 패스워드 파일 보호

cat << EOF >> $result

[양호]: 계정 잠금 임계값이 10회 이하의 값으로 설정되어 있는 경우

[취약]: 계정 잠금 임계값이 설정되어 있지 않거나, 10회 이하의 값으로 설정되지 않은 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# 원본 파일 백업
cp /etc/pam.d/common-auth /etc/pam.d/common-auth.bak

# 파일의 줄 바꾸기
sed -i 's/auth.*/auth required \/lib\/security\/pam_tally.so deny=5 unlock_time=120 no_magic_root/' /etc/pam.d/common-auth




cat $result

echo ; echo
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


# 원본 파일을 백업하다
cp /etc/pam.d/common-auth /etc/pam.d/common-auth.bak

# pam_failock.so 모듈을 추가합니다
echo "auth        required      pam_faillock.so preauth silent deny=10 unlock_time=900" >> /etc/pam.d/common-auth
echo "auth        [default=die] pam_faillock.so authfail deny=10 unlock_time=900" >> /etc/pam.d/common-auth

# pam_unix.so 앞에 pam_failock.so 모듈을 삽입합니다
sed -i '/pam_unix.so/ i\auth        required      pam_faillock.so preauth silent deny=10 unlock_time=900' /etc/pam.d/common-auth
sed -i '/pam_unix.so/ i\auth        [default=die] pam_faillock.so authfail deny=10 unlock_time=900' /etc/pam.d/common-auth



cat $result

echo ; echo
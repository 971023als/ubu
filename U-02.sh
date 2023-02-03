#!/bin/bash

. function.sh

BAR

CODE [U-02] 패스워드 복잡성 설정

cat << EOF >> $result

[양호]: 패스워드 최소길이 8자리 이상, 영문·숫자·특수문자 최소 입력 기능이 설정된 경우

[취약]: 패스워드 최소길이 8자리 이상, 영문·숫자·특수문자 최소 입력 기능이 설정된 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# 원본 파일을 백업하다
cp /etc/pam.d/common-password /etc/pam.d/common-password

# 최소 암호 길이를 8자로 설정
echo "password requisite pam_pwquality.so minlen=8" >> /etc/pam.d/common-password

# 영문, 숫자 및 특수 문자 필요
echo "password requisite pam_pwquality.so dcredit=-1 ucredit=-1 ocredit=-1 lcredit=-1" >> /etc/pam.d/common-password

cat $result

echo ; echo
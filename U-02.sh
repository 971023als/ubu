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


# /etc/login.defs에서 최소 암호 길이 설정
sed -i 's/^PASS_MIN_LEN.*/PASS_MIN_LEN 8/' /etc/login.defs

# /etc/pam.d/system-auth에서 영어, 숫자 및 특수 문자의 최소 입력 설정
if ! grep -q "pam_cracklib.so" /etc/pam.d/system-auth; then
  echo "password    requisite     pam_cracklib.so minlen=8 try_first_pass retry=3" >> /etc/pam.d/system-auth
else
  sed -i 's/pam_cracklib.so.*/pam_cracklib.so minlen=8 try_first_pass retry=3/' /etc/pam.d/system-auth
fi

INFO "/etc/login.defs 및 /etc/pam.d/system-auth에서 최소 암호 길이가 8로 설정됨"



cat $result

echo ; echo
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

# 확인필요

# 원본 파일을 백업
cp /etc/pam.d/system-auth /etc/pam.d/system-auth.bak

# 파일 내용 변경
echo -e "auth required /lib/security/pam_tally.so deny=5 unlock_time=120\nno_magic_root\naccount required /lib/security/pam_tally.so no_magic_root reset" > /etc/pam.d/system-auth



cat $result

echo ; echo
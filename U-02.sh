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

# 최소 대문자 수 설정
min_upper=3

# 최소 소문자 수 설정
min_lower=3

# 최소 숫자 문자 수 설정
min_numeric=2

# 최소 특수 문자 수 설정
min_special=2

# pam_cracklib이 있는지 확인합니다.so는 /etc/syslog.d/system-auth에 있습니다
if grep -q "pam_cracklib.so" /etc/pam.d/system-auth; then
  # 기존 pam_cracklib을 업데이트합니다.
  sed -i "s/\(pam_cracklib.so.*\)ucredit=[0-9]*\(.*\)/\1ucredit=$min_upper\2/" /etc/pam.d/system-auth
  sed -i "s/\(pam_cracklib.so.*\)lcredit=[0-9]*\(.*\)/\1lcredit=$min_lower\2/" /etc/pam.d/system-auth
  sed -i "s/\(pam_cracklib.so.*\)dcredit=[0-9]*\(.*\)/\1dcredit=$min_numeric\2/" /etc/pam.d/system-auth
  sed -i "s/\(pam_cracklib.so.*\)ocredit=[0-9]*\(.*\)/\1ocredit=$min_special\2/" /etc/pam.d/system-auth
else
  # pam_cracklib을 사용하여 새 줄을 추가합니다.
  echo "password    required    pam_cracklib.so retry=3 ucredit=$min_upper lcredit=$min_lower dcredit=$min_numeric ocredit=$min_special" >> /etc/pam.d/system-auth
fi



cat $result

echo ; echo
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

if grep -q "^PASS_MIN_LEN" /etc/login.defs; then
  # 기존 PASS_MIN_LEN 설정을 새 값으로 바꿉니다
  sed -i "s/^PASS_MIN_LEN.*/PASS_MIN_LEN 8/" /etc/login.defs
else
  # 파일 끝에 PASS_MIN_LEN 설정 추가
  echo "PASS_MIN_LEN 8" >> /etc/login.defs
fi

INFO "/etc/login.defs에서 최소 암호 길이가 8자 이상으로 설정됨."

if grep -q "^password.*required.*pam_cracklib.so.*minclass=3" /etc/pam.d/system-auth; then
  # 기존 pam_cracklib을 교체합니다.그래서 새로운 가치에 맞춰라
  sed -i "s/^password.*required.*pam_cracklib.so.*/password    required    pam_cracklib.so minclass=3/" /etc/pam.d/system-auth
else
  # pam_cracklib을 추가합니다.그래서 파일 끝에 줄을 서라
  echo "password    required    pam_cracklib.so minclass=3" >> /etc/pam.d/system-auth
fi

INFO "/etc/pam.d/system-auth에 설정된 영어, 숫자 및 특수 문자에 대한 최소 입력 요구 사항 설정 완료"


cat $result

echo ; echo
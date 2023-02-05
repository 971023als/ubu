#!/bin/bash

. function.sh

BAR

CODE [U-46] 패스워드 최소 길이 설정

cat << EOF >> $result

[양호]: 패스워드 최소 길이가 8자 이상으로 설정되어 있는 경우 

[취약]: 패스워드 최소 길이가 8자 미만으로 설정되어 있는 경우 

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  


# 암호 최소 길이를 8자로 설정
echo "PASS_MIN_LEN 8" >> /etc/login.defs

# 암호 최소 길이가 올바르게 설정되었는지 확인합니다
min_len=$(grep "^PASS_MIN_LEN" /etc/login.defs | awk '{print $2}')

if [ "$min_len" -ge "8" ]; then
  OK "암호 최소 길이가 이제 8자 이상으로 설정되었습니다."
else
  WARN "암호 최소 길이를 8자 이상으로 설정하지 못했습니다."
fi


cat $result

echo ; echo
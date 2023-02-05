#!/bin/bash

. function.sh

BAR

CODE [U-47] 패스워드 최대 사용기간 설정

cat << EOF >> $result

[양호]: 패스워드 최대 사용기간이 90일(12주) 이하로 설정되어 있는 경우

[취약]: 패스워드 최대 사용기간이 90일(12주) 이하로 설정되어 있지 않는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# 최대 암호 사용 기간(일)
max_age=90

# /etc/login.defs에서 최대 암호 사용 기간 설정
sudo sed -i "s/^\(PASS_MAX_DAYS\s*\).*/\1$max_age/" /etc/login.defs


cat $result

echo ; echo
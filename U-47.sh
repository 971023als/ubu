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

DEF_FILE="/etc/login.defs"

# "#PASS"를 "PASS"로 바꿉니다
sudo sed -i 's/#PASS/PASS/g' "$DEF_FILE"

sudo sed -i "s/^PASS_MAX_DAYS.*/PASS_MAX_DAYS\ 90/" /etc/login.defs


cat $result

echo ; echo
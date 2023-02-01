#!/bin/bash

. function.sh

BAR

CODE [U-48] 패스워드 최소 사용기간 설정

cat << EOF >> $result

[양호]: 패스워드 최소 사용기간이 1일 이상 설정되어 있는 경우

[취약]: 패스워드 최소 사용기간이 설정되어 있지 않는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  


# 파일 Open 
sudo nano /etc/login.defs

# 사용자에게 최소 사용 기간(일)을 입력하라는 메시지 표시
echo "Enter the minimum age (in days) for user's password:"
read -r min_days

# "PASS_MIN_DAYS"가 포함된 줄을 검색하고 입력된 최소 일 수로 값을 설정합니다
sed -i "s/^PASS_MIN_DAYS.*/PASS_MIN_DAYS $min_days/" /etc/login.defs

# 파일 저장 후 종료
:wq


cat $result

echo ; echo
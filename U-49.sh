#!/bin/bash

. function.sh

BAR

CODE [U-49] 불필요한 계정 제거

cat << EOF >> $result

[양호]: 불필요한 계정이 존재하지 않는 경우

[취약]: 불필요한 계정이 존재하는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# 90일 이상 로그인하지 않은 모든 사용자 목록 가져오기
users=$(lastlog -b 90 -t | cut -d' ' -f1 | grep -v 'Username' | grep -v 'root' | grep -v 'Never logged in')

# 사용자 목록을 반복하여 제거
for user in $users; do
  echo "Removing user $user..."
  userdel -r $user
done



cat $result

echo ; echo
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

> $TMP1

# /etc/passwd에서 "lp|uucp|nuucp"와 일치하는 사용자 목록을 가져옵니다
user_list=$(cat /etc/passwd | egrep "lp|uucp|nuucp" | awk -F: '{print $1}')

# 사용자 목록을 순환
for user in $user_list; do
 # 사용자 셸을 /bin/false로 변경합니다
  usermod -s /bin/false $user
  if [ $? -eq 0 ]; then
    echo "Login is now impossible for user: $user"
  else
    echo "Could not make login impossible for user: $user"
  fi
done



 
cat $result

echo ; echo

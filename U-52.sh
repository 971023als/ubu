#!/bin/bash

 

. function.sh

 

TMP2=$(mktemp)

TMP3=$(mktemp)

> $TMP2

> $TMP3

 

BAR

CODE [U-52] 동일한 UID 금지

cat << EOF >> $result

양호: 동일한 UID로 설정된 사용자 계정이 존재하지 않는 경우

취약: 동일한 UID로 설정된 사용자 계정이 존재하는 경우

EOF

BAR


TMP1=`SCRIPTNAME`.log

> $TMP1


# 고유 UID 목록 가져오기
unique_uids=$(cat /etc/passwd | awk -F: '{print $3}' | sort | uniq)

# 고유 UID에 대한 카운터 초기화
counter=100

# 고유한 UID를 루프하여 각 사용자 계정의 UID 변경
for uid in $unique_uids; do
  users=$(grep ":$uid:" /etc/passwd | awk -F: '{print $1}')
  for user in $users; do
    sudo usermod -u $counter $user
    ((counter++))
  done
done



 

cat $result

echo ; echo

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

# 각 UID를 반복합니다
for uid in $unique_uids; do
  # 동일한 UID를 가진 계정 수 계산
  count=$(grep ":$uid:" /etc/passwd | wc -l)

  # 동일한 UID를 가진 계정이 하나만 있는 경우 건너뛰기
  if [ $count -le 1 ]; then
    continue
  fi

  # 동일한 UID를 가진 계정 목록 가져오기
  users=$(grep ":$uid:" /etc/passwd | awk -F: '{print $1}')

  # 각 계정을 반복합니다
  for user in $users; do
    # 동일한 UID를 가진 첫 번째 계정 건너뛰기
    if [ $count -eq $uid ]; then
      count=$((count - 1))
      continue
    fi

    # 현재 uid로 new_uid 초기화
    new_uid=$uid

    # new_uid가 이미 있는지 확인하십시오
    while grep -q ":$new_uid:" /etc/passwd; do
      # new_uid 증가
      new_uid=$((new_uid + 1))
    done

    # 계정의 UID 변경
    sudo usermod --uid $new_uid $user

    # 감산수
    count=$((count - 1))
  done
done


 

cat $result

echo ; echo

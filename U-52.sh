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

# 동일한 UID를 가진 사용자 계정이 없는지 확인하십시오
check_uid() {
  uid=$1
  username=$(getent passwd $uid | cut -d: -f1)
  if [ -z "$username" ]; then
    OK "동일한 UID $uid 를 가진 사용자 계정이 없습니다."
    # 여기서 작업 수행(예: 지정된 UID로 새 사용자 계정 만들기)
    # user add -u $uid new user
  else
    WARN "UID $uid 를 가진 사용자 계정 $username 존재"
  fi
}

# 여러 UID 확인
check_uid 1001
check_uid 1002
check_uid 1003

 

cat $result

echo ; echo

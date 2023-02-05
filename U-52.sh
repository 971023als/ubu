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

#  각 고유 UID를 루프합니다
for uid in $unique_uids; do
  # 동일한 UID를 가진 사용자 계정 수 계산
  count=$(grep ":$uid:" /etc/passwd | wc -l)
  
  # 동일한 UID를 가진 사용자 계정이 두 개 이상인 경우 다음 UID로 건너뜁니다
  if [ $count -gt 1 ]; then
    continue
  fi
  
  # 동일한 UID를 가진 사용자 계정이 정확히 하나인 경우 원하는 작업을 수행합니다
  if [ $count -eq 1 ]; then
    # "조치"를 수행할 원하는 조치로 바꿉니다
    action
  fi
done
 

cat $result

echo ; echo

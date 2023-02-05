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

# 고유 사용자 ID(UID) 목록 가져오기
unique_uids=$(cat /etc/passwd | awk -F: '{print $3}' | sort | uniq)

# 각 UID를 반복합니다
for uid in $unique_uids; do
  # 동일한 UID를 가진 사용자 계정 수 계산
  count=$(grep ":$uid:" /etc/passwd | wc -l)

  # 동일한 UID를 가진 사용자 계정이 둘 이상인 경우 다음 UID로 건너뜁니다
  if [ $count -gt 1 ]; then
    # 동일한 UID를 가진 사용자 계정 목록 가져오기
    users=$(grep ":$uid:" /etc/passwd | awk -F: '{print $1}')

    #  각 사용자 계정 루프
    for user in $users; do
      # 동일한 UID를 가진 첫 번째 사용자 계정 건너뛰기
      if [ $count -eq $uid ]; then
        count=$((count - 1))
        continue
      fi

      # 새 UID 생성
      new_uid=$((uid + count))

      # 새 UID가 이미 있는지 확인하십시오
      if grep -q ":$new_uid:" /etc/passwd; then
        # 새 UID가 이미 있는 경우 새 UID 다시 생성
        new_uid=$((new_uid + 1))
      fi

      # 사용자 계정의 UID 변경
      sudo usermod --uid $new_uid $user

      # 카운트를 줄입니다
      count=$((count - 1))
    done
  fi
done
 

cat $result

echo ; echo

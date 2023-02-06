#!/bin/bash

. function.sh

BAR

CODE [U-44] root 이외의 UID가 ‘0’ 금지

cat << EOF >> $result

[양호]: root 계정과 동일한 UID를 갖는 계정이 존재하지 않는 경우

[취약]: root 계정과 동일한 UID를 갖는 계정이 존재하는 경우

EOF

BAR

# /etc/passwd를 한 줄씩 읽습니다
while read line; do
  # 세 번째 필드(UID) 가져오기
  uid=$(echo $line | awk -F: '{print $3}')

  # UID가 0이 아닌 경우 건너뛰기
  if [ $uid -ne 0 ]; then
    continue
  fi

  # 사용자 이름 가져오기
  username=$(echo $line | awk -F: '{print $1}')

  # UID 1 증가
  new_uid=$((uid + 1))

  # /etc/passwd의 항목 업데이트
  sed -i "s/$username:x:$uid:/$username:x:$new_uid:/" /etc/passwd
done < /etc/passwd



cat $result

echo ; echo
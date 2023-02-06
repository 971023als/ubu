#!/bin/bash

. function.sh

BAR

CODE [U-44] root 이외의 UID가 ‘0’ 금지

cat << EOF >> $result

[양호]: root 계정과 동일한 UID를 갖는 계정이 존재하지 않는 경우

[취약]: root 계정과 동일한 UID를 갖는 계정이 존재하는 경우

EOF

BAR

# /etc/passwd 파일 읽기
while read line; do
  # 줄을 필드로 분할합니다
  fields=($(echo $line | tr ":" " "))
  username=${fields[0]}
  uid=${fields[2]}

  # UID가 0(루트)인지 확인합니다
  if [ $uid -eq 0 ]; then
    # UID를 새 값(500, 501, 502 등)으로 변경합니다
    new_uid=$((2023 + i))
    usermod -u $new_uid $username
    INFO "$username 의 UID가 0에서 $new_uid 로 변경됨"
    i=$((i + 1))
  fi
done < /etc/passwd


cat $result

echo ; echo
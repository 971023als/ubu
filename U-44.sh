#!/bin/bash

. function.sh

BAR

CODE [U-44] root 이외의 UID가 ‘0’ 금지

cat << EOF >> $result

[양호]: root 계정과 동일한 UID를 갖는 계정이 존재하지 않는 경우

[취약]: root 계정과 동일한 UID를 갖는 계정이 존재하는 경우

EOF

BAR

# 루트 계정의 UID 가져오기
root_uid=$(id -u root)

# 모든 사용자 계정 목록 가져오기
user_list=$(awk -F: '{print $1}' /etc/passwd)

# 목록의 각 사용자를 반복합니다
for user in $user_list; do
  # 현재 사용자의 UID 가져오기
  uid=$(id -u $user)
 # 현재 사용자의 UID가 루트 계정과 동일한지 확인하십시오
  if [ $uid -eq $root_uid ]; then
    # 루트 계정과 다른 새 UID 생성
    new_uid=$((root_uid + 1))
    # 현재 사용자의 UID를 새 UID로 변경
    sudo usermod -u $new_uid $user
    # UID가 변경되었음을 나타내는 메시지 출력
    INFO "사용자 '$user'의 UID가 $root_uid에서 $new_uid로 변경됨"
  fi
done


cat $result

echo ; echo
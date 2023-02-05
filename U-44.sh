#!/bin/bash

. function.sh

BAR

CODE [U-44] root 이외의 UID가 ‘0’ 금지

cat << EOF >> $result

[양호]: root 계정과 동일한 UID를 갖는 계정이 존재하지 않는 경우

[취약]: root 계정과 동일한 UID를 갖는 계정이 존재하는 경우

EOF

BAR

# 루트 계정과 동일한 UID를 가진 계정이 있는지 확인하십시오
if ! grep -q ":$ROOT_UID:" /etc/passwd; then
  # 루트 계정과 동일한 UID를 가진 계정이 없는 경우 작업 수행
  INFO "루트 계정과 동일한 UID를 가진 계정이 없습니다."
  # 예제 작업: 루트 계정과 동일한 UID를 가진 새 사용자 추가
  sudo useradd -u $ROOT_UID newuser
fi

cat $result

echo ; echo
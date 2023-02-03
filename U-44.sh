#!/bin/bash

. function.sh

BAR

CODE [U-44] root 이외의 UID가 ‘0’ 금지

cat << EOF >> $result

[양호]: root 계정과 동일한 UID를 갖는 계정이 존재하지 않는 경우

[취약]: root 계정과 동일한 UID를 갖는 계정이 존재하는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# /etc/passwd에서 UID가 0인 계정을 확인합니다
if grep -q ":0:" /etc/passwd; then
  # UID가 0인 계정의 사용자 이름 가져오기
  username=$(grep ":0:" /etc/passwd | cut -d: -f1)

  # 계정이 사용 중인지 확인합니다
  if who | grep -q $username; then
    INFO "UID가 0인 계정 $username이(가) 현재 사용 중이므로 변경하거나 삭제할 수 없습니다."
  fi

  # 계정의 UID를 다른 값으로 변경합니다
  new_uid=1000 # 예제 값, 필요에 따라 변경
  usermod -u $new_uid $username
  OK "$username의 UID를 $new_uid로 변경했습니다."


cat $result

echo ; echo
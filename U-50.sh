#!/bin/bash

. function.sh

BAR

CODE [U-50] 관리자 그룹에 최소한의 계정 포함

cat << EOF >> $result

[양호]: 관리자 그룹에 불필요한 계정이 등록되어 있지 않은 경우

[취약]: 관리자 그룹에 불필요한 계정이 등록되어 있는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# 파일 Open
sudo vi /etc/group

# 루트 그룹의 계정 목록을 가져옵니다
root_users=$(grep '^root:' /etc/group | cut -d':' -f4)

# Prompt the user to enter a username to delete
echo "루트 그룹에서 삭제할 사용자의 사용자 이름을 입력하십시오(또는 종료하려면 'exit'):"
read -r user

# 사용자가  'exit'로 들어갈 때까지 반복합니다
while [ "$user" != "exit" ]; do
  # 루트 그룹에서 사용자 제거 및 파일 업데이트
  echo "Removing user $user from root group..."
  sed -i "/^root/s/,$user//" /etc/group
  # 사용자에게 다른 사용자 이름을 입력하라는 메시지 표시
echo "루트 그룹에서 삭제할 사용자의 사용자 이름을 입력하십시오(또는 종료하려면 'exit'):"
  read -r user
done

# Save and exit the file
sudo nano /etc/group


cat $result

echo ; echo
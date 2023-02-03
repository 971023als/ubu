#!/bin/bash

. function.sh

BAR

CODE [U-45] root 계정 su 제한		

cat << EOF >> $result

[양호]: su 명령어를 특정 그룹에 속한 사용자만 사용하도록 제한되어 있는 경우
※ 일반사용자 계정 없이 root 계정만 사용하는 경우 su 명령어 사용제한 불필요

[취약]: su 명령어를 모든 사용자가 사용하도록 설정되어 있는 경우

EOF

BAR


# 휠 그룹이 이미 존재하는지 점검하
if grep -q '^wheel:' /etc/group; then
  INFO "휠 그룹이 이미 존재합니다"
else
  # 휠 그룹 생성
  sudo groupadd wheel
  INFO "휠 그룹 생성됨"
fi

# su 명령 그룹을 휠로 변경
sudo chgrp wheel /usr/bin/su

# su 명령의 권한을 4750으로 변경
sudo chmod 4750 /usr/bin/su

sudo usermod -G wheel user


cat $result

echo ; echo


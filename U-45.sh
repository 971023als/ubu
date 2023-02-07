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

# 휠 그룹이 /etc/group 파일에 정의되어 있는지 확인하십시오
grep -q '^wheel:' /etc/group
if [ $? -eq 0 ]; then
  # 휠 그룹이 정의됨
  
  # SUID 비트가 su 명령에 대해 아직 설정되지 않았는지 확인하십시오
  ls -l $(which su) | grep -q '^-rwsr-xr-x'
  if [ $? -ne 0 ]; then
    # SUID bit is not set, set it
    sudo chmod u+s $(which su)
  fi
  
  # 그룹 실행 권한이 휠 그룹으로만 아직 제한되지 않았는지 점검하십시오
  ls -l $(which su) | grep -q '^.*wheel.*$'
  if [ $? -ne 0 ]; then
    # 허가는 휠 그룹으로만 제한되지 않습니다. 제한합니다
    sudo chgrp wheel $(which su)
    sudo chmod g-rwx $(which su)
    sudo chmod g+rxs $(which su)
  fi
  
  OK "SU 명령은 이제 휠 그룹의 사용자로 제한됩니다."
else
  # 휠 그룹이 정의되지 않음
  INFO "휠 그룹이 /etc/group 파일에 정의되어 있지 않습니다."
fi


cat $result

echo ; echo


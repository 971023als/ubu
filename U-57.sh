#!/bin/bash

 

. function.sh


 

BAR

CODE [U-57] 홈 디렉터리 소유자 및 권한

cat << EOF >> $result

[양호]: 홈 디렉터리 소유자가 해당 계정이고, 일반 사용자 쓰기 권한이 제거된 경우

[취약]: 홈 디렉터리 소유자가 해당 계정이 아니고, 일반 사용자 쓰기 권한이 부여된 경우 

EOF

BAR


TMP1=`SCRIPTNAME`.log

> $TMP1


cat /etc/passwd | awk -F ':' '{print $6}' | while read home_dir; do
  # 홈 디렉토리에 대한 소유권 및 사용 권한 정보를 가져옵니다
  ls -ld "$home_dir" | while read permissions owner group; do
    # 홈 디렉토리 소유자로 변경
    username=$(basename "$home_dir")
    sudo -u "$username" bash << EOF
      cd "$home_dir"
      # 다른 사용자에 대한 쓰기 권한 제거
      sudo chmod o-w .
EOF
  done
done




cat $result

echo ; echo 


 

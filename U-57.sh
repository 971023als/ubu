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

# /etc/passwd에서 홈 디렉토리 가져오기
while read home_dir; do
  # 홈 디렉토리의 소유권 및 사용 권한 가져오기
  while read permissions owner group; do
    # 홈 디렉토리 소유자가 사용자 이름과 일치하는지 확인합니다
    username=$(basename "$home_dir")

    # 홈 디렉토리의 소유권을 다른 계정으로 변경
    sudo chown new_owner "$home_dir"
    
    # 최종 사용자에 대한 쓰기 권한 제거
    sudo chmod o-w "$home_dir"
  done < <(ls -ld "$home_dir")
done < <(cat /etc/passwd | awk -F ':' '{print $6}')


cat $result

echo ; echo 


 

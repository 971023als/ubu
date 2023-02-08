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

# /etc/passwd의 각 줄을 반복합니다
while read line; do
  # 구분 기호로 ':'를 사용하여 줄을 필드로 분할
  fields=($(echo $line | tr ':' ' '))
  username=${fields[0]}
  home_dir=${fields[5]}
  owner=$(ls -ld "$home_dir" | awk '{print $3}')
  
  # 홈 디렉토리 소유자가 사용자 이름과 일치하는지 확인합니다
  if [ "$owner_group" != "$username:$username" ]; then
    INFO "$homeedir 의 소유권을 $username 으로 변경:$username"
    sudo chown "$username:$username" "$homedir"
  fi
done < /etc/passwd


# /etc/passwd에서 홈 디렉토리 목록 가져오기
while read home_dir; do
  # 홈 디렉토리의 소유자 및 그룹 가져오기
  while read permissions owner group; do
    # 소유자 그룹 등에 쓰기 권한 부여
    sudo chmod g+w,o+w "$home_dir"
  done < <(ls -ld "$home_dir")
done < <(cat /etc/passwd | awk -F ':' '{print $6}')

cat $result

echo ; echo 


 

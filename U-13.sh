#!/bin/bash

. function.sh

BAR

CODE [U-13] SUID, SGID, Sticky bit 설정 및 권한 설정		

cat << EOF >> $result

[양호]: 주요 실행파일의 권한에 SUID와 SGID에 대한 설정이 부여되어 있지 않은 
경우

[취약]: 주요 실행파일의 권한에 SUID와 SGID에 대한 설정이 부여되어 있는 경우

EOF

BAR

# SUID 또는 SGID 권한이 있는 모든 파일 찾기
output=$(find / -user root -type f \( -perm -04000 -o -perm -02000 \) -xdev -exec ls –al {} \;)

# 출력을 배열로 분할
arr=($output)

# 어레이를 순환하여 SUID 및 SGID 확인
for line in "${arr[@]}"
do
  if [[ $line == *"r-s"* ]]; then
    file=$(echo $line | awk '{print $9}')
    INFO "SUID 제거 중: $file"
    sudo chmod u-s $file
  elif [[ $line == *"r-S"* ]]; then
    file=$(echo $line | awk '{print $9}')
    INFO "SGID 제거 중: $file"
    sudo chmod g-s $file
  fi
done

cat $result

echo ; echo

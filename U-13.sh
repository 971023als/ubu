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

# SUID 또는 SGID 비트가 설정된 모든 파일 찾기
files=$(find / -type f \( -perm /u+s -o -perm /g+s \))

# 파일을 루프하여 SUID 및 SGID 비트 제거
for file in $files; do
  sudo chmod u-s,g-s $file
done


cat $result

echo ; echo

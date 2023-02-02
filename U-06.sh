#!/bin/bash

. function.sh

BAR

CODE [U-06] 파일 및 디렉터리 소유자 설정

cat << EOF >> $result

[양호]: 소유자가 존재하지 않는 파일 및 디렉터리가 존재하지 않는 경우

[취약]: 소유자가 존재하지 않는 파일 및 디렉터리가 존재하는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# 백업 디렉토리 설정
backup_dir="./backup_nouser_nogroup"

# 백업 디렉토리(존재하지 않는 경우) 생성
if [ ! -d "$backup_dir" ]; then
  mkdir "$backup_dir"
fi

# "사용자"가 소유한 파일 찾기 및 백업
for file in $(find / -nouser -print); do
  cp -R "$file" "$backup_dir"
  rm -rf "$file"
done

# "no group"이 소유한 파일 찾기 및 백업
for file in $(find / -nogroup -print); do
  cp -R "$file" "$backup_dir"
  rm -rf "$file"
done

echo "사용자 및 그룹 없음 소유의 파일이 백업 및 삭제되었습니다."

cat $result

echo ; echo
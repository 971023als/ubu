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

root_dir="/path/to/root/directory"
new_owner="new_user"

for file in "$root_dir"/*; do
  if [ ! -e "$file" ]; then
    continue
  fi
  
  owner=$(stat -c '%U' "$file")
  if [ -z "$owner" ]; then
    rm -rf "$file"
  elif [ "$owner" != "$new_owner" ]; then
    chown "$new_owner" "$file"
  fi
done

cat $result

echo ; echo
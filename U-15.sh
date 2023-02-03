#!/bin/bash

. function.sh

BAR

CODE [U-15] world writable 파일 점검 @@ 조치 후 웹 서비스 장애  @@

cat << EOF >> $result

[양호]: 시스템 중요 파일에 world writable 파일이 존재하지 않거나, 존재 시 설정 이유를 확인하고 있는 경우

[취약]: 시스템 중요 파일에 world writable 파일이 존재하나 해당 설정 이유를 확인하고 있지 않는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

critical_dir="/path/to/system/critical/directory"

for file in "$critical_dir"/*; do
  if [ ! -f "$file" ]; then
    continue
  fi
  
  permission=$(stat -c '%a' "$file")
  if [ "$((permission & 2))" -eq 2 ]; then
    chmod o-w "$file"
    if [ "$((permission & 6))" -eq 6 ]; then
      rm -rf "$file"
    fi
  fi
done


cat $result

echo ; echo
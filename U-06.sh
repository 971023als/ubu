#!/bin/bash

. function.sh

BAR

CODE [U-06] 파일 및 디렉터리 소유자 설정 @@su 말고 sudo su 해야 함 @@

cat << EOF >> $result

[양호]: 소유자가 존재하지 않는 파일 및 디렉터리가 존재하지 않는 경우

[취약]: 소유자가 존재하지 않는 파일 및 디렉터리가 존재하는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# 소유자가 없는 모든 파일 및 디렉터리 찾기
unowned=$(find . -nouser)

#  소유하지 않은 파일 또는 디렉터리가 있는지 확인하십시오
if [ -z "$unowned" ]; then
  OK "소유되지 않은 파일 또는 디렉터리를 찾을 수 없습니다."
fi

new_owner="root"

# Change the owner of each unowned file or directory
for item in $unowned; do
  sudo chown "$new_owner" "$item"
  INFO "$item 의 소유자가 $new_owner 로 변경됨"
done

OK "소유되지 않은 파일 및 디렉터리의 소유권 변경을 완료했습니다."



cat $result

echo ; echo
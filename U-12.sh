#!/bin/bash

. function.sh

BAR

CODE [U-12] /etc/services 파일 소유자 및 권한 설정		

cat << EOF >> $result

[양호]: etc/services 파일의 소유자가 root(또는 bin, sys)이고, 권한이 644 이하
인 경우

[취약]: etc/services 파일의 소유자가 root(또는 bin, sys)이고, 권한이 644 이하
인 경우

EOF

BAR

file="/etc/services"

# 소유권확인
owner=$(stat -c '%U' "$file")
if [ "$owner" != "root" ] && [ "$owner" != "bin" ] && [ "$owner" != "sys" ]; then
  WARN "$file 의 소유자가 root, bin 또는 sys가 아닙니다. 그것은 $owner 가 소유하고 있다."
else
  OK "$file 의 소유자는 root, bin 또는 sys입니다."
fi

# 권한 확인
permissions=$(stat -c '%a' "$file")
if [ "$permissions" -gt 644 ]; then
  WARN "$file의 권한이 644보다 큽니다. 그들은 $permissions 으로 설정되어 있습니다."
else
  OK "$file의 권한이 644 이하입니다."
fi


cat $result

echo ; echo

#!/bin/bash

. function.sh

BAR

CODE [U-12] /etc/services 파일 소유자 및 권한 설정

cat << EOF >> $result

[양호]: etc/services 파일의 소유자가 root(또는 bin, sys)이고, 권한이 644 이하인 경우

[취약]: etc/services 파일의 소유자가 root(또는 bin, sys)가 아니거나, 권한이 644 이하가 아닌 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

file="/etc/services"

# 파일이 있는지 확인
if [ -e $file ]; then
  # 소유권을 루트로 변경
  sudo chown root:root $file
  # 권한을 644로 변경
  sudo chmod 644 $file
  echo "File ownership and permissions set to root:root and 644"
else
  echo "File does not exist"
fi


cat $result

echo ; echo
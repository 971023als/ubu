#!/bin/bash

. function.sh

BAR

CODE [U-10] /etc/inetd.conf 파일 소유자 및 권한 설정		

cat << EOF >> $result

[양호]: /etc/inetd.conf 파일의 소유자가 root이고, 권한이 600인 경우

[취약]: /etc/inetd.conf 파일의 소유자가 root가 아니거나, 권한이 600이 아닌 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  


file="/etc/inetd.conf"

# 파일이 있는지 확인
if [ -e $file ]; then
  # 소유권을 루트로 변경
  sudo chown root:root $file
  # 권한을 600으로 변경
  sudo chmod 600 $file
  echo "File ownership and permissions set to root:root and 600"
else
  echo "File does not exist"
fi

file="/etc/xinetd.conf"

# 파일이 있는지 확인
if [ -e $file ]; then
  # 소유권을 루트로 변경
  sudo chown root:root $file
  # 권한을 600으로 변경
  sudo chmod 600 $file
  echo "File ownership and permissions set to root:root and 600"
else
  echo "File does not exist"
fi


cat $result

echo ; echo
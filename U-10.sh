#!/bin/bash

. function.sh

BAR

CODE [U-10] /etc/(x)inetd.conf 파일 소유자 및 권한 설정

cat << EOF >> $result

[양호]: 원격 서비스를 사용하지 않거나 사용시 직접 접속을 차단한 경우

[취약]: root 직접 접속을 허용하고 원격 서비스를 사용하는 경우

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
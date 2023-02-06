#!/bin/bash

 

. function.sh

 

BAR

CODE [U-69] NFS 설정파일 접근권한

cat << EOF >> $result

[양호]: NFS 접근제어 설정파일의 소유자가 root 이고, 권한이 644 이하인 경우

[취약]: NFS 접근제어 설정파일의 소유자가 root 가 아니거나, 권한이 644 이하가 아닌 경우

EOF

BAR


TMP1=`SCRIPTNAME`.log

> $TMP1 

filename="/etc/exports"

if [ ! -e "$filename" ]; then
  INFO "$filename 가 존재하지 않습니다"
fi

sudo chown root "$filename"
sudo chmod 644 "$filename"

owner=$(stat -c '%U' "$filename")
permission=$(stat -c '%a' "$filename")

if [ "$owner" == "root" ]; then
  OK "$filename의 소유자가 루트로 설정되었습니다."
else
  WARN "$filename의 소유자를 루트로 설정하지 못했습니다."
fi

if [ $(expr "$permission" \<= 644) -eq 1 ]; then
  OK "$filename의 권한이 644 이하로 설정되었습니다."
else
  WARN "$filename의 권한을 644 이하로 설정하지 못했습니다."
fi


cat $result

echo ; echo 


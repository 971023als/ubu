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
  echo "$filename does not exist."
  exit 1
fi

chown root "$filename"
chmod 644 "$filename"

owner=$(stat -c '%U' "$filename")
permission=$(stat -c '%a' "$filename")

if [ "$owner" == "root" ]; then
  echo "The owner of $filename has been set to root."
else
  echo "Failed to set the owner of $filename to root."
fi

if [ "$permission" -le 644 ]; then
  echo "The permission of $filename has been set to 644 or less."
else
  echo "Failed to set the permission of $filename to 644 or less."
fi


cat $result

echo ; echo 


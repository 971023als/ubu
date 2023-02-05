#!/bin/bash

. function.sh

BAR

CODE [U-09] /etc/hosts 파일 소유자 및 권한 설정

cat << EOF >> $result

[양호]: /etc/hosts 파일의 소유자가 root이고, 권한이 600인 이하경우

[취약]: /etc/hosts 파일의 소유자가 root가 아니거나, 권한이 600 이상인 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

HOSTS_FILE="/etc/hosts"

if [ ! -f $HOSTS_FILE ]; then
  OK "$HOSTs_FILE이 존재하지 않습니다"
fi

# 소유자를 루트로 설정
sudo chown root $HOSTS_FILE

# 권한을 600으로 설정
sudo chmod 600 $HOSTS_FILE

#  변경 사항 확인
owner=$(stat -c '%U' $HOSTS_FILE)
permissions=$(stat -c '%a' $HOSTS_FILE)

if [ "$owner" != "root" ]; then
  WARN "$HOSTs_FILE 의 소유자를 루트로 설정하지 못했습니다."
else
  OK "$HOSTs_FILE이 이제 루트에 의해 소유됩니다."
fi

if [ "$permissions" != "600" ]; then
  WARN "$HOSTs_FILE의 사용 권한을 600으로 설정하지 못했습니다."
else
  OK "$HOSTs_FILE에 권한 600이 있습니다."
fi



cat $result

echo ; echo
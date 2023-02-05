#!/bin/bash

 

. function.sh

 
 

BAR

CODE [U-54] Session Timeout 설정

cat << EOF >> $result

[양호]: Session Timeout이 600초(10분) 이하로 설정되어 있는 경우

[취약]: Session Timeout이 600초(10분) 이하로 설정되지 않은 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1


# add TMOUT to /etc/profile if it doesn't exist
if ! grep -q "TMOUT=600" /etc/profile; then
  echo "TMOUT=600" >> /etc/profile
  echo "export TMOUT" >> /etc/profile
  echo "TMOUT has been added to /etc/profile"
else
  echo "TMOUT already exists in /etc/profile"
fi





cat $result

echo ; echo

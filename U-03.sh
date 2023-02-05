#!/bin/bash

. function.sh

BAR

CODE [U-03] 패스워드 파일 보호

cat << EOF >> $result

[양호]: 계정 잠금 임계값이 10회 이하의 값으로 설정되어 있는 경우

[취약]: 계정 잠금 임계값이 설정되어 있지 않거나, 10회 이하의 값으로 설정되지 않은 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

if grep -q "auth required pam_tally2.so deny=5 unlock_time=900" /etc/pam.d/common-auth; then
  echo "The line 'auth required pam_tally2.so deny=5 unlock_time=900' is already present in /etc/pam.d/common-auth"
else
  echo "auth required pam_tally2.so deny=5 unlock_time=900" >> /etc/pam.d/common-auth
  echo "The line 'auth required pam_tally2.so deny=5 unlock_time=900' has been added to /etc/pam.d/common-auth"
fi



cat $result

echo ; echo
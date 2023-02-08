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

# 원본 파일 백업
cp /etc/pam.d/common-auth /etc/pam.d/common-auth.bak

# 잠금 임계값 설정
threshold=10

# 현재 잠금 임계값 설정을 가져옵니다
current_setting=$(grep "auth required pam_tally2.so" /etc/pam.d/common-auth | awk '{print $4}')

# 잠금 임계값이 10 이하로 설정되어 있는지 점검하십시오
if [ "$current_setting" != "onerr=fail deny=$threshold" ]; then
  # 현재 설정을 원하는 설정으로 바꿉니다
  sed -i "s/$current_setting/onerr=fail deny=$threshold/g" /etc/pam.d/common-auth
fi

cat $result

echo ; echo
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

#  파일 수정
echo "auth required /lib/security/pam_tally.so deny=5 unlock_time=120 no_magic_root" >> /etc/pam.d/common-auth
echo "account required /lib/security/pam_tally.so no_magic_root reset" >> /etc/pam.d/common-auth

# 변경 사항 확인
grep -q "auth required /lib/security/pam_tally.so deny=5 unlock_time=120 no_magic_root" /etc/pam.d/common-auth
if [ $? -eq 0 ]; then
    OK "/etc/pam.d/common-auth 파일에 성공적으로 추가되었습니다"
else
    WARN "/etc/pam.d/common-auth 파일에 줄을 추가하는 동안 오류가 발생했습니다."
fi




cat $result

echo ; echo
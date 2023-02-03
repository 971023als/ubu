#!/bin/bash

. function.sh

BAR

CODE [U-32] 일반사용자의 Sendmail 실행 방지		

cat << EOF >> $result

[양호]: SMTP 서비스 미사용 또는, 일반 사용자의 Sendmail 실행 방지가 설정된
경우

[취약]: SMTP 서비스 사용 및 일반 사용자의 Sendmail 실행 방지가 설정되어 
있지 않은 경우

EOF

BAR

# sendmail.cf 파일의 경로를 지정
file="/etc/mail/sendmail.cf"



# sendmail.cf 파일의 경로를 지정
file="/etc/mail/sendmail.cf"

# restrictqrun 옵션이 이미 있는지 확인
if grep -q "restrictqrun" $file; then
    echo "restrictqrun option already exists"
else
    # restrictqrun 옵션 추가
    sed -i '/O PrivacyOptions=/ s/$/, restrictqrun/' $file
    echo "restrictqrun option added successfully"
fi



# Sendmail 서비스 다시 시작
service sendmail restart


cat $result

echo ; echo


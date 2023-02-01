#!/bin/bash

. function.sh

BAR

CODE [U-32] 일반사용자의 Sendmail 실행 방지

cat << EOF >> $result

[양호]: SMTP 서비스 미사용 또는, 일반 사용자의 Sendmail 실행 방지가 설정된 경우

[취약]: SMTP 서비스 사용 및 일반 사용자의 Sendmail 실행 방지가 설정되어 있지 않은 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  


# Sendmail 서비스가 실행 중인지 확인
sendmail_status=$(systemctl is-active sendmail)

# 사용하지 않는 경우 메일 보내기 서비스 중지
if [ "$sendmail_status" != "active" ]; then
  systemctl stop sendmail
  echo "Sendmail service stopped."
else
  echo "Sendmail service is active."
  # sendmail.cf 파일을 수정하여 Restrictqrun 옵션을 개인 정보 옵션 설정에 추가
  sed -i 's/^O PrivacyOptions=.*/O PrivacyOptions=Restrictqrun/' /etc/mail/sendmail.cf
  echo "sendmail.cf file updated."
  # Sendmail 서비스 다시 시작
  systemctl restart sendmail
  echo "Sendmail service restarted."
fi



cat $result

echo ; echo
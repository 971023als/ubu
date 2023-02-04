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

# SMTP 서비스의 프로세스 ID 가져오기
SMTP_PID=$(pidof smtp)

# 프로세스에 SIGTERM 신호를 전송하여 SMTP 서비스 중지
if [ -n "$SMTP_PID" ]; then
  kill -SIGTERM $SMTP_PID
  OK "SMTP 서비스가 중지되었습니다"
else
  INFO "SMTP 서비스가 실행되고 있지 않습니다"
fi

sendmail_cfg_file="/etc/mail/sendmail.cf"

#  sendmail.cf 파일이 있는지 확인합니다
if [ -f "$sendmail_cfg_file" ]; then
  # 개인 정보 옵션 라인이 있는지 확인합니다
  if grep -q "^O PrivacyOptions=" "$sendmail_cfg_file"; then
    # 기존 개인 정보 옵션 줄 바꾸기
    sed -i 's/^O PrivacyOptions=.*/O PrivacyOptions= restrictqrun/' "$sendmail_cfg_file"
  else
    # 개인 정보 옵션 라인 추가
    echo "O PrivacyOptions= restrictqrun" >> "$sendmail_cfg_file"
  fi
  OK "sendmail.cf 파일에 개인 정보 옵션이 추가/수정되었습니다."
else
  WARN "sendmail.cf 파일을 찾을 수 없습니다."
fi


cat $result

echo ; echo


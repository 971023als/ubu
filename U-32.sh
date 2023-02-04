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

# 원본 submit.cf 파일 백업
cp /etc/mail/submit.cf /etc/mail/submit.cf.bak

# submit.cf에서 sendmail_enable 변수를 NO로 설정합니다
sed -i 's/^O sendmail_enable=.*/O sendmail_enable=NO/' /etc/mail/submit.cf

# submit.cf에서 sendmail_enable 변수가 NO로 설정되어 있는지 확인합니다
if grep -q "^O sendmail_enable=NO" /etc/mail/submit.cf; then
  OK "/etc/mail/submit.cf에서 sendmail_enable 변수가 NO로 설정되었습니다"
else
  WARN "/etc/mail/submit.cf에서 sendmail_enable 변수를 NO로 설정하지 못했습니다"
fi


cat $result

echo ; echo


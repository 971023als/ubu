#!/bin/bash

 

. function.sh

 

BAR

CODE [U-70] expn, vrfy 명령어 제한

cat << EOF >> $result

[양호]: SMTP 서비스 미사용 또는, noexpn, novrfy 옵션이 설정되어 있는 경우

[취약]: SMTP 서비스 사용하고, noexpn, novrfy 옵션이 설정되어 있지 않는 경우

EOF

BAR



# SMTP 서비스 중지
sudo service sendmail stop

CONF_FILE=/etc/postfix/main.cf

if grep -q "smtpd_recipient_restrictions" "$CONF_FILE"; then
  if grep -q "noexpn" "$CONF_FILE" && grep -q "novfy" "$CONF_FILE"; then
    OK "smtpd_snmp_recommunications에 noexpn 및 novfy가 이미 있습니다."
  else
    # 원래 구성 파일 백업
    cp "$CONF_FILE" "$CONF_FILE.bak"

    # 'noexpn' 및 'novfy'를 smtpd_transmissions 줄에 추가합니다
    sed -i '/smtpd_recipient_restrictions/ s/$/ noexpn, novfy/' "$CONF_FILE"

    INFO "smtpd_messagions에 noexpn 및 novfy가 추가되었습니다."
  fi
else
  INFO "구성 파일을 찾을 수 없습니다."
fi
    

cat $result

echo ; echo 

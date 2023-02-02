#!/bin/bash

. function.sh

BAR

CODE [U-31] 스팸 메일 릴레이 제한

cat << EOF >> $result

[양호]: SMTP 서비스를 사용하지 않거나 릴레이 제한이 설정되어 있는 경우

[취약]: SMTP 서비스를 사용하며 릴레이 제한이 설정되어 있지 않은 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# vi로 sendmail.cf 구성 파일 열기

# R$* $#error$@ 5.7.1$ 라인에 주석을 추가
sed -i 's/#R\$\* \$#error\$@ 5.7.1\$:/R\$\* \$#error\$@ 5.7.1\$: "550 Relaying denied"/g' /etc/mail/sendmail.cf

# 송신 메일 액세스 제한 확인
if [ ! -f /etc/mail/access ]; then
  echo "Creating sendmail access file"
  touch /etc/mail/access
fi

# DB 파일 생성
makemap hash /etc/mail/access.db < /etc/mail/access



cat $result

echo ; echo
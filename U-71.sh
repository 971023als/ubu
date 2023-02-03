#!/bin/bash

 

. function.sh
 

BAR

CODE [U-71] Apache 웹서비스 정보 숨김

cat << EOF >> $result

[양호]: ServerTokens Prod, ServerSignature Off로 설정되어있는 경우

[취약]: ServerTokens Prod, ServerSignature Off로 설정되어있지 않은 경우

EOF

BAR


TMP1=`SCRIPTNAME`.log

> $TMP1 


# ServerTokens 지시문이 이미 설정되어 있는지 확인
grep -q "^ServerTokens" /etc/apache2/conf-available/security.conf
if [ $? -eq 0 ]; then
  # 기존 ServerTokens 지시문 교체
  sed -i 's/^ServerTokens.*/ServerTokens Prod/' /etc/apache2/conf-available/security.conf
else
  # ServerTokens 지시문 추가
  echo "ServerTokens Prod" >> /etc/apache2/conf-available/security.conf
fi

# ServerSignature 지시문이 이미 설정되어 있는지 확인
grep -q "^ServerSignature" /etc/apache2/conf-available/security.conf
if [ $? -eq 0 ]; then
  # 기존 ServerSignature 지시문 교체
  sed -i 's/^ServerSignature.*/ServerSignature Off/' /etc/apache2/conf-available/security.conf
else
  # ServerSignature 지시어 추가
  echo "ServerSignature Off" >> /etc/apache2/conf-available/security.conf
fi


cat $result

echo ; echo 
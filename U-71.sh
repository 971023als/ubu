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

filename="/etc/apache2/apache2.conf"

if [ ! -e "$filename" ]; then
  echo "$filename does not exist."
fi

# ServerTokens 설정이 이미 Prod로 설정되어 있는지 확인합니다
server_tokens=$(grep -i 'ServerTokens' "$filename" | awk '{print $2}')
if [ "$server_tokens" == "Prod" ]; then
  echo "The Server Tokens setting is already set to Prod."
else
  # 그렇지 않으면 ServerTokens Prod 설정을 파일에 추가합니다
  echo "Setting Server Tokens to Prod..."
  echo "ServerTokens Prod" >> "$filename"
  echo "Server Tokens setting has been set to Prod."
fi

# ServerSignature 설정이 이미 Off로 설정되어 있는지 확인합니다
server_signature=$(grep -i 'ServerSignature' "$filename" | awk '{print $2}')
if [ "$server_signature" == "Off" ]; then
  echo "The Server Signature setting is already set to Off."
else
  # 그렇지 않은 경우, 서버 서명 끄기 설정을 파일에 추가합니다
  echo "Setting Server Signature to Off..."
  echo "ServerSignature Off" >> "$filename"
  echo "Server Signature setting has been set to Off."
fi



cat $result

echo ; echo 
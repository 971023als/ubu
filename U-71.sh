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
  INFO "$filename 가 존재하지 않습니다"
fi

#  ServerTokens 설정이 이미 Prod로 설정되어 있는지 확인합니다
server_tokens=$(grep -i 'ServerTokens' "$filename" | awk '{print $2}')
if [ "$server_tokens" == "Prod" ]; then
  OK "서버 토큰 설정이 이미 Prod로 설정되어 있습니다."
else
  # 그렇지 않으면 ServerTokens Prod 설정을 파일에 추가합니다
  INFO "서버 토큰을 Prod로 설정..."
  echo "ServerTokens Prod" >> "$filename"
  OK "서버 토큰 설정이 Prod로 설정되었습니다."
fi

# ServerSignature 설정이 이미 Off로 설정되어 있는지 확인합니다
server_signature=$(grep -i 'ServerSignature' "$filename" | awk '{print $2}')
if [ "$server_signature" == "Off" ]; then
  OK "서버 서명 설정이 이미 해제로 설정되어 있습니다."
else
  # 그렇지 않은 경우, 서버 서명 끄기 설정을 파일에 추가합니다
  INFO "서버 서명을 끄기로 설정 중..."
  echo "ServerSignature Off" >> "$filename"
  OK "Server Signature 설정이 Off로 설정되었습니다."
fi



cat $result

echo ; echo 
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

# 파일이 있는지 확인하십시오
if [ ! -e "$filename" ]; then
  INFO "$filename 없음"
fi

# 파일을 백업합니다
sudo cp "$filename" "$filename".bak

#  apache2.conf 파일에서 "ServerTokens Full"을 "ServerTokens Prod"로 바꿉니다
sudo sed -i 's/ServerTokens Full/ServerTokens Prod/g' "$filename"

# apache2.conf 파일에서 "ServerSignatureOn"을 "ServerSignatureOff"로 바꿉니다
sudo sed -i 's/ServerSignature On/ServerSignature Off/g' "$filename"

# ServerTokens가 설정되어 있는지 확인합니다
if ! grep -q "ServerTokens Prod" "$filename"; then
  echo "ServerTokens Prod" >> "$filename"
fi

# ServerSignature가 설정되어 있는지 확인합니다
if ! grep -q "ServerSignature Off" "$filename"; then
  echo "ServerSignature Off" >> "$filename"
fi

# Apache를 재시작하여 변경 사항 적용
sudo systemctl restart apache2

INFO "서버 토큰 서버 시그니처 설정 완료:  $filename."





cat $result

echo ; echo 
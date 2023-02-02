#!/bin/bash

. function.sh

BAR

CODE [U-37] 웹서비스 상위 디렉토리 접근 금지

cat << EOF >> $result

[양호]: 상위 디렉터리에 이동제한을 설정한 경우

[취약]: 상위 디렉터리에 이동제한을 설정하지 않은 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# Apache 구성 파일 정의
file="/etc/conf/httpd.conf"

# "AllowOverrideNone"을 "AllowOverride AuthConfig"로 바꿉니다
sed -i 's/AllowOverride None/AllowOverride AuthConfig/g' $file

# 변경되었는지 확인합니다
if grep -q "AllowOverride AuthConfig" $file; then
  OK "AllowOverrideNone이 AllowOverride AuthConfig로 성공적으로 대체되었습니다."
else
  WARN "AllowOverrideNone을 AllowOverrideAuthConfig로 바꿀 수 없음"
fi



# Apache 데몬을 재시작하여 변경된 설정 적용
sudo service apache2 restart


cat $result

echo ; echo
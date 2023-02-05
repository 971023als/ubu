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
file="/etc/apache2/apache2.conf"

# "AllowOverrideNone"을 "AllowOverride AuthConfig"로 바꿉니다
sed -i 's/AllowOverride None/AllowOverride AuthConfig/g' $file

# 변경 사항 확인
if grep -q "AllowOverride AuthConfig" $file; then
OK "AllowOverrideNone이 AllowOverrideAuthConfig로 교체."
else
WARN "AllowOverrideNone을 AllowOverrideAuthConfig로 바꾸지 못했습니다."
fi

# Apache 서비스 확인 및 디버그
systemctl status apache2.service > /dev/null
if [ $? -eq 0 ]; then
OK "아파치 서비스가 작동합니다."
else
ERROR="Failed to start Apache service."
ERROR="$ERROR\nPlease check the status using 'systemctl status apache2.service' and journal logs using 'journalctl -xe'"
echo -e "$ERROR"
fi


cat $result

echo ; echo
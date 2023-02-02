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
file="/[Apache_home]/conf/httpd.conf"

# 파일이 있는지 확인
if [ -f "$file" ]; then
    # vi 편집기에서 파일을 열고 "AllowOverride"를 검색
    vi +/AllowOverride "$file"
    # "AllowOverrideNone"을 "AllowOverride AuthConfig"로 바꿈
    :%s/AllowOverride None/AllowOverride AuthConfig/g
    # 파일 저장 후 종료
    :wq
else
    echo "httpd.conf file not found in /[Apache_home]/conf/"
fi


# Apache 데몬을 재시작하여 변경된 설정 적용
sudo service apache2 restart


cat $result

echo ; echo
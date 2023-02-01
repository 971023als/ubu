#!/bin/bash

. function.sh

BAR

CODE [U-39] 웹서비스 링크 사용금지

cat << EOF >> $result

[양호]: 심볼릭 링크, aliases 사용을 제한한 경우

[취약]: 심볼릭 링크, aliases 사용을 제한하지 않은 경우 

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# Apache 구성 파일 정의
file="/[Apache_home]/conf/httpd.conf"

# 파일이 있는지 확인
if [ -f "$file" ]; then
    # vi 편집기에서 파일을 열고 "Options"을 검색
    vi +/Options "$file"
    # "Options FollowSymLinks"를 "Options"으로 바꿈
    :%s/Options FollowSymLinks/Options/g
    # 파일 저장 후 종료
    :wq
else
    echo "httpd.conf file not found in /[Apache_home]/conf/"
fi



cat $result

echo ; echo
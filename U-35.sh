#!/bin/bash

. function.sh

BAR

CODE [U-35] 웹서비스 디렉토리 리스팅 제거

cat << EOF >> $result

[양호]: 디렉터리 검색 기능을 사용하지 않는 경우

[취약]: 디렉터리 검색 기능을 사용하는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# Apache 구성 파일 정의
file="/[Apache_home]/conf/httpd.conf"

# 파일이 있는지 확인
if [ -f "$file" ]; then
    #  vi 편집기에서 파일을 열고 "Options"을 검색
    vi +/Options "$file"
    # "Options Indexes"을 "Options"으로 바꾸기
    :%s/Options Indexes/Options/g
    # 파일 저장 후 종료
    :wq
else
    echo "httpd.conf file not found in /[Apache_home]/conf/"
fi




cat $result

echo ; echo
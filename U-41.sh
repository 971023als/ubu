#!/bin/bash

. function.sh

BAR

CODE [U-41] 웹서비스 영역의 분리

cat << EOF >> $result

[양호]: DocumentRoot를 별도의 디렉터리로 지정한 경우

[취약]: DocumentRoot를 기본 디렉터리로 지정한 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# @@@@@@@@@@@@@@@@@@@@@@별도의 디렉터리 경로를 아래처럼 할 것인지 확인 필요@@@@@@@@@@@@@@@@@@@@@@@@@222
# 새 DocumentRoot 정의
NEW_DOCUMENT_ROOT="/path/to/new/document/root"

# 현재 httpd.conf 파일 백업
cp /usr/local/etc/apache2/apache2.conf /usr/local/apache2/conf/httpd.conf.bak

# 현재 DocumentRoot를 새 DocumentRoot로 바꾸기
sed -i "s@DocumentRoot /usr/local/apache2/htdocs@DocumentRoot $NEW_DOCUMENT_ROOT@g" /usr/local/etc/apache2/apache2.conf

# Apache를 재시작하여 변경 내용 적용
systemctl restart apache2







cat $result

echo ; echo
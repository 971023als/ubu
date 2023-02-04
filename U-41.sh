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

# Apache의 구성 디렉터리로 변경
file="/etc/apache2/sites-enabled/"

# DocumentRoot 값을 원하는 경로로 바꿉니다
sed -i 's#DocumentRoot /var/www/html#DocumentRoot /home/ubuntu/newphp/' $file







cat $result

echo ; echo
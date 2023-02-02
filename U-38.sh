#!/bin/bash

. function.sh

BAR

CODE [U-38] 웹서비스 불필요한 파일 제거

cat << EOF >> $result

[양호]: 기본으로 생성되는 불필요한 파일 및 디렉터리가 제거되어 있는 경우

[취약]: 기본으로 생성되는 불필요한 파일 및 디렉터리가 제거되지 않은 경우 

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# 불필요한 파일 및 디렉터리 확인
echo "Checking for unnecessary files and directories in Apache home directory..."
find /etc/apache2/apache2.conf -type d -name "manual"

# manual 디렉터리 및 파일 제거
echo "Removing manual directory and files..."
sudo rm -rf /etc/apache2/apache2.conf/manual

# 파일 및 디렉터리가 제거되었는지 확인
echo "Verifying that the manual directory and files were removed..."
ls /etc/apache2/apache2.conf



cat $result

echo ; echo
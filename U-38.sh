#!/bin/bash

. function.sh

BAR

CODE [U-38] 웹서비스 불필요한 파일 제거

cat << EOF >> $result

[양호]: 기본으로 생성되는 불필요한 파일 및 디렉터리가 제거되어 있는 경우

[취약]: 기본으로 생성되는 불필요한 파일 및 디렉터리가 제거되지 않은 경우 

EOF

BAR
 

# 불필요한 파일 및 디렉터리 확인
INFO "Apache 홈 디렉토리에서 불필요한 파일 및 디렉터리 확인..."
find /etc/apache2/apache2.conf -type d -name "manual"

# manual 디렉터리 및 파일 제거
INFO "수동 디렉터리 및 파일 제거..."
sudo rm -rf /etc/apache2/apache2.conf/manual

# 파일 및 디렉터리가 제거되었는지 확인
INFO "수동 디렉터리 및 파일이 제거되었는지 확인하는 중..."
ls /etc/apache2/apache2.conf



cat $result

echo ; echo
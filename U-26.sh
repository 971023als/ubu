#!/bin/bash

. function.sh

BAR

CODE [U-26] automountd 제거

cat << EOF >> $result

[양호]: automountd 서비스가 비활성화 되어 있는 경우

[취약]: automountd 서비스가 활성화 되어 있는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# 자동 마운트 스크립트의 위치를 확인
location=$(ls -al /etc/rc.d/rc*.d/* | grep automount)

# 스크립트가 있는지 확인
if [ -n "$location" ]
then
  # 대본의 이름을 바꾸기
  mv $location /etc/rc.d/rc2.d/_S28automountd
else
  # 스크립트가 없다는 오류 메시지를 인쇄
  echo "Error: Automount script not found."
fi

cat $result

echo ; echo
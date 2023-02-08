#!/bin/bash

. function.sh

BAR

CODE [U-33]  DNS 보안 버전 패치 '확인 필요'

cat << EOF >> $result
[양호]: DNS 서비스를 사용하지 않거나 주기적으로 패치를 관리하고 있는 경우

[취약]: DNS 서비스를 사용하며 주기적으로 패치를 관리하고 있지 않는 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# 명명된 프로세스가 실행 중인지 확인하십시오
result=$(ps -ef | grep named | grep -v grep)

pid=$(echo $result | awk '{print $2}')

# 프로세스 ID를 사용하여 명명된 프로세스 중지
kill $pid



cat $result

echo ; echo
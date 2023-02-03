#!/bin/bash

 

. function.sh 
   

BAR

CODE [U-42] 최신 보안패치 및 벤더 권고사항 적용

cat << EOF >> $result

[양호]: 패치 적용 정책을 수립하여 주기적으로 패치를 관리하고 있는 경우

[취약]: 패치 적용 정책을 수립하지 않고 주기적으로 패치관리를 하지 않는 경우

EOF

BAR


TMP1=`SCRIPTNAME`.log

>$TMP1  

# 로그 파일 경로 설정
log_file="/var/log/patch.log"

# 패치 로그 파일이 존재하는지 확인
if [ ! -f $log_file ]; then
  touch $log_file
fi

# 패치 설치
apt update
apt upgrade -y

# 설치된 패치 기록
echo "Patches installed at $(date)" >> $log_file

# 설치된 패치 확인
if apt -s dist-upgrade | grep "0 upgraded, 0 newly installed"; then
  OK "No new patches available"
else
  WARN "New patches available"
fi





cat $result

echo ; echo 

 

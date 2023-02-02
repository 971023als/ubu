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

# Set the log file path
log_file="/var/log/patch.log"

# Check if the patch log file exists
if [ ! -f $log_file ]; then
  touch $log_file
fi

# Install patches
yum update
yum upgrade -y

# Log the patches installed
echo "Patches installed at $(date)" >> $log_file

# Verify installed patches
if yum -s dist-upgrade | grep "0 upgraded, 0 newly installed"; then
  OK "No new patches available"
else
  WARN "New patches available"
fi





cat $result

echo ; echo 

 

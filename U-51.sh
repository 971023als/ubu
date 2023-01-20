#!/bin/bash

 

. function.sh

 

TMP2=/tmp/tmp1

TMP3=/tmp/tmp2

TMP4=/tmp/tmp3

 

BAR

CODE [U-51] 계정이 존재하지 않는 GID 금지

cat << EOF >> $result

양호: 존재하지 않는 계정에 GID 설정을 금지한 경우

취약: 존재하지 않은 계정에 GID 설정이 되어있는 경우

EOF

BAR


TMP1=`SCRIPTNAME`.log

> $TMP1

# Prompt for group name
read -p "Enter group name: " group_name
ㅕ
# Check if group exists
if ! grep -q $group_name /etc/group; then
  WARN "group 존재하지 않음"
else
  OK "group 존재함"
fi

# Delete group
groupdel $group_name




 

cat $result

echo ; echo

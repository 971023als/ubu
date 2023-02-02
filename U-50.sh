#!/bin/bash

 

. function.sh

TMP2=$(mktemp)

 

BAR

CODE [U-50] 관리자 그룹에 최소한의 계정 포함

cat << EOF >> $result

양호: 관리자 그룹에 불필요한 계정이 등록되어 있지 않은 경우

취약: 관리자 그룹에 불필요한 계정이 등록되어 있는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1

# Prompt for username
read -p "Enter username: " username

# Check if user is a member of the "manager" group
if ! groups $username | grep -q 'manager'; then
  WARN "user 존재하지 않음"
else
  OK "user 존재함"
fi

# Remove user from the "manager" group
gpasswd -d $username manager

 

 

cat $result

echo ; echo

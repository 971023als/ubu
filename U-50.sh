#!/bin/bash

 

. function.sh

TMP1=`SCRIPTNAME`.log

> $TMP1

TMP2=$(mktemp)

 

BAR

CODE [U-50] 관리자 그룹에 최소한의 계정 포함

cat << EOF >> $result

양호: 관리자 그룹에 불필요한 계정이 등록되어 있지 않은 경우

취약: 관리자 그룹에 불필요한 계정이 등록되어 있는 경우

EOF

BAR


# Prompt for username
read -p "Enter username: " username

# Check if user is a member of the "administrator" group
if ! groups $username | grep -q 'administrator'; then
  echo "Error: User is not a member of the 'administrator' group"
  exit 1
fi

# Remove user from the "administrator" group
sudo deluser $username administrator


 

 

cat $result

echo ; echo

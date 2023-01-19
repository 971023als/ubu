#!/bin/bash

 

. function.sh

 

TMP2=$(mktemp)

TMP3=$(mktemp)

> $TMP2

> $TMP3

 

BAR

CODE [U-52] 동일한 UID 금지

cat << EOF >> $result

양호: 동일한 UID로 설정된 사용자 계정이 존재하지 않는 경우

취약: 동일한 UID로 설정된 사용자 계정이 존재하는 경우

EOF

BAR


TMP1=`SCRIPTNAME`.log

> $TMP1


# Prompt for username
read -p "Enter username: " username

# Prompt for new UID
read -p "Enter new UID: " new_uid

# Check if user exists
if ! grep -q $username /etc/passwd; then
  echo "Error: User does not exist"
fi

# Change user's UID
usermod -u $new_uid $username

 


 

cat $result

echo ; echo

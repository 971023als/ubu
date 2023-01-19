#!/bin/bash

 

. function.sh

 

TMP2=/tmp/tmp1

> $TMP2

 

BAR

CODE [U-53] 사용자 shell 점검

cat << EOF >> $result

[취약]: 로그인이 필요하지 않은 계정에 /bin/false(nologin) 쉘이 부여되어 있는 경우

[양호]: 로그인이 필요하지 않은 계정에 /bin/false(nologin) 쉘이 부여되지 않은 경우

EOF

BAR


TMP1=`SCRIPTNAME`.log

> $TMP1


# Prompt for username
read -p "Enter username: " username

# Check if user exists
if ! grep -q $username /etc/passwd; then
  echo "Error: User does not exist"
fi

# Change user's shell to /bin/false
usermod -s /bin/false $username

# or change user's shell to /sbin/nologin
# usermod -s /sbin/nologin $username





 

cat $result

echo ; echo

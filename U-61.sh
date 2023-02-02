#!/bin/bash

 

. function.sh

 

BAR

CODE [U-61] ftp 서비스 확인

cat << EOF >> $result

[양호]: FTP 서비스가 비활성화 되어 있는 경우

[취약]: FTP 서비스가 활성화 되어 있는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1   

# Define the account name
account_name="ftp"

# Find the line in the /etc/passwd file that corresponds to the account
line=$(grep "^$account_name:" /etc/passwd)

# Extract the current login shell
current_shell=$(echo $line | cut -d: -f7)

# Check if the current shell is already set to /bin/false
if [ "$current_shell" != "/bin/false" ]; then
  # Replace the current shell with /bin/false
  new_line=$(echo $line | sed "s#$current_shell#/bin/false#")

  # Update the /etc/passwd file
  sudo sed -i "s#$current_shell#$/bin/false#" /etc/passwd
fi



cat $result

echo ; echo 

#!/bin/bash

 

. function.sh
 

BAR

CODE [U-62] ftp 계정 shell 제한

cat << EOF >> $result

[양호]: ftp 계정에 /bin/false 쉘이 부여되어 있는 경우

[취약]: ftp 계정에 /bin/false 쉘이 부여되지 않 경우

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
  sudo sed -i "s#$line#$new_line#" /etc/passwd
fi





cat $result

echo ; echo 

 

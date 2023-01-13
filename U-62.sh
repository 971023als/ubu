#!/bin/bash

 

. function.sh

 
TMP1=`SCRIPTNAME`.log

> $TMP1 
 

BAR

CODE [U-62] ftp 계정 shell 제한

cat << EOF >> $result

[양호]: ftp 계정에 /bin/false 쉘이 부여되어 있는 경우

[취약]: ftp 계정에 /bin/false 쉘이 부여되지 않 경우

EOF

BAR


# Define the ftp account
FTP_ACCOUNT="ftpuser"

# Replace the login shell for the ftp account in the /etc/passwd file
sed -i "s/^${FTP_ACCOUNT}.*/${FTP_ACCOUNT}:x:1001:1001::\/home\/${FTP_ACCOUNT}:\/bin\/false/g" /etc/passwd




cat $result

echo ; echo 

 

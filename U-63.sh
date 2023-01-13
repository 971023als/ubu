#!/bin/bash

 

. function.sh

 
TMP1=`SCRIPTNAME`.log

> $TMP1 
 

BAR

CODE [U-63] ftpusers 파일 소유자 및 권한 설정

cat << EOF >> $result

[양호]: ftpusers 파일의 소유자가 root이고, 권한이 640 이하인 경우

[취약]: ftpusers 파일의 소유자가 root아니거나, 권한이 640 이하가 아닌 경우

EOF

BAR


# Change ownership of the ftpusers file to root
chown root:root /etc/vsftpd/ftpusers

# Change permissions of the ftpusers file to 640
chmod 640 /etc/vsftpd/ftpusers



cat $result

echo ; echo 

 

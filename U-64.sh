#!/bin/bash

 

. function.sh
 

BAR

CODE [U-64] ftpusers 파일 설정

cat << EOF >> $result

[양호]: FTP 서비스가 비활성화 되어 있거나, 활성 시 root 계정 접속을 차단한 경우

[취약]: FTP 서비스가 활성화 되어 있고, root 계정 접속을 허용한 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1 

# change the shell of the root account to /bin/false
if [ $(grep "^root" /etc/passwd | awk -F: '{print $7}') != "/bin/false" ]; then
  sed -i 's#^root.*#root:x:0:0:root:/root:/bin/false#' /etc/passwd
  echo "Root account shell has been changed to /bin/false to prevent direct FTP access."
else
  echo "Root account shell is already set to /bin/false."
fi




cat $result

echo ; echo 


 

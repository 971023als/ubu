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






cat $result

echo ; echo 

 

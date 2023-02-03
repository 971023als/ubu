#!/bin/bash

. function.sh

BAR

CODE [U-09] /etc/hosts 파일 소유자 및 권한 설정

cat << EOF >> $result

[양호]: /etc/hosts 파일의 소유자가 root이고, 권한이 600인 이하경우

[취약]: /etc/hosts 파일의 소유자가 root가 아니거나, 권한이 600 이상인 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# 소유자 및 그룹을 루트로 변경
sudo chown root:root /etc/inetd.conf

# 권한을 600으로 변경(읽기-쓰기 소유자만 해당)
sudo chmod 600 /etc/inetd.conf



# 소유자 및 그룹을 루트로 변경
sudo chown root:root /etc/xinetd.conf

#  권한을 600으로 변경(읽기-쓰기 소유자만 해당)
sudo chmod 600 /etc/xinetd.conf

# 하위 파일...

cat $result

echo ; echo
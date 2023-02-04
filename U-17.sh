#!/bin/bash

. function.sh

BAR

CODE [U-17] $HOME/.rhosts, hosts.equiv 사용 금지

cat << EOF >> $result

[양호]: login, shell, exec 서비스를 사용하지 않거나, 사용 시 아래와 같은 설정이 적용된 경우
       1. /etc/hosts.equiv 및 $HOME/.rhosts 파일 소유자가 root 또는, 해당 계정인 경우
       2. /etc/hosts.equiv 및 $HOME/.rhosts 파일 권한이 600 이하인 경우
       3. /etc/hosts.equiv 및 $HOME/.rhosts 파일 설정에 ‘+’ 설정이 없는 경우

[취약]: login, shell, exec 서비스를 사용하고, 위와 같은 설정이 적용되지 않은 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  


# /etc/hosts.equiv에 대한 소유자 및 사용 권한 설정
if [ -f /etc/hosts.equiv ]; then
  chown root:root /etc/hosts.equiv
  chmod 600 /etc/hosts.equiv
# Set '+' to equiv in /etc/hosts.equiv
  echo "+" > /etc/hosts.equiv
fi

# $HOME/.r 호스트에 대한 소유자 및 사용 권한 설정
for dir in $(cat /etc/passwd | awk -F: '{print $6}'); do
  if [ -f "$dir/.rhosts" ]; then
    chown root:root "$dir/.rhosts"
    chmod 600 "$dir/.rhosts"
  fi
# 각 사용자에 대해 '+'를 $HOME/.rhosts로 설정
for user in $(ls /home); do
  echo "+" > /home/$user/.rhosts
done



cat $result

echo ; echo
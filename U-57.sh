#!/bin/bash

 

. function.sh

TMP1=`SCRIPTNAME`.log

> $TMP1  

 

BAR

CODE [U-57] 홈 디렉터리 소유자 및 권한

cat << EOF >> $result

[양호]: 홈 디렉터리 소유자가 해당 계정이고, 일반 사용자 쓰기 권한이 제거된 경우

[취약]: 홈 디렉터리 소유자가 해당 계정이 아니고, 일반 사용자 쓰기 권한이 부여된 경우 

EOF

BAR



# Check home directories for incorrect permissions
for user in $(awk -F: '{ if ($3 >= 1000 && $3 <= 60000) print $1}' /etc/passwd); do
  if [ -d /home/$user ]; then
    owner=$(stat -c %U /home/$user)
    permissions=$(stat -c %a /home/$user)
    if [ "$owner" != "$user" ] || [ "$permissions" != "700" ]; then
      echo "Fixing permissions for /home/$user"
      chown $user:$user /home/$user
      chmod 700 /home/$user
    fi
  fi
done






cat $result

echo ; echo 


 

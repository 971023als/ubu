#!/bin/bash

 

. function.sh


 

BAR

CODE [U-57] 홈 디렉터리 소유자 및 권한

cat << EOF >> $result

[양호]: 홈 디렉터리 소유자가 해당 계정이고, 일반 사용자 쓰기 권한이 제거된 경우

[취약]: 홈 디렉터리 소유자가 해당 계정이 아니고, 일반 사용자 쓰기 권한이 부여된 경우 

EOF

BAR


TMP1=`SCRIPTNAME`.log

> $TMP1


# UID가 1000에서 60000 사이인 각 사용자를 루프합니다
for user in $(awk -F: '{ if ($3 >= 1000 && $3 <= 60000) print $1}' /etc/passwd); do
  # 사용자에게 홈 디렉토리가 있는지 확인합니다
  if [ -d /home/$user ]; then
    # 홈 디렉토리의 소유자 및 사용 권한 가져오기
    owner=$(stat -c %U /home/$user)
    permissions=$(stat -c %a /home/$user)

    # 소유자가 사용자가 아니거나 사용 권한이 700이 아닌지 확인하십시오
    if [ "$owner" != "$user" ] || [ "$permissions" != "700" ]; then
      # 홈 디렉토리의 소유자 및 권한 수정
      INFO "/home/$user에 대한 사용 권한 수정 중"
      sudo chown $user:$user /home/$user
      sudo chmod 700 /home/$user
    fi
  fi
done



cat $result

echo ; echo 


 

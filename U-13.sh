#!/bin/bash

. function.sh

BAR

CODE [U-13] SUID, SGID, 설정 파일점검

cat << EOF >> $result

[양호]: 주요 실행파일의 권한에 SUID와 SGID에 대한 설정이 부여되어 있지 않은 경우

[취약]: 주요 실행파일의 권한에 SUID와 SGID에 대한 설정이 부여되어 있는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

#@@@@@@@@@@@@@@@@@@@@@@@조치를 어떻게 하는 지 확인필요@@@@@@@@@@@@@@@@
# (불필요한 파일네임을 확인해야함)
# 기본 실행 파일에서 SUID 및 SGID 사용 권한 제거
file_name="/usr/bin/main"
chmod -s $file_name


# 주기적인 감사방법 (굳이 와일문, sleep 써야하는지 확인 한번더)
while true
do
    # SUID 또는 SGID 비트가 설정된 루트가 소유한 모든 파일 찾기
    find / -xdev -user root \( -perm -04000 -o -perm -02000 \) -type f -exec ls -al {} \;

    # 하루동안 Sleep 
    sleep 86400
done


# 반드시 사용이 필요한 경우 특정 그룹에서만 사용하도록 제한하는 방법
# (아래 변수는 사용자에게 입력받아서 그룹이름이랑 해당 파일을 )
setuid_file_name="/usr/bin/setuid_file"
allowed_group="sudo"

# setuid 파일의 그룹을 허용된 그룹으로 변경
/usr/bin/chgrp $allowed_group $setuid_file_name

# setuid 파일의 사용 권한을 변경하여 소유자 및 허용된 그룹이 실행할 수 있도록 하고 다른 사용자는 허용하지 않도록 함
/usr/bin/chmod 4750 $setuid_file_name



cat $result

echo ; echo
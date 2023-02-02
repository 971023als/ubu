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

# SUID(사용자 ID 설정) 또는 SGID(그룹 ID 설정) 비트가 설정된 시스템의 모든 파일을 찾고 권한 및 소유권 정보를 표시
find / -type f \( -perm /u+s -o -perm /g+s \) -exec ls -l {} \;

# SUID 또는 SGID 비트가 설정된 시스템의 모든 파일을 찾은 다음 제거
sudo find / -type f \( -perm /u+s -o -perm /g+s \) -exec chmod u-s,g-s {} \;



cat $result

echo ; echo
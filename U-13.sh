#!/bin/bash

. function.sh

BAR

CODE [U-13] SUID, SGID, Sticky bit 설정 및 권한 설정		

cat << EOF >> $result

[양호]: 주요 실행파일의 권한에 SUID와 SGID에 대한 설정이 부여되어 있지 않은 
경우

[취약]: 주요 실행파일의 권한에 SUID와 SGID에 대한 설정이 부여되어 있는 경우

EOF

BAR

# 실행 파일의 경로 지정
executables=("/bin/ping" "/usr/bin/passwd" "/usr/bin/sudo")
# 파일이 있는지 확인합니다
if [ ! -e $executables ]; then
  INFO "$exec_file이 없습니다."
fi

# SUID 및 SGID 사용 권한 제거
chmod u-s $executables
chmod g-s $executables

INFO "$executables 에서 제거된 SUID 및 SGID 권한."




cat $result

echo ; echo

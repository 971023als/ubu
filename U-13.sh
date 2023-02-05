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

executables=("/bin/ping" "/usr/bin/passwd" "/usr/bin/sudo")

for exec in "${executables[@]}"; do
  # SUID 설정
  chmod u+s "$exec"
  if [ $? -eq 0 ]; then
    OK "SUID가 $exec 에 설정되었습니다."
  else
    WARN "ERROR: $exec에 SUID를 설정하지 못했습니다."
  fi

  # Set SGID
  chmod g+s "$exec"
  if [ $? -eq 0 ]; then
    OK "SGID가 $exec 에 설정되었습니다."
  else
    WARN "$exec 에 SGID를 설정하지 못했습니다."
  fi
done




cat $result

echo ; echo

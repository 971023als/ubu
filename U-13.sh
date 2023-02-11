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

# /etc/passwd 파일을 읽고 홈 디렉토리 정보 추출
while IFS=: read -r username passwd uid gid name home shell
do
  # 각 홈 디렉토리에 대해 반복
  if [ -d "$home" ]; then
    # 홈 디렉토리에서 기본 실행 파일의 사용 권한 정보를 가져옵니다
    main_exec=$(find "$home" -type f \( -perm -04000 -o -perm -02000 \) -exec ls -al {} \;)

    # 주 실행 파일이 존재하는 경우
    if [ -n "$main_exec" ]; then
      # 권한 정보를 가져옵니다
      permissions=$(ls -ld "$main_exec" | awk '{print $1}')
      owner=$(ls -ld "$main_exec" | awk '{print $3}')
      group=$(ls -ld "$main_exec" | awk '{print $4}')

      new_permissions=$((permissions & ~04000))

      new_permission=$((permissions & ~02000))

      # SUID 또는 SGID가 설정되어 있는지 확인합니다
      if [[ $permissions == *"r-s"* ]]; then
        INFO "SUID가 $main_exec 로 설정됨"
        sudo "$new_permissions" "$main_exec"
      elif [[ $permissions == *"r-S"* ]]; then
        INFO "SGID가 $main_exec 로 설정됨"
        sudo "$new_permission" "$main_exec"
      fi
    fi
  fi
done < /etc/passwd

cat $result

echo ; echo

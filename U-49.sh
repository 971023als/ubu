#!/bin/bash

 

. function.sh


 

BAR

CODE [U-49] 불필요한 계정 제거

cat << EOF >> $result

[양호]: 불필요한 계정이 존재하지 않는 경우

[취약]: 불필요한 계정이 존재하는 경우

EOF

BAR


TMP1=`SCRIPTNAME`.log

> $TMP1


# 계정이 비활성 상태로 간주되는 일 수
inactive_days=365

# 현재 날짜(초) 가져오기
current_date=$(date +%s)

#  /etc/passwd 파일의 모든 항목을 반복
while IFS=: read -r username _ _ uid _ _ home; do
  # 시스템 계정 건너뛰기
  if [ $uid -lt 1000 ]; then
    continue
  fi

  # 마지막으로 사용자의 홈 디렉토리에 액세스한 시간이 inactive_days보다 오래되었는지 확인합니다
  last_access=$(stat -c %X "$home")
  if [ $((current_date - last_access)) -gt $((inactive_days * 24 * 3600)) ]; then
    # 사용자 계정 제거
    userdel "$username"
    if [ $? -eq 0 ]; then
      OK "사용자 계정 제거 성공: $username"
    else
      WARN "사용자 계정을 제거하지 못했습니다. $username"
    fi
  fi
done < /etc/passwd


 
cat $result

echo ; echo

#!/bin/bash

. function.sh

BAR

CODE [U-43] 로그의 정기적 검토 및 보고

cat << EOF >> $result

[양호]: 접속기록 등의 보안 로그, 응용 프로그램 및 시스템 로그 기록에 대해 정기적으로 검토, 분석, 리포트 작성 및 보고 등의 조치가 이루어지는 경우

[취약]: 위 로그 기록에 대해 정기적으로 검토, 분석, 리포트 작성 및 보고 등의 조치가 이루어 지지 않는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# 마지막 로그인 시간 확인
echo "Checking last login time..."
last -a

# 액세스 IP 확인
echo "Checking access IP..."
last -a | grep "still logged in"

# 실패한 로그인 기록 확인
echo "Checking failed login history..."
grep "Failed password" /var/log/auth.log

# 허용된 계정 정의
allowed_accounts=("root" "bin" "daemon" "adm" "lp" "sync" "shutdown" "halt" "ubuntu" "user")

# sulog에서 권한 상승 시도 여부를 점검하십시오
echo "Checking sulog for attempted privilege escalation..."
while read line; do
  username=$(echo $line | awk '{print $1}')
  if [[ ! " ${allowed_accounts[@]} " =~ " ${username} " ]]; then
    echo "권한 상승 시도: $line"
  fi
done < /var/log/sulog

cat $result

echo ; echo
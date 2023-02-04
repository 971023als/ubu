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


# 현재 날짜 및 시간 저장
current_date_time=$(date +"%Y-%m-%d %T")

# su를 사용한 사용자의 사용자 이름 가져오기
username=$(last | awk '/su/ {print $1}')

# sulog 파일에 로그 추가
echo "$current_date_time $username used su" >> /var/log/sulog


# 실패한 최대 로그인 시도 횟수 설정
max_attempts=5

# 실패한 로그인 이벤트에서 사용자 이름 가져오기
username=$(grep "Failed password" /var/log/auth.log | tail -n 1 | awk '{print $(NF-5)}')

# 사용자 이름에 대한 로그인 시도 실패 횟수 카운트
attempts=$(grep "Failed password" /var/log/auth.log | grep "$username" | wc -l)

# 실패한 시도 횟수가 최대값보다 큰지 확인
if [ "$attempts" -gt "$max_attempts" ]; then
  # 현재 날짜 및 시간 저장
  current_date_time=$(date +"%Y-%m-%d %T")

  # auth_logs 파일에 로그 저장
  echo "$current_date_time $username has exceeded the maximum number of failed login attempts ($max_attempts)" >> /var/log/auth_logs
fi


# 로그인 거부 이벤트에서 사용자 이름 가져오기
username=$(grep "authentication failure" /var/log/auth.log | tail -n 1 | awk '{print $(NF-5)}')

# 현재 날짜 및 시간 저장
current_date_time=$(date +"%Y-%m-%d %T")

# auth_logs 파일에 로그 저장
echo "$current_date_time Login rejection for user $username" >> /var/log/auth_logs


cat $result

echo ; echo
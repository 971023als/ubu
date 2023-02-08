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

# 검사할 로그 파일 정의
log_files=(/var/log/wtmp /var/log/btmp /var/log/lastlog)

# 로그 파일을 확인하는 기능 정의
check_log_files() {
  for log in "${log_files[@]}"; do
    if [ -f "$log" ]; then
      INFO "$log 파일 확인 중"
      last -f "$log"
    else
      WARN "$log 파일을 찾을 수 없음"
    fi
  done
}

# 로그 파일을 확인하기 위해 함수를 호출합니다
check_log_files


ALLOWED_USERS=(
  "root"
  "bin"
  "daemon"
  "adm"
  "lp"
  "sync"
  "shutdown"
  "halt"
  "ubuntu"
  "user"
  "messagebus"
  "syslog"
  "avahi"
  "kernoops"
  "whoopsie"
  "colord"
  "systemd-network"
  "systemd-resolve"
  "systemd-timesync"
  "mysql"
  "dbus"
  "rpc"
  "rpcuser"
  "haldaemon"
  "apache"
  "postfix"
  "gdm"
  "adiosl"
  "cubrid"
)

LOG_FILE="sulog"
UNAUTH_LOG="unauthorized_su.log"

# 로그 파일의 각 줄을 확인합니다
while read line
do
  # 줄에서 사용자 이름 추출
  username=$(echo $line | awk '{print $1}')

  # 사용자 이름이 허용 목록에 없는지 확인합니다
  if [[ ! "$ALLOWED_USERS" =~ "$username" ]]; then
    # 무단 시도를 기록합니다
    echo "$line" >> $UNAUTH_LOG
  fi
done < $LOG_FILE


# xferlog 파일이 있는지 확인합니다
if [ ! -f "/var/log/xferlog" ]; then
  echo "Error: xferlog file not found."
fi

# 현재 날짜 및 시간을 변수에 저장
now=$(date +"%Y-%m-%d %T")

# xferlog 파일 내용을 변수에 저장
xferlog=$(cat /var/log/xferlog)

# 무단 액세스 검색
unauthorized=$(echo "$xferlog" | grep -vE "anonymous|ftp")

# 무단 액세스가 기록되었는지 확인하십시오
if [ -z "$unauthorized" ]; then
  OK "[$now] 무단 FTP 액세스가 탐지되지 않았습니다."
else
  WARN "[$now] 무단 FTP 액세스가 탐지되었습니다."
  INFO "$unauthorized"
fi




cat $result

echo ; echo
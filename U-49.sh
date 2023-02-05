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

# 보관할 계정 목록
keep_list=(
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

# 모든 사용자 계정 목록 가져오기
all_accounts=$(cut -d: -f1 /etc/passwd)

# 모든 그룹에 반복
for account in $all_accounts; do
  if ! [[ "${keep_list[@]}" =~ " ${account}" ]]; then
    # 유지할 그룹 목록에 없는 그룹 제거
    sudo userdel "$account"
  fi
done

 
cat $result

echo ; echo

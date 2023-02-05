#!/bin/bash

 

. function.sh

 

TMP2=/tmp/tmp1

> $TMP2

 

BAR

CODE [U-53] 사용자 shell 점검

cat << EOF >> $result

[취약]: 로그인이 필요하지 않은 계정에 /bin/false(nologin) 쉘이 부여되어 있는 경우

[양호]: 로그인이 필요하지 않은 계정에 /bin/false(nologin) 쉘이 부여되지 않은 경우

EOF

BAR


TMP1=`SCRIPTNAME`.log

> $TMP1


# 필수 계정 배열
required_accounts=(
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

# 모든 사용자를 순환시키다
for user in $(cut -d: -f1 /etc/passwd); do
  # 사용자가 필수 계정 목록에 없는지 확인합니다
  if ! [[ " ${required_accounts[@]} " =~ " ${user} " ]]; then
    # 불필요한 사용자에 대해 셸을 nonlogin으로 변경
    sudo usermod -s /bin/false $user
  fi
done






 

cat $result

echo ; echo

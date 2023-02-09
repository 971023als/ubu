#!/bin/bash

. function.sh

BAR

CODE [U-51] 계정이 존재하지 않는 GID 금지

cat << EOF >> $result

양호: 존재하지 않는 계정에 GID 설정을 금지한 경우

취약: 존재하지 않은 계정에 GID 설정이 되어있는 경우

EOF

BAR

# 보관할 그룹 목록
keep_groups=("root" "sudo" "sys" "adm" "wheel" 
"daemon" "bin" "lp" "dbus" "rpc" "rpcuser" "haldaemon" 
"apache" "postfix" "gdm" "adiosl" "mysql" "cubrid"
 "messagebus" "syslog" "avahi" "whoopsie"
"colord" "systemd-network" "systemd-resolve"
"systemd-timesync" "mysql" "user"
"www-data" "sync")

# 모든 그룹 목록 가져오기
all_groups=$(cut -d: -f1 /etc/group)

# 모든 그룹에 반복
for group in $all_groups; do
  if ! [[ "${keep_groups[@]}" =~ "$group" ]]; then
    # 유지할 그룹 목록에 없는 그룹 제거
    sudo groupdel "$group"
  fi
done


cat $result

echo ; echo

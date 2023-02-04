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


necessary_accounts=("root" "bin" "daemon" "adm" 
"lp" "sync" "shutdown" "halt" "ubuntu" "user"
"messagebus" "syslog" "avahi" "kernoops"
"whoopsie" "colord" "systemd-network" 
"systemd-resolve""systemd-timesync" "mysql"
 "dbus" "rpc" "rpcuser" "haldaemon" 
"apache" "postfix" "gdm" "adiosl")

all_users=$(getent passwd | awk -F: '{print $1}')

for user in $all_users; do
  if ! echo "${necessary_accounts[@]}" | grep -wq "$user"; then
    userdel "$user"
  fi
done


 
cat $result

echo ; echo

#!/bin/bash

. function.sh

BAR

CODE [U-45] root 계정 su 제한		

cat << EOF >> $result

[양호]: su 명령어를 특정 그룹에 속한 사용자만 사용하도록 제한되어 있는 경우
※ 일반사용자 계정 없이 root 계정만 사용하는 경우 su 명령어 사용제한 불필요

[취약]: su 명령어를 모든 사용자가 사용하도록 설정되어 있는 경우

EOF

BAR


# wheel group 삭제
groupdel wheel

# wheel group 생성
groupadd wheel

# su 명령의 그룹을 휠 그룹으로 변경합니다
chgrp wheel /usr/bin/su

# su 명령에 대한 사용 권한을 4750으로 설정합니다
chmod 4750 /usr/bin/su

# 휠 그룹에 허용된 사용자 계정 추가

usermod -aG wheel root
usermod -aG wheel bin
usermod -aG wheel daemon
usermod -aG wheel adm
usermod -aG wheel lp
usermod -aG wheel sync
usermod -aG wheel shutdown
usermod -aG wheel halt
usermod -aG wheel ubuntu
usermod -aG wheel user
usermod -aG wheel messagebus
usermod -aG wheel syslog
usermod -aG wheel avahi
usermod -aG wheel kernoops
usermod -aG wheel whoopsie
usermod -aG wheel colord
usermod -aG wheel systemd-network
usermod -aG wheel systemd-resolve
usermod -aG wheel systemd-timesync
usermod -aG wheel mysql
usermod -aG wheel dbus
usermod -aG wheel rpc
usermod -aG wheel rpcuser
usermod -aG wheel haldaemon
usermod -aG wheel apache
usermod -aG wheel postfix
usermod -aG wheel gdm
usermod -aG wheel adiosl




cat $result

echo ; echo


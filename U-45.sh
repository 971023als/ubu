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

sudo group del wheel

# su 명령의 그룹을 휠 그룹으로 변경합니다
chgrp wheel /bin/su

# su 명령의 사용 권한을 변경하여 새 셸을 만들 수 있도록 허용
chmod 4750 /bin/su

# 지정한 계정을 새 셸에 추가합니다
new_accounts=("root bin daemon adm 
lp sync shutdown halt ubuntu user
messagebus syslog avahi kernoops
whoopsie colord systemd-network 
systemd-resolve systemd-timesync mysql
dbus rpc rpcuser haldaemon 
apache postfix gdm")

echo "Adding accounts: $new_accounts"
for account in $new_accounts; do
  usermod -a -G wheel $account
done



cat $result

echo ; echo


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

# 시스템에 사용자가 있는지 확인합니다
function check_user() {
  if id "$1" > /dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}

# su 명령에 액세스해야 하는 사용자 배열
user_list=("root" "bin" "daemon"  
"lp" "sync" "user" "messagebus" 
"syslog" "avahi" "kernoops"
"whoopsie" "colord" "systemd-network" 
"systemd-resolve" "systemd-timesync" 
"mysql" "gdm" )

# 사용자 목록을 순환
for user in "${user_list[@]}"; do
  # Check if the user exists
  if check_user "$user"; then
    # 휠 그룹에 사용자 추가
    usermod -aG wheel "$user"
    # 사용자가 이미 휠 그룹에 속해 있는지 확인하십시오
    if groups "$user" | grep &>/dev/null '\bwheel\b'; then
      INFO "사용자 $user 는 이미 휠 그룹에 속해 있습니다."
    else
      OK "사용자 $user 가 휠 그룹에 추가되었습니다."
    fi
  else
    INFO "사용자 $user가 시스템에 없습니다."
  fi
done

# su 명령에서 권한을 4750으로 설정합니다
sudo chmod 4750 /bin/su

# 사용 권한 확인
if [ $(stat -c %a /bin/su) == "4750" ]; then
  OK "/bin/su에 대한 권한이 4750으로 설정되었습니다."
else
  WARN "/bin/su에 대한 사용 권한을 설정하지 못했습니다."
fi


cat $result

echo ; echo


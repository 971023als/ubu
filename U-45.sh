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


# /etc/pam.d/su 파일을 아래와 같이 설정(주석제거)
auth sufficient /lib/security/pam_rootok.so
auth required /lib/security/pam_wheel.so debug group=wheel
auth sufficient /lib/security/$ISA/pam_rootok.so
auth required /lib/security/$ISA/pam_wheel.so use_uid



# wheel 그룹에 su 명령어를 사용할 사용자 추가
usermod -G wheel [username]

# /etc/group 파일을 수정하여 필요한 계정 추가
wheel:x:10:root,username

cat $result

echo ; echo


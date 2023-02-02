#!/bin/bash

. function.sh

BAR

CODE [U-24] NFS 서비스 비활성화		

cat << EOF >> $result

[양호]: 불필요한 NFS 서비스 관련 데몬이 비활성화 되어 있는 경우

[취약]: 불필요한 NFS 서비스 관련 데몬이 활성화 되어 있는 경우

EOF

BAR



#
sudo exportfs -rav

#
sudo service nfs restart



# NFS 서비스 데몬을 중지
sudo service nfs stop

# NFS 서비스 실행 여부 확인
sudo service nfs status

# nfsd, statd 및 mountd의 상태 표시
sudo service nfsd status
sudo service statd status
sudo service mountd status



# 스크립트의 이름 변경
sudo rm <script_name>

#
sudo mv <script_name> <new_script_name>

# 
sudo chkconfig <script_name> off

cat $result

echo ; echo

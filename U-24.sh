#!/bin/bash

. function.sh

BAR

CODE [U-24] NFS 서비스 비활성화		

cat << EOF >> $result

[양호]: 불필요한 NFS 서비스 관련 데몬이 비활성화 되어 있는 경우

[취약]: 불필요한 NFS 서비스 관련 데몬이 활성화 되어 있는 경우

EOF

BAR

# NFS 관련 프로세스의 PID 찾기
PIDs=$(ps -ef | grep "nfs\|statd\|lockd" | awk '{print $2}')

# NFS 관련 프로세스 중지
for PID in $PIDs; do
    kill -9 $PID
done

# 부팅 시 NFS 서비스 사용 안 함
if [ -f "/etc/rc.d/rc2.d/S60nfs" ]; then
    mv /etc/rc.d/rc2.d/S60nfs /etc/rc.d/rc2.d/_S60nfs
fi


cat $result

echo ; echo

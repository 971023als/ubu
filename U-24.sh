#!/bin/bash

. function.sh

BAR

CODE [U-24] NFS 서비스 비활성화		

cat << EOF >> $result

[양호]: 불필요한 NFS 서비스 관련 데몬이 비활성화 되어 있는 경우

[취약]: 불필요한 NFS 서비스 관련 데몬이 활성화 되어 있는 경우

EOF

BAR

# 명명된 프로세스가 실행 중인지 확인하십시오
result=$(ps -ef | egrep "nfs|statd|lockd" | grep -v grep)

pid=$(echo $result | awk '{print $2}')

# 프로세스 ID를 사용하여 명명된 프로세스 중지
kill $pid

mv /etc/rc.d/rc2.d/S60nfs /etc/rc.d/rc2.d/_S60nfs

cat $result

echo ; echo

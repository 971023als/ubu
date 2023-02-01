#!/bin/bash

. function.sh

BAR

CODE [U-28] NIS, NIS+ 점검

cat << EOF >> $result

[양호]: NIS 서비스가 비활성화 되어 있거나, 필요 시 NIS+를 사용하는 경우

[취약]: NIS 서비스가 활성화 되어 있는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# NFS 서비스 데몬 중지
# [PID]를 프로세스의 실제 PID로 바꾸기
kill -9 [PID]

# NFS 시작 스크립트의 위치를 확인
ls -al /etc/rc.d/rc*.d/* | egrep "ypserv|ypbind|ypxfrd|rpc.yppasswdd|rpc.ypupdated"

# NFS 시작 스크립트 이름 바꾸기
mv /etc/rc.d/rc2.d/S73ypbind /etc/rc.d/rc2.d/_S73ypbind


cat $result

echo ; echo
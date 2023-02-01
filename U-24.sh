#!/bin/bash

. function.sh

BAR

CODE [U-24] NFS 서비스 비활성화

cat << EOF >> $result

[양호]: 불필요한 NFS 서비스 관련 데몬이 비활성화 되어 있는 경우

[취약]: 불필요한 NFS 서비스 관련 데몬이 활성화 되어 있는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  


# NFS 서비스 데몬 중지
kill -9 $(pidof nfsd)

# 시작 스크립트 찾기
if ls -al /etc/rc.d/rc*.d/* | grep -q "nfs"; then
  # 시작 스크립트 이름 바꾸기
  mv /etc/rc.d/rc2.d/S60nfs /etc/rc.d/rc2.d/_S60nfs
else
  echo "NFS startup script not found."
fi


cat $result

echo ; echo
#!/bin/bash

. function.sh

BAR

CODE [U-24] NFS 서비스 비활성화		

cat << EOF >> $result

[양호]: 불필요한 NFS 서비스 관련 데몬이 비활성화 되어 있는 경우

[취약]: 불필요한 NFS 서비스 관련 데몬이 활성화 되어 있는 경우

EOF

BAR

# dfstab 파일이 있는지 확인합니다
if [ -f "/etc/dfs/dfstab" ]; then
  # dfstab에서 모든 공유 제거
  > "/etc/dfs/dfstab"
  OK "공유가 /etc/dfs/dfstab에서 제거되었습니다."
elif [ -f "/etc/exports" ]; then
  # 내보내기에서 모든 공유 제거
  > "/etc/exports"
  OK "공유가 /etc/exports에서 제거되었습니다."
else
  INFO "공유 파일을 찾을 수 없습니다."
fi


services=("nfsd" "statd" "mountd")

for service in "${services[@]}"; do
  service "$service" stop
  if [ $? -eq 0 ]; then
    OK "$서비스가 중지되었습니다."
  else
    INFO "$service를 중지할 수 없습니다."
  fi
done




cat $result

echo ; echo

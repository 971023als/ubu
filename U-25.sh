#!/bin/bash

. function.sh

BAR

CODE [U-25] NFS 접근 통제

cat << EOF >> $result

[양호]: 불필요한 NFS 서비스를 사용하지 않거나, 불가피하게 사용 시 everyone 공유를 제한한 경우

[취약]: 불필요한 NFS 서비스를 사용하고 있고, everyone 공유를 제한하지 않은 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  


# 내보내기 파일 위치
exports_file="/etc/exports"

# 백업내보내기 파일
cp $exports_file "$exports_file.bak"

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@다시@@@@@@@@@@@@@@@@@@@@@@@@@@
# 모든 사용자 공유 설정 제거
sed -i '/^\/.*\s.*(.*)/d' $exports_file
# sed -i 's/\(^\/.*\)\s/\1 (root_squash)\t/' $exports_file

# NFS 파일 시스템 다시 내보내기
sudo exportfs -u
sudo exportfs -a

# NFS 서비스 다시 시작
sudo service nfs-kernel-server restart



cat $result

echo ; echo
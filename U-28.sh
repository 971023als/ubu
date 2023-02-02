#!/bin/bash

. function.sh

BAR

CODE [U-28] NIS , NIS+ 점검		

cat << EOF >> $result

[양호]: NIS 서비스가 비활성화 되어 있거나, 필요 시 NIS+를 사용하는 경우

[취약]: NIS 서비스가 활성화 되어 있는 경우

EOF

BAR

# nfs 데몬 서비스 중지
sudo systemctl stop nfs-server

# rm 명령을 사용하여 /etc/init.d/ 디렉토리에 있는 스크립트 파일을 삭제
sudo rm -f /etc/init.d/[script_name]

# mv 명령을 사용하여 /etc/init.d/ 디렉토리에 있는 스크립트 파일의 이름 변경
sudo mv /etc/init.d/[old_script_name] /etc/init.d/[new_script_name]

cat $result

echo ; echo

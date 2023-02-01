#!/bin/bash

. function.sh

BAR

CODE [U-27] RPC 서비스 확인

cat << EOF >> $result

[양호]: 불필요한 RPC 서비스가 비활성화 되어 있는 경우

[취약]: 불필요한 RPC 서비스가 활성화 되어 있는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# xinetd 서비스 다시 시작
sudo sed -i 's/rpc.cmsd.*/#&/g' /etc/inetd.conf
sudo service inetutils-inetd restart

# xinetd 일 경우!
# xinetd 디렉토리로 이동
cd /etc/xinetd.d/

# vi를 사용하여 디렉토리 "/etc/xinetd.d/"에서 불필요한 모든 RPC 서비스 파일 열기
for file in /etc/xinetd.d/*; do
    if grep -q "disable.*=.*yes" "$file"; then
        vi "$file"
    fi
done



# finger 파일 생성
echo "service finger
{
socket_type = stream
wait = no
user = nobody
server = /usr/sbin/in.fingerd
disable = yes
}" > /etc/xinetd.d/finger


cat $result

echo ; echo
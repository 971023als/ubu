#!/bin/bash

. function.sh

BAR

CODE [U-19] Finger 서비스 비활성화

cat << EOF >> $result

[양호]: Finger 서비스가 비활성화 되어 있는 경우

[취약]: Finger 서비스가 활성화 되어 있는 경우

EOF

BAR


TMP1=`SCRIPTNAME`.log

>$TMP1  

# /etc/inetd.conf에서 핑거 서비스 라인을 주석 처리
sed -i 's/^finger/#finger/' /etc/inetd.conf




# inetd 서비스의 PID를 가져오기
pid=$(pgrep inetd)

# inetd 서비스에 HUP 신호를 보내 구성을 다시 로드
kill -HUP $pid

# inetd 서비스가 다시 시작되었는지 확인
if pgrep inetd; then
  echo "inetd service restarted successfully"
else
  echo "inetd service failed to restart"
fi


## xinetd 경우 
# vi 편집기에서 핑거 서비스 파일 열기
vi /etc/xinetd.d/finger

# 핑거 서비스 사용 안 함
# "disable = no" 행을 "disable = yes"로 변경
sed -i 's/disable = no/disable = yes/g' /etc/xinetd.d/finger

# xinetd 서비스 다시 시작
systemctl restart xinetd


cat $result

echo ; echo
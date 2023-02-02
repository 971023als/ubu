#!/bin/bash

. function.sh

BAR

CODE [U-21] r 계열 서비스 비활성화		

cat << EOF >> $result

[양호]: 불필요한 r 계열 서비스가 비활성화 되어 있는 경우

[취약]: 불필요한 r 계열 서비스가 활성화 되어 있는 경우

EOF

BAR



# rlogin 파일 생성
echo "service rlogin
{
socket_type = stream
wait = no
user = nobody
log_on_success += USERID
log_on_failure += USERID
server = /usr/sdin/in.fingerd
disable = yes
}" > /etc/xinetd.d/rlogin

# rsh 파일 생성
echo "service rlogin
{
socket_type = stream
wait = no
user = nobody
log_on_success += USERID
log_on_failure += USERID
server = /usr/sdin/in.fingerd
disable = yes
}" > /etc/xinetd.d/rsh

# rexec 파일 생성
echo "service rlogin
{
socket_type = stream
wait = no
user = nobody
log_on_success += USERID
log_on_failure += USERID
server = /usr/sdin/in.fingerd
disable = yes
}" > /etc/xinetd.d/rexec


cat $result

echo ; echo

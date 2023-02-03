#!/bin/bash

. function.sh

BAR

CODE [U-21] r 계열 서비스 비활성화		

cat << EOF >> $result

[양호]: 불필요한 r 계열 서비스가 비활성화 되어 있는 경우

[취약]: 불필요한 r 계열 서비스가 활성화 되어 있는 경우

EOF

BAR

rlogin="/etc/xinetd.d/rlogin"

rsh="/etc/xinetd.d/rsh"

rexec="/etc/xinetd.d/rexec"

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
}" > $rlogin

# rsh 파일 생성
echo "service rsh
{
socket_type = stream
wait = no
user = nobody
log_on_success += USERID
log_on_failure += USERID
server = /usr/sdin/in.fingerd
disable = yes
}" > $rsh

# rexec 파일 생성
echo "service rexec
{
socket_type = stream
wait = no
user = nobody
log_on_success += USERID
log_on_failure += USERID
server = /usr/sdin/in.fingerd
disable = yes
}" > $rexec


cat $result

echo ; echo

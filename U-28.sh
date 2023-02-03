#!/bin/bash

. function.sh

BAR

CODE [U-28] NIS , NIS+ 점검		

cat << EOF >> $result

[양호]: NIS 서비스가 비활성화 되어 있거나, 필요 시 NIS+를 사용하는 경우

[취약]: NIS 서비스가 활성화 되어 있는 경우

EOF

BAR

# 대표적인 서비스만 조치

# ypserv 서비스 중지
sudo service ypserv stop

# 부팅 시 ypserv 서비스가 시작되지 않도록 설정
sudo update-rc.d ypserv disable

# ypbind 서비스 중지
sudo service ypbind stop

# 부팅 시 ypbind 서비스가 시작되지 않도록 설정
sudo update-rc.d ypbind disable

# ypxfrd 서비스 중지
sudo service ypxfrd stop

# 부팅 시 ypxfrd 서비스가 시작되지 않도록 설정
sudo update-rc.d ypxfrd disable

# rpc.yppasswdd 서비스를 중지합니다
sudo service rpc.yppasswdd stop

# 부팅 시 rpc.yppasswdd 서비스를 시작하지 않도록 설정합니다
sudo update-rc.d rpc.yppasswdd disable

# rpc.yupdated 서비스 중지
sudo service rpc.ypupdated stop

# 부팅 시 rpc.ypupdate 서비스를 시작하지 않도록 설정
sudo update-rc.d rpc.ypupdated disable

cat $result

echo ; echo

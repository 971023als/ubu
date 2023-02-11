#!/bin/bash

. function.sh

BAR

CODE [U-61] ftp 서비스 확인

cat << EOF >> $result

[양호]: FTP 서비스가 비활성화 되어 있는 경우

[취약]: FTP 서비스가 활성화 되어 있는 경우

EOF

BAR

# FTP 서비스 중지
sudo service ftp stop

# FTP 서비스 사용 안 함
sudo service ftp disable

# vsftpd 서비스를 중지합니다:
sudo service vsftpd stop

# vsftpd 서비스를 시작하지 않도록 설정합니다
sudo /etc/rc.d/init.d/vsftpd stop

# proftp 서비스를 중지합니다:
sudo service proftp stop

# proftp를 시작하지 않도록 설정합니다
sudo /etc/rc.d/init.d/proftp stop

cat $result

echo ; echo 

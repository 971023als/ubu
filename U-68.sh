#!/bin/bash

 

. function.sh
  

BAR

CODE [U-68] 로그온 시 경고 메시지 제공

cat << EOF >> $result

[양호]: 서버 및 Telnet 서비스에 로그온 메시지가 설정되어 있는 경우

[취약]: 서버 및 Telnet 서비스에 로그온 메시지가 설정되어 있지 않은 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1 


# Edit the /etc/motd file
echo "이 시스템에 오신 것을 환영합니다!" > /etc/motd
echo "다음 경고에 주의하십시오.: " >> /etc/motd

# Edit the /etc/issue file
echo "이 시스템에 오신 것을 환영합니다!" > /etc/issue
echo "다음 경고에 주의하십시오.: " >> /etc/issue

# Edit the /etc/vsftpd/vsftpd.conf file
sudo sed -i 's/#ftpd_banner=.*/ftpd_banner=이 시스템에 오신 것을 환영합니다!/' /etc/vsftpd/vsftpd.conf
sudo echo "ftpd_banner=다음 경고에 유의하십시오.: " >> /etc/vsftpd/vsftpd.conf

# Edit the /etc/mail/sendmail.cf file
sudo echo "GreetingMessage=이 시스템에 오신 것을 환영합니다!" >> /etc/mail/sendmail.cf 

# Edit the /etc/named.conf file
sudo sed -i 's/GreetingMessage.*/GreetingMessage=이 시스템에 오신 것을 환영합니다!/' /etc/named.conf
sudo echo "GreetingMessage=다음 경고에 유의하십시오.: " >> /etc/named.conf


cat $result

echo ; echo

 

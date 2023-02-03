#!/bin/bash

 

. function.sh

 

BAR

CODE [U-72] 정책에 따른 시스템 로깅 설정

cat << EOF >> $result

[양호]: 로그 기록 정책이 정책에 따라 설정되어 수립되어 있는 경우

[취약]: 로그 기록 정책이 정책에 따라 설정되어 수립되어 있지 않은 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1 



# Backup the original file
cp /etc/rsyslog.conf /etc/rsyslog.conf.bak

# Replace the original file with the new configuration
cat > /etc/rsyslog.conf << EOF
*.info;mail.none;authpriv.none;cron.none /var/log/info.log
authpriv.* /var/log/secure.log
mail.* /var/log/maillog
cron.* /var/log/cron
*.alert /dev/console
*.emerg *
EOF

# Restart the rsyslog service
systemctl restart rsyslog





cat $result

echo ; echo 

 

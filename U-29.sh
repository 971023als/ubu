#!/bin/bash

. function.sh

BAR

CODE [U-29] tftp, talk 서비스 비활성화

cat << EOF >> $result

[양호]: tftp, talk, ntalk 서비스가 비활성화 되어 있는 경우

[취약]: tftp, talk, ntalk 서비스가 활성화 되어 있는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

#@@@@@@@@@@@@@@@@@@@@@@@/etc/xinetd.conf@@@@@@@@@@@@@22


# 백업 원본 inetd.conf
cp /etc/inetd.conf /etc/inetd.conf.bak

# tftp, talk 및 ntalk 서비스에 대한 주석 추가
sed -i 's/^tftp.*/\# tftp service\ntftp/' /etc/inetd.conf
sed -i 's/^talk.*/\# talk service\ntalk dgram udp wait root /usr/sbin/tcpd in.talkd/' /etc/inetd.conf
sed -i 's/^ntalk.*/\# ntalk service\nntalk dgram udp wait root /usr/sbin/tcpd in.ntalkd/' /etc/inetd.conf

# inetd 데몬 재시작
/etc/init.d/inetd restart


cat $result

echo ; echo
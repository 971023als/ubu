#!/bin/bash

. function.sh

BAR

CODE [U-20] Anonymous FTP 비활성화

cat << EOF >> $result

[양호]: Anonymous FTP (익명 ftp) 접속을 차단한 경우

[취약]: Anonymous FTP (익명 ftp) 접속을 차단하지 않은 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# 기존 규칙
iptables -F

# 들어오는 익명 FTP 연결 차단
iptables -A INPUT -p tcp --dport 21 -m state --state NEW -j REJECT --reject-with tcp-reset

# 변경 내용 저장
iptables-save > /etc/iptables/rules.v4



cat $result

echo ; echo
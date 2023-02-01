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

# 익명 FTP 액세스가 차단되지 않았는지 확인
if grep -q "^#.*anonymous_enable=YES" /etc/vsftpd.conf; then
    # 익명 계정이 /etc/passwd 파일에 있는지 확인
    if grep -q "^ftp:" /etc/passwd; then
        # userdel 명령을 사용하여 계정 삭제
        userdel ftp
        echo "The anonymous FTP account has been deleted."
    else
        echo "The anonymous FTP account does not exist."
    fi
else
    echo "Anonymous FTP access is blocked, account can't be deleted."
fi


# Ubuntu 20의 proftpd.conf에서 익명 설정과 관련된 사용자 및 사용자 별칭 항목에 주석을 다는 스크립트

# proftpd가 설치되어 있는지 확인
if dpkg -s proftpd &> /dev/null; then
    # 원래 구성 파일 백업
    cp /etc/proftpd/proftpd.conf /etc/proftpd/proftpd.conf.bak

    # 사용자 및 사용자 별칭 항목 주석 달기
    sed -i '/^User.*anonymous/ s/^/#/' /etc/proftpd/proftpd.conf
    sed -i '/^Useralias.*anonymous/ s/^/#/' /etc/proftpd/proftpd.conf

    # proftpd 서비스 다시 시작
    service proftpd restart
    echo "User and Useralias entries related to anonymous settings have been annotated in proftpd.conf."
else
    echo "ProFTPD is not installed on this system."
fi


# vsftpd.conf 파일이 /etc/vsftpd/에 있는지 확인
if [ -f "/etc/vsftpd/vsftpd.conf" ]; then
    # anonymous_enable=YES를 anonymous_enable=NO로 바꾸기
    sed -i 's/anonymous_enable=YES/anonymous_enable=NO/g' /etc/vsftpd/vsftpd.conf
else
    # vsftpd.conf 파일이 /etc/에 있는지 확인
    if [ -f "/etc/vsftpd.conf" ]; then
        # anonymous_enable=YES를 anonymous_enable=NO로 바꾸기
        sed -i 's/anonymous_enable=YES/anonymous_enable=NO/g' /etc/vsftpd.conf
    else
        echo "vsftpd.conf file not found in /etc/vsftpd/ or /etc/"
    fi
fi



cat $result

echo ; echo
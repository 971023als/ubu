#!/bin/bash

. function.sh

BAR

CODE [U-43] 로그의 정기적 검토 및 보고

cat << EOF >> $result

[양호]: 접속기록 등의 보안 로그, 응용 프로그램 및 시스템 로그 기록에 대해 정기적으로 검토, 분석, 리포트 작성 및 보고 등의 조치가 이루어지는 경우

[취약]: 위 로그 기록에 대해 정기적으로 검토, 분석, 리포트 작성 및 보고 등의 조치가 이루어 지지 않는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# 마지막 로그인 시간 확인
lastlog -u $USER

# 연결 IP 확인
echo "Last IP address used:"
last -i | head -1

# 실패한 로그인 기록 확인y
echo "Failed login history:"
grep "Failed password" /var/log/auth.log | grep -v "gssapi"

# 인증되지 않은 SSH 로그인 시도 확인
echo "Unauthorized SSH login attempts:"
grep "sshd.*Failed" /var/log/auth.log

# 무단 사용 여부를 확인
echo "Unauthorized 'su' usage:"
grep "su.*FAILED" /var/log/auth.log

# 권한 없는 사용자의 프로세스 실행 확인
echo "Unauthorized process execution:"
grep "USER=.*comm=" /var/log/auth.log | grep -v "USER=root"





# sulog에서 권한 상승 시도 확인
echo "SU attempts:"
grep "su:" /var/log/sulog

# sulog에서 권한 상승 성공 여부 확인
echo "SU successes:"
grep "su:.*success" /var/log/sulog

# sulog에서 허용된 사용자의 권한 상승 시도 확인
echo "SU attempts by allowed users:"
grep "su:.*user=allowed_user" /var/log/sulog




# 인증되지 않은 FTP 로그인 시도 확인
echo "Unauthorized FTP login attempts:"
grep "FTP LOGIN FAIL" /var/log/xferlog

#  FTP 로그인 성공 여부 확인
echo "Successful FTP login attempts:"
grep "FTP LOGIN" /var/log/xferlog

# 무단 업로드 및 다운로드 확인
echo "Unauthorized uploads:"
grep "UPLOAD" /var/log/xferlog | grep "anonymous"
echo "Unauthorized downloads:"
grep "DOWNLOAD" /var/log/xferlog | grep "anonymous"

cat $result

echo ; echo
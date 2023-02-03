#!/bin/bash

 

. function.sh

 

BAR

CODE [U-70] expn, vrfy 명령어 제한

cat << EOF >> $result

[양호]: SMTP 서비스 미사용 또는, noexpn, novrfy 옵션이 설정되어 있는 경우

[취약]: SMTP 서비스 사용하고, noexpn, novrfy 옵션이 설정되어 있지 않는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1 


# SMTP 서비스 중지
sudo service sendmail stop

# 부팅 시 SMTP 서비스 시작을 비활성화합니다.
sudo chkconfig sendmail off


    

cat $result

echo ; echo 

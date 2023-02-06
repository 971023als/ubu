#!/bin/bash

. function.sh

BAR

CODE [U-21] r 계열 서비스 비활성화		

cat << EOF >> $result

[양호]: 불필요한 r 계열 서비스가 비활성화 되어 있는 경우

[취약]: 불필요한 r 계열 서비스가 활성화 되어 있는 경우

EOF

BAR


# rlogin 서비스 사용 안 함
service rlogin disable

# rsh 서비스 사용 안 함
service rsh disable

# exec 서비스 사용 안 함
service exec disable



cat $result

echo ; echo

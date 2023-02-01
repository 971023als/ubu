#!/bin/bash

. function.sh

BAR

CODE [U-21] r 계열 서비스 비활성화

cat << EOF >> $result

[양호]: 불필요한 r 계열 서비스가 비활성화 되어 있는 경우

[취약]: 불필요한 r 계열 서비스가 활성화 되어 있는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# 파일이 들어 있는 디렉터리 정의
dir="/etc/xinetd.d/"

# 편집할 파일 정의
files=("rlogin" "rsh" "rexec")

for file in "${files[@]}"
do
    # 정의된 디렉토리에 파일이 있는지 확인
    if [ -f "$dir$file" ]; then
        # vi 편집기에서 파일을 열고 "disable"을 검색 
        vi +/disable "$dir$file"
        # "disable = no"를 "disable = yes"로 변경
        :%s/disable = no/disable = yes/g
        # S파일 저장 후 종료
        :wq
    else
        echo "$file not found in $dir"
    fi
done
# xinetd 서비스 다시 시작
sudo service xinetd restart


cat $result

echo ; echo
#!/bin/bash

. function.sh

BAR

CODE [U-23] DoS 공격에 취약한 서비스 비활성화

cat << EOF >> $result

[양호]: 사용하지 않는 DoS 공격에 취약한 서비스가 비활성화 된 경우

[취약]: 사용하지 않는 DoS 공격에 취약한 서비스가 활성화 된 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  


# 파일이 들어 있는 디렉터리 정의
dir="/etc/xinetd.d/"

# 편집할 파일 정의
files=("echo" "discard" "daytime" "chargen")

for file in "${files[@]}"
do
    # 정의된 디렉토리에 파일이 있는지 확인
    if [ -f "$dir$file" ]; then
        # vi 편집기에서 파일을 열고 "사용 안 함"을 검색
        vi +/disable "$dir$file"
        # "disable = no" 를 "disable = yes"로 바꿈
        :%s/disable = no/disable = yes/g
        # 파일 저장 후 종료
        :wq
    else
        echo "$file not found in $dir"
    fi
done
# xinetd 서비스 다시 시작
sudo service xinetd restart


cat $result

echo ; echo
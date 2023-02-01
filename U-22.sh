#!/bin/bash

. function.sh

BAR

CODE [U-22] crond 파일 소유자 및 권한 설정

cat << EOF >> $result

[양호]: crontab 명령어 일반사용자 금지 및 cron 관련 파일 640 이하인 경우

[취약]: crontab 명령어 일반사용자 사용가능하거나, crond 관련 파일 640 이상인 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# crontab 명령의 사용 권한을 확인
ls -l /usr/bin/crontab

# crontab 명령에 대한 일반 사용자 권한 삭제
sudo chmod 750 /usr/bin/crontab


# cron 관련 파일이 들어 있는 디렉토리 정의
dir="/etc/cron.d/"

# cron 관련 파일 정의
files=("cron.daily" "cron.hourly" "cron.monthly" "cron.weekly")

for file in "${files[@]}"
do
    # 정의된 디렉토리에 파일이 있는지 확인
    if [ -f "$dir$file" ]; then
        # 파일의 소유자를 루트로 설정
        sudo chown root "$dir$file"
        # 파일의 사용 권한을 640으로 설정
        sudo chmod 640 "$dir$file"
    else
        echo "$file not found in $dir"
    fi
done

#@@@@이외의 관련 설정파일도 추가적으로 권한설정 할 수 있어야 함.@@@@@
#@@@@또 crontab명령어를 일반사용자에게 허용하는 경우도 추가@@@@

cat $result

echo ; echo
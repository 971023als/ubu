#!/bin/bash

. function.sh

BAR

CODE [U-34] DNS Zone Transfer 설정

cat << EOF >> $result

[양호]: DNS 서비스 미사용 또는, Zone Transfer를 허가된 사용자에게만 허용한 경우

[취약]: DNS 서비스를 사용하며 Zone Transfer를 모든 사용자에게 허용한 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  



# DNS 서비스가 실행 중인지 확인
if ps -ef | grep -q "named" | grep -v "grep"
then
    # 실행 중인 프로세스의 PID
    PID=$(ps -ef | grep "named" | grep -v "grep" | awk '{print $2}')
    echo "DNS service is running with PID $PID"

    # /etc/name.conf에서 allow-transfer 및 xfrnets 설정을 확인
    ALLOW_TRANSFER=$(grep -o "allow-transfer" /etc/named.conf)
    XFRNETS=$(grep -o "xfrnets" /etc/named.conf)
    if [ -n "$ALLOW_TRANSFER" ] && [ -n "$XFRNETS" ]
    then
        echo "allow-transfer and xfrnets are set in /etc/named.conf"

        # 필요에 따라 allow-transfer 및 xfrnets 설정 수정
        # ...
        # BIND 버전 확인
        bind_version=$(named -v | awk '{print $3}')

        # BIND 버전을 기준으로 설정 수정
        if [ "$bind_version" == "8" ]; then
        # /etc/name.conf의 옵션에서 allow-transfer 수정
        sed -i 's/^options {/options {\n\tallow-transfer IP_ADDRESS;/' /etc/named.conf
        elif [ "$bind_version" == "4.9" ]; then
        #  /etc/name.conf의 옵션에서 xfrnets 수정
        sed -i 's/^options {/options {\n\txfrnets IP_ADDRESS;/' /etc/named.conf
        else
        echo "Unsupported BIND version: $bind_version"
        exit 1
        fi

        # DNS 서비스를 다시 시작
        sudo systemctl restart named
    else
        echo "allow-transfer and xfrnets are not set in /etc/named.conf"
    fi
else
    OK "DNS service is not running"

    # kill -9를 사용하여 DNS 서비스 중지
    sudo kill -9 $PID
fi




cat $result

echo ; echo
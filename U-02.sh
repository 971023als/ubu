#!/bin/bash

. function.sh

BAR

CODE [U-02] 패스워드 복잡성 설정

cat << EOF >> $result

[양호]: 패스워드 최소길이 8자리 이상, 영문·숫자·특수문자 최소 입력 기능이 설정된 경우

[취약]: 패스워드 최소길이 8자리 이상, 영문·숫자·특수문자 최소 입력 기능이 설정된 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  


DEF_FILE="/etc/login.defs"
MIN_LEN=8

if [ ! -f "$DEF_FILE" ]; then
    INFO "$DEF_FILE 찾을 수 없습니다."
else
    CURR_LEN=$(grep "^PASS_MIN_LEN" "$DEF_FILE" | awk '{print $2}')

    if [ -z "$CURR_LEN" ]; then
        INFO "$DEF_FILE 에서 PASS_MIN_LEN을 찾을 수 없습니다. 지금 추가하는 중..."
        echo "PASS_MIN_LEN $MIN_LEN" >> "$DEF_FILE"
    elif [ "$CURR_LEN" -lt "$MIN_LEN" ]; then
        INFO "PASS_MIN_LEN 값이 $DEF_FILE의 $MIN_LEN보다 작습니다. 지금 업데이트하는 중..."
        # "#PASS"를 "PASS"로 바꿉니다
        sed -i 's/#PASS/PASS/g' "$file"
        sed -i "s/^PASS_MIN_LEN.*/PASS_MIN_LEN $MIN_LEN/" "$DEF_FILE"
    else
        OK "$DEF_FILE 에서 PASS_MIN_LEN 값이 이미 $MIN_LEN 이상으로 설정되어 있습니다."
    fi
fi

AUTH_FILE="/etc/pam.d/common-auth"
SETTING="password requisite /lib/security/$ISA/pam_cracklib.so retry=3 minlen=8 lcredit=-1 ucredit=-1 dcredit=-1 ocredit=-1"

if [ ! -f "$AUTH_FILE" ]; then
    INFO "$AUTH_FILE 을 찾을 수 없습니다."
else
    if grep -q "$SETTING" "$AUTH_FILE"; then
        OK "설정이 $AUTH_FILE 에 이미 있습니다."
    else
        INFO "$AUTH_FILE 에 설정 추가 중..."
        echo "$SETTING" >> "$AUTH_FILE"
    fi
fi



cat $result

echo ; echo
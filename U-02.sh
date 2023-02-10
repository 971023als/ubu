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
        INFO "PASS_MIN_LEN 값이 $DEF_FILE 의 $MIN_LEN 보다 작습니다. 지금 업데이트하는 중..."
        # "#PASS_MIN_LEN"를 "PASS_MIN_LEN"로 바꿉니다
        sed -i 's/#PASS_MIN_LEN/PASS_MIN_LEN/g' "$DEF_FILE"
        sed -i "s/^PASS_MIN_LEN.*/PASS_MIN_LEN $MIN_LEN/" "$DEF_FILE"
    else
        OK "$DEF_FILE 에서 PASS_MIN_LEN 값이 이미 $MIN_LEN 이상으로 설정되어 있습니다."
    fi
fi

PAM_FILE="/etc/pam.d/common-auth"
EXPECTED_OPTIONS="password    requisite    pam_cracklib.so try_first_pass restry=3 minlen=8 lcredit=-1 ucredit=-1 dcredit=-1 ocredit=-1"


if [ -f "$PAM_FILE" ]; then
    if grep -q "$EXPECTED_OPTIONS" "$PAM_FILE" ; then
        OK " "$PAM_FILE" 에 $EXPECTED_OPTIONS 없음  "
    else
        echo "password    requisite    pam_cracklib.so try_first_pass restry=3 minlen=8 lcredit=-1 ucredit=-1 dcredit=-1 ocredit=-1" >> /etc/pam.d/system-auth
        INFO " "$PAM_FILE" 에 설정되었습니다  "
    fi
else
    INFO " "$PAM_FILE" 못 찾음"
fi


cat $result

echo ; echo
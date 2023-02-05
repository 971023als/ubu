#!/bin/bash

 

. function.sh
 

BAR

CODE [U-62] ftp 계정 shell 제한

cat << EOF >> $result

[양호]: ftp 계정에 /bin/false 쉘이 부여되어 있는 경우

[취약]: ftp 계정에 /bin/false 쉘이 부여되지 않 경우

EOF

BAR


TMP1=`SCRIPTNAME`.log

> $TMP1 

# 계정 이름 정의
account_name="ftp"

# /etc/passwd 파일에서 계정에 해당하는 줄 찾기
line=$(grep "^$account_name:" /etc/passwd)

# 계정을 찾을 수 없으면 메시지를 표시하고 종료합니다
if [ -z "$line" ]; then
  INFO "/etc/passwd에 $account_name 계정이 없습니다."
fi

# 현재 로그인 셸 추출
current_shell=$(echo $line | cut -d: -f7)

#  현재 셸이 이미 /bin/false로 설정되어 있는지 확인하십시오
if [ "$current_shell" != "/bin/false" ]; then
  # 현재 셸을 /bin/false로 변경합니다
  new_line=$(echo "$line" | sed "s,$current_shell,/bin/false,")

  # /etc/passwd 파일 업데이트
  sudo sed -i "s#$line#$new_line#" /etc/passwd
fi


cat $result

echo ; echo 

 

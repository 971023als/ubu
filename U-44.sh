#!/bin/bash

. function.sh

BAR

CODE [U-44] root 이외의 UID가 ‘0’ 금지

cat << EOF >> $result

[양호]: root 계정과 동일한 UID를 갖는 계정이 존재하지 않는 경우

[취약]: root 계정과 동일한 UID를 갖는 계정이 존재하는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

#@@@@@@@@@100이상으로 하면 되는데, 어떤값으로 하면 좋은지 상의필요.@@@@@@@@@@

# 현재 UID가 0인지 확인
if [ $UID -eq 0 ]; then
  # UID를 100으로 변경 
  usermod -u 100 $USER
  # UID 변경이 성공했는지 확인
  if [ $? -eq 0 ]; then
    echo "UID successfully changed to 100"
  else
    echo "Error: UID change failed"
  fi
else
  echo "Error: Only root user can change UID"
fi

cat $result

echo ; echo
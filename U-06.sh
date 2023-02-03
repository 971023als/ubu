#!/bin/bash

. function.sh

BAR

CODE [U-06] 파일 및 디렉터리 소유자 설정 @@su 말고 sudo su 해야 함 @@

cat << EOF >> $result

[양호]: 소유자가 존재하지 않는 파일 및 디렉터리가 존재하지 않는 경우

[취약]: 소유자가 존재하지 않는 파일 및 디렉터리가 존재하는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# 소유자를 바꿀 사용자를 지정합니다
new_owner=user

# 존재하지 않는 소유자 및 그룹이 있는 파일 및 디렉터리 찾기
results=$(find / \( -nouser -o -nogroup \) -print 2>/dev/null)

# 결과의 각 항목을 반복해서 살펴보다
for item in $results; do
  # 소유자를 지정된 사용자로 변경
  chown $new_owner:$new_owner "$item"
done


cat $result

echo ; echo
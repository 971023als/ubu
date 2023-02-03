#!/bin/bash

. function.sh

BAR

CODE [U-06] 파일 및 디렉터리 소유자 설정

cat << EOF >> $result

[양호]: 소유자가 존재하지 않는 파일 및 디렉터리가 존재하지 않는 경우

[취약]: 소유자가 존재하지 않는 파일 및 디렉터리가 존재하는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# 존재하지 않는 소유자 및 그룹이 있는 파일 및 디렉터리 찾기
results=$(find / \( -nouser -o -nogroup \) -print 2>/dev/null)

# 결과의 각 항목을 반복해서 살펴보다
for item in $results; do
  # 주인을 뿌리째 바꾸다
  chown root:root "$item"
done

cat $result

echo ; echo
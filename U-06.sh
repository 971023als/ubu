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

# specify the user to replace the owner with
new_owner=user

# find files and directories with nonexistent owners and groups
results=$(find / \( -nouser -o -nogroup \) -print 2>/dev/null)

# loop through each item in the results
for item in $results; do
  # change the owner to the specified user
  chown $new_owner:$new_owner "$item"
done


cat $result

echo ; echo
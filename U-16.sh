#!/bin/bash

 

. function.sh

 

BAR

CODE [U-16] /dev에 존재하지 않는 device 파일 점검

cat << EOF >> $result  

[양호]: dev에 대한 파일 점검 후 존재하지 않은 device 파일을 제거한 경우

[취약]: dev에 대한 파일 미점검, 또는, 존재하지 않은 device 파일을 방치한 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# Find files in /dev directory without major or minor number
find /dev -type f -exec ls -l {} \; | awk '$5 == "0" && $6 == "0" {print $9}' |
while read file; do
    # Confirm before deleting
    read -p "Delete $file? [y/n] " confirm
    if [ "$confirm" == "y" ]; then
        rm -f "$file"
    fi
done
 

 
cat $result

echo ; echo


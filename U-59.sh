#!/bin/bash

 

. function.sh

 

 

BAR

CODE [U-59] 숨겨진 파일 및 디렉터리 검색 및 제거

cat << EOF >> $result

[양호]: 디렉터리 내 숨겨진 파일을 확인하여, 불필요한 파일 삭제를 완료한 경우

[취약]: 디렉터리 내 숨겨진 파일을 확인하지 않고, 불필요한 파일을 방치한 경우

EOF

BAR


TMP1=`SCRIPTNAME`.log

> $TMP1



# Define directory to be cleaned
dir="/home/user/"

# Change to directory
cd $dir

# Find all hidden files
hidden_files=`find . -name ".*"`

# Loop through hidden files and delete them
for file in $hidden_files; do
  if [ -f $file ]; then
    rm -f $file
  fi
done


# Define a time threshold for files to be considered old
THRESHOLD=60 # 60 days

# Find all hidden files older than the threshold
find / -type f -name ".*" -mtime +$THRESHOLD -exec rm -f {} \;



cat $result

echo ; echo 

 

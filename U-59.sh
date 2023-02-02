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



# Define hidden files and directories
hidden_files=$(find / -type f -name ".*")
hidden_dirs=$(find / -type d -name ".*")

# Check if any unwanted or suspicious files or directories exist
for file in $hidden_files; do
  if [[ $(basename $file) =~ "unwanted-file" ]]; then
    echo "Found unwanted file: $file"
    # Perform desired action, such as deleting the file or sending a notification
    rm $file
  fi
done

for dir in $hidden_dirs; do
  if [[ $(basename $dir) =~ "suspicious-dir" ]]; then
    echo "Found suspicious directory: $dir"
    # Perform desired action, such as deleting the directory or sending a notification
    rm -r $dir
  fi
done



cat $result

echo ; echo 

 

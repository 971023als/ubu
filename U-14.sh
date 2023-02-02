#!/bin/bash

. function.sh

BAR

CODE [U-14] 사용자, 시스템 시작파일 및 환경파일 소유자 및 권한 설정

cat << EOF >> $result

[양호]: 홈 디렉터리 환경변수 파일 소유자가 root 또는, 해당 계정으로 지정되어 있고, 홈 디렉터리 환경변수 파일에 root와 소유자만 쓰기 권한이 부여된 경우

[취약]: 홈 디렉터리 환경변수 파일 소유자가 root 또는, 해당 계정으로 지정되지 않고, 홈 디렉터리 환경변수 파일에 root와 소유자 외에 쓰기 권한이 부여된 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

#@@@@@@@@@@@@@@@@@@@@@@@조치해야하는 파일을 받아오는 방법 확인 필요@@@@@@@@@@@@@@@@

# 확인할 파일
file_name="/path/to/file"

# 홈 디렉토리 환경 변수 파일
home_dir_file="/etc/environment"

# 새 소유자
new_owner="username"

# 홈 디렉토리 파일이 루트에 의해 소유되는지 확인
if [ "$(stat -c %U $home_dir_file)" == "root" ]; then
  # 소유자가 아닌 사용자에게 쓰기 권한이 있는지 확인
  if [ -w $file_name ] && [ "$(stat -c %U $file_name)" != "root" ]; then
    # 파일 소유자 변경
    chown $new_owner $file_name
    echo "Owner of $file_name changed to $new_owner"
  else
    echo "A non-root user does not have write permission on $file_name"
  fi
else
  echo "The owner of the home directory environment variable file is not root"
fi


cat $result

echo ; echo
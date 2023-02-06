#!/bin/bash

. function.sh

BAR

CODE [U-05] root홈, 패스 디렉터리 권한 및 패스 설정

cat << EOF >> $result

[양호]: PATH 환경변수에 “.” 이 맨 앞이나 중간에 포함되지 않은 경우

[취약]: PATH 환경변수에 “.” 이 맨 앞이나 중간에 포함되어 있는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

root_profile="~/.profile"
etc_profile="/etc/profile"

for profile in "$root_profile" "$etc_profile"; do
  if [ ! -e "$profile" ]; then
    continue
  fi

  tmp_file=$(mktemp)
  cat "$profile" | sed 's/PATH=.:$PATH:$HOME\/bin/PATH=$PATH:$HOME\/bin:./g' > "$tmp_file"
  sudo mv "$tmp_file" "$profile"
  sudo chmod 644 "$profile"
done

cat $result

echo ; echo
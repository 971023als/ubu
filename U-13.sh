#!/bin/bash

. function.sh

BAR

CODE [U-13] SUID, SGID, Sticky bit 설정 및 권한 설정		

cat << EOF >> $result

[양호]: 주요 실행파일의 권한에 SUID와 SGID에 대한 설정이 부여되어 있지 않은 
경우

[취약]: 주요 실행파일의 권한에 SUID와 SGID에 대한 설정이 부여되어 있는 경우

EOF

BAR

# Remove write permissions for other users on the specified file
remove_write_permissions() {
  filename=$1
  chmod o-w "$filename"
  echo "Removed write permissions for other users on $filename"
}

# Remove write permissions for other users on all specified files
remove_write_permissions .profile
remove_write_permissions .kshrc
remove_write_permissions .cshrc
remove_write_permissions .bashrc
remove_write_permissions .bash_profile
remove_write_permissions .login
remove_write_permissions .exrc
remove_write_permissions .netrc

cat $result

echo ; echo

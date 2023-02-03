#!/bin/bash

. function.sh

BAR

CODE [U-17] $HOME/.rhosts, hosts.equiv 사용 금지

cat << EOF >> $result

[양호]: login, shell, exec 서비스를 사용하지 않거나, 사용 시 아래와 같은 설정이 적용된 경우
       1. /etc/hosts.equiv 및 $HOME/.rhosts 파일 소유자가 root 또는, 해당 계정인 경우
       2. /etc/hosts.equiv 및 $HOME/.rhosts 파일 권한이 600 이하인 경우
       3. /etc/hosts.equiv 및 $HOME/.rhosts 파일 설정에 ‘+’ 설정이 없는 경우

[취약]: login, shell, exec 서비스를 사용하고, 위와 같은 설정이 적용되지 않은 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  


# /etc/hosts.equiv 파일 소유자가 루트인지 확인합니다
if [ $(stat -c %u /etc/hosts.equiv) -eq 0 ]; then
  INFO "/etc/hosts.equiv에 대한 제한적 사용 권한 설정"
  sudo chmod 600 /etc/hosts.equiv
fi

# $HOME/.rhosts 파일 소유자가 루트인지 확인하십시오
if [ $(stat -c %u $HOME/.rhosts) -eq 0 ]; then
  INFO "$HOME/.rhosts에 대한 제한적 사용 권한 설정"
  chmod 600 $HOME/.rhosts
fi

# /etc/hosts.equiv 파일 사용 권한이 600 이하인지 확인합니다
if [ $(stat -c %a /etc/hosts.equiv) -le 600 ]; then
  INFO "/etc/hosts.equiv에 대한 제한적 사용 권한 설정"
  sudo chmod 600 /etc/hosts.equiv
fi

# $HOME/.rhosts 파일 사용 권한이 600 이하인지 확인하십시오
if [ $(stat -c %a $HOME/.rhosts) -le 600 ]; then
  INFO "$HOME/.rhosts에 대한 제한적 사용 권한 설정"
  chmod 600 $HOME/.rhosts
fi

# /etc/hosts.equiv 파일에 '+' 설정이 있는지 확인하십시오
if grep -q '\+' /etc/hosts.equiv; then
  INFO "/etc/hosts.equiv에서 '+' 설정 제거 중"
  sudo sed -i '/\+/d' /etc/hosts.equiv
fi

# $HOME/.rhosts 파일에 '+' 설정이 있는지 확인하십시오
if grep -q '\+' $HOME/.rhosts; then
  INFO "$HOME/.rhosts에서 '+' 설정 제거 중"
  sed -i '/\+/d' $HOME/.rhosts
fi



cat $result

echo ; echo
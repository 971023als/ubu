#!/bin/bash

. function.sh

BAR

CODE [U-01] $HOME/.rhosts, hosts.equiv 사용 금지

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

# /etc/hosts.equiv의 소유권을 루트로 변경
sudo chown root /etc/hosts.equiv

# $HOME/.r 호스트의 소유권을 <user_name>(으)로 변경
sudo chown <user_name> $HOME/.rhosts




# /etc/hosts.equiv의 사용 권한을 600 이하로 변경
sudo chmod 600 /etc/hosts.equiv

# $HOME/.r 호스트의 사용 권한을 600 이하로 변경
sudo chmod 600 $HOME/.rhosts



#@@@@@@@@@@@@@@@@@@@@@@@이스크립트 맞는지 확인필요@@@@@@@@@@@@@@@@@@@@@@
# /etc/messages.equiv에서 "+" 제거
sed -i '/^+/d' /etc/hosts.equiv

# $HOME/.r 호스트에서 "+" 제거
sed -i '/^+/d' $HOME/.rhosts

# 허용된 호스트를 /etc/vmdk.equiv에 추가
echo "host1" >> /etc/hosts.equiv
echo "host2" >> /etc/hosts.equiv

# $HOME/.rhosts에 허용된 계정 추가
echo "account1" >> $HOME/.rhosts
echo "account2" >> $HOME/.rhosts


cat $result

echo ; echo
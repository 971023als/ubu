#!/bin/bash

 

. function.sh


TMP1=`SCRIPTNAME`.log

> $TMP1 

 

BAR

CODE [U-56] UMASK 설정 관리 

cat << EOF >> $result

[양호]: UMASK 값이 022 이하로 설정된 경우

[취약]: UMASK 값이 022 이하로 설정되지 않은 경우 

EOF

BAR


# Open the /etc/profile file
sudo nano /etc/profile

# Add the following line to the file
echo "umask 022" | sudo tee -a /etc/profile
echo "export umask" | sudo tee -a /etc/profile

# Reload the profile file
source /etc/profile



cat $result

echo ; echo 

 

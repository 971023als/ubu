#!/bin/bash

 

. function.sh

 

TMP1=`SCRIPTNAME`.log

> $TMP1

 

BAR

CODE [U-54] Session Timeout 설정

cat << EOF >> $result

[양호]: Session Timeout이 600초(10분) 이하로 설정되어 있는 경우

[취약]: Session Timeout이 600초(10분) 이하로 설정되지 않은 경우

EOF

BAR


# Open the /etc/profile file
sudo nano /etc/profile

# Add the following line to the file
echo "TMOUT=600" | sudo tee -a /etc/profile
echo "export TMOUT" | sudo tee -a /etc/profile

# Reload the profile file
source /etc/profile





cat $result

echo ; echo

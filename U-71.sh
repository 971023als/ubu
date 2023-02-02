#!/bin/bash

 

. function.sh
 

BAR

CODE [U-71] Apache 웹서비스 정보 숨김

cat << EOF >> $result

[양호]: ServerTokens Prod, ServerSignature Off로 설정되어있는 경우

[취약]: ServerTokens Prod, ServerSignature Off로 설정되어있지 않은 경우

EOF

BAR


TMP1=`SCRIPTNAME`.log

> $TMP1 


# Find and edit the ServerTokens setting
sudo sed -i 's/ServerTokens.*/ServerTokens Prod/' /etc/apache2/conf-available/security.conf

# Find and edit the ServerSignature setting
sudo sed -i 's/ServerSignature On/ServerSignature Off/' /etc/apache2/conf-available/security.conf

# Enable the security configuration
sudo a2enconf security

# Restart Apache to apply the changes
sudo service apache2 restart


cat $result

echo ; echo 
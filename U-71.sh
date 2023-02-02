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

#!/bin/bash

# Check if the ServerTokens directive is already set
grep -q "^ServerTokens" /etc/apache2/conf-available/security.conf
if [ $? -eq 0 ]; then
  # Replace the existing ServerTokens directive
  sed -i 's/^ServerTokens.*/ServerTokens Prod/' /etc/apache2/conf-available/security.conf
else
  # Add the ServerTokens directive
  echo "ServerTokens Prod" >> /etc/apache2/conf-available/security.conf
fi

# Check if the ServerSignature directive is already set
grep -q "^ServerSignature" /etc/apache2/conf-available/security.conf
if [ $? -eq 0 ]; then
  # Replace the existing ServerSignature directive
  sed -i 's/^ServerSignature.*/ServerSignature Off/' /etc/apache2/conf-available/security.conf
else
  # Add the ServerSignature directive
  echo "ServerSignature Off" >> /etc/apache2/conf-available/security.conf
fi

# Restart Apache to apply the changes
sudo service apache2 restart


cat $result

echo ; echo 
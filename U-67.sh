#!/bin/bash

 

. function.sh


TMP1=`SCRIPTNAME`.log

> $TMP1  

BAR

CODE [U-67] SNMP 서비스 Community String의 복잡성 설정

cat << EOF >> $result

[양호]: SNMP Community 이름이 public, private 이 아닌 경우

[취약]: SNMP Community 이름이 public, private 인 경우

EOF

BAR

# Open the snmpd.conf file in a text editor
nano /etc/snmp/snmpd.conf

# Add the com2sec notConfigUser default ogani line to the file
echo "com2sec notConfigUser default ogani" >> /etc/snmp/snmpd.conf

# Save and close the file
ctrl+x, y, enter

# Start the snmpd service
systemctl start snmpd



cat $result

echo ; echo 
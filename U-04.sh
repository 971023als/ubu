#!/bin/bash

 

 

. function.sh

 
 TMP1=`SCRIPTNAME`.log

> $TMP1

BAR

CODE [U-04] 패스워드 파일 보호

cat << EOF >> $result

[양호]: 쉐도우 패스워드를 사용하거나, 패스워드를 암호화하여 저장하는 경우

[취약]: 쉐도우 패스워드를 사용하지 않고, 패스워드를 암호화하여 저장하지 않는 경우

EOF

BAR


# 비밀번호 입력을 요구하다
read -p "Enter password: " password

# encrypt the password using the "openssl" tool
encrypted_password=$(echo -n $password | openssl passwd -1 -stdin)

# store the encrypted password in a file
echo "encrypted_password: $encrypted_password" >> passwords.txt

# show a message confirming that the password was stored
echo "Password stored successfully!"



 

 

cat $result

echo ; echo

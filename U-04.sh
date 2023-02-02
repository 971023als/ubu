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


Encrypts and saves password to the shadow file
encrypt_and_save_password() {

Encrypt password using the SHA-512 encryption method
encrypted_password=$(openssl passwd -6 -salt $(openssl rand -hex 8) $1)

Save the encrypted password to the shadow file
echo "${username}:${encrypted_password}" >> /etc/shadow
}

Check if shadow file exists
if [ -f /etc/shadow ]; then
OK "섀도우 암호 파일 사용: /etc/shadow"

Read the username and password
read -p "Enter username: " username
read -sp "Enter password: " password
echo

Encrypt and save password to the shadow file
encrypt_and_save_password $password
else
WARN "섀도 암호 파일을 찾을 수 없습니다. 파일 생성: /etc/shadow"
touch /etc/shadow

Read the username and password
read -p "Enter username: " username
read -sp "Enter password: " password
echo

Encrypt and save password to the shadow file
encrypt_and_save_password $password
fi

OK "비밀번호가 성공적으로 암호화되어 섀도 파일에 저장되었습니다."


 

 

cat $result

echo ; echo

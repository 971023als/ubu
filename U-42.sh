#!/bin/bash

 

. function.sh 
 

TMP1=`SCRIPTNAME`.log

>$TMP1 

BAR

CODE [U-42] 최신 보안패치 및 벤더 권고사항 적용

cat << EOF >> $result

[양호]: 패치 적용 정책을 수립하여 주기적으로 패치를 관리하고 있는 경우

[취약]: 패치 적용 정책을 수립하지 않고 주기적으로 패치관리를 하지 않는 경우

EOF

BAR


# Update package list
apt update -y

# Upgrade all installed packages
apt upgrade -y

# Install unattended-upgrades package
apt install -y unattended-upgrades

# Configure unattended-upgrades to automatically install security updates
echo "Unattended-Upgrade::AutoFixInterruptedDpkg \"true\";
Unattended-Upgrade::MinimalSteps \"true\";
Unattended-Upgrade::Remove-Unused-Dependencies \"true\";
Unattended-Upgrade::Automatic-Reboot \"true\";
Unattended-Upgrade::Automatic-Reboot-Time \"04:00\";
Unattended-Upgrade::Mail \"root\";
Unattended-Upgrade::MailOnlyOnError \"true\";
APT::Periodic::Update-Package-Lists \"1\";
APT::Periodic::Download-Upgradeable-Packages \"1\";
APT::Periodic::AutocleanInterval \"7\";
APT::Periodic::Unattended-Upgrade \"1\";" > /etc/apt/apt.conf.d/50unattended-upgrades


# Define schedule for patch management
SCHEDULE="0 0 * * 1" # Runs every Monday at midnight

# Create log file
touch /var/log/patch_management.log

# Add cron job for patch management
echo "${SCHEDULE} root /usr/bin/apt update -y >> /var/log/patch_management.log 2>&1
${SCHEDULE} root /usr/bin/apt upgrade -y >> /var/log/patch_management.log 2>&1" | crontab -





# Define schedule for patch management
SCHEDULE="0 0 * * 1" # Runs every Monday at midnight

# Create log file
touch /var/log/apache_patch_management.log

# Add cron job for Apache patch management
echo "${SCHEDULE} root /usr/bin/apt update -y >> /var/log/apache_patch_management.log 2>&1
${SCHEDULE} root /usr/bin/apt install --only-upgrade apache2 -y >> /var/log/apache_patch_management.log 2>&1
${SCHEDULE} root /etc/init.d/apache2 restart >> /var/log/apache_patch_management.log 2>&1" | crontab -




# Define schedule for patch management
SCHEDULE="0 0 * * 1" # Runs every Monday at midnight

# Create log file
touch /var/log/mysql_patch_management.log

# Add cron job for MySQL patch management
echo "${SCHEDULE} root /usr/bin/apt update -y >> /var/log/mysql_patch_management.log 2>&1
${SCHEDULE} root /usr/bin/apt install --only-upgrade mysql-server -y >> /var/log/mysql_patch_management.log 2>&1
${SCHEDULE} root /etc/init.d/mysql restart >> /var/log/mysql_patch_management.log 2>&1" | crontab -




# Define schedule for patch management
SCHEDULE="0 0 * * 1" # Runs every Monday at midnight

# Create log file
touch /var/log/php_patch_management.log

# Add cron job for PHP patch management
echo "${SCHEDULE} root /usr/bin/apt update -y >> /var/log/php_patch_management.log 2>&1
${SCHEDULE} root /usr/bin/apt install --only-upgrade php -y >> /var/log/php_patch_management.log 2>&1
${SCHEDULE} root /etc/init.d/php7.4-fpm restart >> /var/log/php_patch_management.log 2>&1" | crontab -





cat $result

echo ; echo 

 

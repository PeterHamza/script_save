#! /bin/bash

#Se connecter en user

nextcloud_host="192.168.33.200"

user="user"
db_name=nextcloud
dn_user=oc_admin
db_password=k6wvf+vqhqlwT9zXS9oLXA0X+l9Imm
database_backup=nextcloud.sql

yes y | ssh-keygen -f ~/.ssh/id_rsa -N "" > /dev/null
ssh-copy-id $user@$nextcloud_host

echo "Maintenance mode on"
ssh $user@$nextcloud_host 'sudo -u www-data /usr/bin/php /var/www/html/nextcloud/occ maintenance:mode --on'

echo "Save database"
ssh $user@$nextcloud_host 'mysqldump --single-transaction -u $db_user -p$db_password $db_name > ~/$database_backup'
sudo /usr/bin/rsync --rsync-path="sudo /usr/bin/rsync" -av $user@$nextcloud_hosthome/~/database/$database_backup /data/backup/$database_backup

echo "Save nextcloud"
sudo /usr/bin/rsync --rsync-path="sudo /usr/bin/rsync" -av $user@$nextcloud_host:/var/www/html/nextcloud/ /data/backup/nextcloud

echo "Maintenance mode off"
ssh $user@$nextcloud_host 'sudo -u www-data /usr/bin/php /var/www/html/nextcloud/occ maintenance:mode --off'


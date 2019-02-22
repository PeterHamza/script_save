#! /bin/bash

#Se connecter en user

nextcloud_host="192.168.33.200"
password_root="root"
user="user"
db_name=nextcloud
dn_user=oc_admin
db_password=k6wvf+vqhqlwT9zXS9oLXA0X+l9Imm
database_backup=nextcloud.sql

echo 'user ALL=(ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo

yes y | ssh-keygen -f ~/.ssh/id_rsa -N "" > /dev/null
ssh-copy-id $user@$nextcloud_host

ssh -t $user@$nextcloud_host 'sudo -u www-data /usr/bin/php /var/www/html/nextcloud/occ maintenance:mode --on'
ssh $user@$nextcloud_host 'mysqldump --single-transaction -u $dbuser -p$dbpassword $dbname > ~/$databasebackup'

sudo /usr/bin/rsync --rsync-path="sudo /usr/bin/rsync" -av $user@$nextcloud_host:/var/www/html/nextcloud/ /data/backup/nextcloud
sudo /usr/bin/rsync --rsync-path="sudo /usr/bin/rsync" -av $user@$nextcloud_hosthome/~/database/$database_backup /data/backup/$database_backup


ssh -t $user@$nextcloud_host 'sudo -u www-data /usr/bin/php /var/www/html/nextcloud/occ maintenance:mode --off'


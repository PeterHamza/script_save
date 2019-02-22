#! /bin/bash

nextcloud_host="192.168.33.200"
password_root="root"
user="user"
db_name=nextcloud
dn_user=oc_admin
db_password=k6wvf+vqhqlwT9zXS9oLXA0X+l9Imm
database_backup=nextcloud.sql

echo "Maintenance mode on"
ssh $user@$nextcloud_host 'sudo -u www-data /usr/bin/php /var/www/html/nextcloud/occ maintenance:mode --on'

echo "Restore database backup"
rsync -a /data/backup/$database_backup $user@$nextcloud_host:/home/user/$database_backup
ssh {{backup_user}}@{{nextcloud_host}} "mysql -u $db_user -p$db_password $db_name < /home/user/$database_backup"

echo "Restore nextcloud"
sudo /usr/bin/rsync -e "ssh -i ~/.ssh/id_rsa" --rsync-path="sudo /usr/bin/rsync" -a /data/backup/nextcloud/ $user@$nextcloud_host:/var/www/html/nextcloud/

echo "Maintenance mode off"
ssh $user@$nextcloud_host 'sudo -u www-data /usr/bin/php /var/www/html/nextcloud/occ maintenance:mode --off'
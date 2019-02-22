#! /bin/bash

#Se connecter en user

nextcloud_host="192.168.33.200"
password_root="root"
user="user"
db_name=nextcloud
dn_user=oc_admin
db_password=k6wvf+vqhqlwT9zXS9oLXA0X+l9Imm

echo 'user ALL=(ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo

yes y | ssh-keygen -f ~/.ssh/id_rsa -N "" > /dev/null
ssh-copy-id $user@$nextcloud_host

ssh -t $user@$nextcloud_host "sudo -u www-data /usr/bin/php /var/www/html/nextcloud/occ maintenance:mode --on"

sudo /usr/bin/rsync -e "ssh -i ~/.ssh/id_rsa" --rsync-path="sudo /usr/bin/rsync" -av $user@$nextcloud_host:/var/www/html/nextcloud/ /data/backup/nextcloud gg
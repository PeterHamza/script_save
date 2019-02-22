#! /bin/bash

#Se connecter en user

nextcloud_host="192.168.33.200"
password_root="root"
user="user"
db_name=nextcloud
dn_user=oc_admin
db_password=k6wvf+vqhqlwT9zXS9oLXA0X+l9Imm

yes y | ssh-keygen -f ~/.ssh/id_rsa -N "" > /dev/null
ssh-copy-id $user@$nextcloud_host

ssh -t $user@$nextcloud_host "sudo -u www-data /usr/bin/php /var/www/html/nextcloud/occ maintenance:mode --on"

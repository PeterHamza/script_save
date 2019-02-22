#! /bin/bash

backup_host="192.168.33.201"
password_root="root"
user="user"
db_name=nextcloud
dn_user=oc_admin
db_password=k6wvf+vqhqlwT9zXS9oLXA0X+l9Imm

#Se connecter en user
su user >> /dev/null
cd  ~

yes y | ssh-keygen -f ~/.ssh/id_rsa -N "" > /dev/null
ssh-copy-id $user@$backup_host


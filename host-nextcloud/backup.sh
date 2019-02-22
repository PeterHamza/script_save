#! /bin/bash

backup_host="192.168.33.201"
password_root="root"
user="user"
db_name=nextcloud
dn_user=oc_admin
db_password=k6wvf+vqhqlwT9zXS9oLXA0X+l9Imm

echo 'user ALL=(ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo

yes y | ssh-keygen -f ~/.ssh/id_rsa -N "" > /dev/null
ssh-copy-id $user@$backup_host


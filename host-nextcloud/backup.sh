#! /bin/bash

backup_host="192.168.33.201"
password_root="root"
user="user"

#Se connecter en user
su user >> /dev/null
cd  ~

yes y | ssh-keygen -f ~/.ssh/id_rsa -N "" > /dev/null
ssh-copy-id $user@$backup_host


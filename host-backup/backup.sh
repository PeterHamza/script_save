#! /bin/bash

#Se connecter en user

nextcloud_host="192.168.33.200"
password_root="root"
user="user"

yes y | ssh-keygen -f ~/.ssh/id_rsa -N "" > /dev/null
ssh-copy-id $user@$nex

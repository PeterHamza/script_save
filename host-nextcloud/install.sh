#! /bin/bash

backup_host="192.168.33.201"
user="user"

#Install public key 
yes y | ssh-keygen -f ~/.ssh/id_rsa -N "" > /dev/null
ssh-copy-id $user@$backup_host
#! /bin/bash

nextcloud_host="192.168.33.200"
user="user"

#Create user 
echo '$user ALL=(ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo

#Install public key 
yes y | ssh-keygen -f ~/.ssh/id_rsa -N "" > /dev/null
ssh-copy-id $user@$nextcloud_host
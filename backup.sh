#! /bin/bash

db_name=nextcloud
dn_user=oc_admin
db_password=k6wvf+vqhqlwT9zXS9oLXA0X+l9Imm

date_now=$(date +%Y%m%d--%H%M%S)
db_backup=nextcloud-$date_now
system_backup=nextcloud-$date_now

#PC BACKUP
yes "y" | ssh-keygen -f /root/.ssh/id_rsa -N "" > /dev/null

#PC NEXTCLOD
ssh-copy-id root@192.168.33.201
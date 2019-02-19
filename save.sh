#! /bin/bash

echo "On définit les variables système"

saveVolumeName="monbackup"
snapName="monsnapshot"

dateNow=$(date +%Y-%m-%d--%H-%M-%S)
path="/var/www/html/nextcloud"
pathsave="$path/sauvegarde"
pathsnap="$path/mon_snapshot"
pathrap="$path/data"

grpVolume=`vgs | sed '2!d' | awk '{print $1}'`
sizeVolume=`df -h $pathrap | sed '2!d' | awk '{print $3}'`

echo "Création du volume de sauvegarde $saveVolumeName"
lvcreate -n $saveVolumeName -L $sizeVolume $grpVolume

mkfs.ext4 /dev/$grpVolume/$saveVolumeName

echo "coucou $pathsave"

if [ ! -d $pathsave ]; then
	echo "Création du dossier de sauvegarde"
	mkdir $pathsave
else
	echo "Le dossier de sauvegarde est existant"
fi

echo "montage de /dev/$grpVolume/$saveVolumeName à $pathsave"

mount /dev/$grpVolume/$saveVolumeName $pathsave

echo "Synchronisation et snapshot du volume logique dans $grpVolume/$saveVolumeName"

sync && lvcreate -s -n $snapName -L $sizeVolume $grpVolume

if [ ! -d $pathsnap ]; then
	echo "Création du dossier de snapshot"
	mkdir $pathsnap
else
	echo "Le dossier snapshot est existant"
fi

echo "Montage de /dev/$grpVolume/$snapName à $pathsnap"

mount /dev/$grpVolume/$snapName $pathsnap

echo "Copie des données du dossier de snapshot au dossier de sauvegarde"

cp -ax $pathsnap/* $pathsave

echo "Démontage du dossier $pathsnap"

umount $pathsnap

echo "Suppression du volume logique $grpVolume/$snapName"
lvremove -f $grpVolume/$snapName


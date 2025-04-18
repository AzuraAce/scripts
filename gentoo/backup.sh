#!/usr/bin/env bash
echo "Inform the source directory to backup"
read LOCATION
echo "Inform the destiny of backupfile"
read DESTINATION 
tar -cvpzf "$DESTINATION"/backup.tar.gz  --exclude=proc  --exclude=tmp  --exclude=mnt  --exclude=dev  --exclude=sys  --exclude=run  --exclude=media  --exclude=var/log  --exclude=home/oliver/.cache  --exclude=home/oliver/.local/share/nvim "$LOCATION"/*

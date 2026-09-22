#!/bin/sh


while true;
do
	time=$(date '+%Y-%m-%d %H:%M:%S')
	
	backup_folder="backup_${time}"
	mkdir "/backup/$backup_folder"
	
	cp -Rf /db-data/* /backup/"${backup_folder}"
	
	sleep 15m
done

exit 0
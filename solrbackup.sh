#!/bin/bash

#Backup Folders
pwd="/Users/vvelagala"
backupDir="/usr/local/Cellar/solr/6.4.1/server/solr/venkat"
echo "***BackupDir***" backupDir

# Conf files
files=$backupDir/core.properties,$backupDir/conf/schema.xml,$backupDir/conf/solrconfig.xml
echo "FILES", $files

for file in ${files[@]}
do
	cp  $file $pwd/
	echo $?
done

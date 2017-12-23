#!/bin/bash
# Script to backup hive metadata database
MYSQLHIVEDB_BACKUP="/backup/hadoop/DD/`date +%Y-%m-%d`/hive"
MYSQLHIVEDB_BACKEDFILE="/backup/hadoop/DD/`date +%Y-%m-%d`/hive/`hostname -f`_hive_metadata_mysql_backup_`date +%Y%m%d`.sql"
MYSQL_USER="root"
DELETEFILES="/backup/hadoop/DD/"
mailto=xxxxxx
# Create the backup directory
mkdir -p $MYSQLHIVEDB_BACKUP

# MySQL Backup command
if  mountpoint -q /backup/hadoop/;
then
 /usr/bin/mysqldump --single-transaction --skip-opt --skip-extended-insert --add-drop-table --routines --triggers --events --log-error=$MYSQLHIVEDB_BACKUP/`hostname`_hive_mysqldb_backup_`date +%Y-%m-%d`.log --databases hive > $MYSQLHIVEDB_BACKEDFILE;
else
echo -e "############ You can't write to root. Check if DD mount is missing on `hostname -f` #############\n\n\n`df -h`" | mailx  -s "DD mount:/backup/hadoop is missing on `hostname -f`" -r "DoNotReply" $mailto
exit 1
fi

# Checking if the backup is genuine or not
if [  "$(grep -i 'Dump completed' $MYSQLHIVEDB_BACKEDFILE)" ] && mountpoint -q /backup/hadoop;
then
echo "Success"
else
echo "########## FAILURE backup failed on `hostname -f`. One of the reason could be that Dump completed might not be there in $MYSQLHIVEDB_BACKEDFILE or DD mount might be missing ##########"  | mailx  -s "FAILURE:MySQL Hive DB Failed on `hostname -f`" -r "DoNotReply" $mailto
fi

# Remove backups older than 14 days
find $DELETEFILES -maxdepth 1 -type d -mtime +14 -exec rm -rf {} \;

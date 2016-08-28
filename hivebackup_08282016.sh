#!/bin/bash
# Script to backup hive metadata database
MYSQLHIVEDB_BACKUP="/opt/dataops/scripts/dbbackup1/mysql/hive/rctq_hive_mysqldb_backup_`date +%Y-%m-%d`"
echo $MYSQLHIVEDB_BACKUP
MYSQLHIVEDB_BACKEDFILE=mysql_hive_backup_`date +%Y-%m-%d`.sql
echo $MYSQLHIVEDB_BACKEDFILE
MYSQL_USER="root"
mailto=venkat.velagala@infor.com
echo $mailto

# Create the backup directory
mkdir -p $MYSQLHIVEDB_BACKUP


# MySQL Backup command
/usr/bin/mysqldump --single-transaction --skip-opt --skip-extended-insert --add-drop-table --routines --triggers --events --log-error=/opt/dataops/scripts/rctq_hive_mysqldb_backup.log --databases hive > $MYSQLHIVEDB_BACKEDFILE;

# This is not working - Existing
#find /dbbackup/mysql/hive -name *.gz -mtime +14 -exec rm {} \;

# Modified - Remove backups older than 1 day - Testing
find /opt/dataops/scripts/dbbackup1/mysql/hive -maxdepth 1 -type d -mtime +1 -exec rm -rf {} \;



# Checking if the backup is genuine or not


if [  "$(grep -i 'Dump completed' /opt/dataops/scripts/$MYSQLHIVEDB_BACKEDFILE)" ];
then
mailx -s "SUCCESS backup completed"  $mailto
else
 echo "Dataops Team please taken an action: Ambari Postgres backup failed due to the reason that the string PostgreSQL database completed was not found on `hostname` at `date` in $POSTGRES_BACKEDFILE"|  mailx -s "FAILURE: Ambari Postgres Backup failed on `hostname` " $mailto
fi




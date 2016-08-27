#!/bin/bash

#This is the script to backup postgres database

POSGRESDB_BACKUP="/var/lib/pgsql/postgres_backup/`date +%Y-%m-%d`"
POSTGRES_BACKEDFILE=postgres_ambari_backup_`/bin/date +\%Y\%m\%d`.sql
POSTGRES_USER="postgres"
HOSTNAME=`hostname | awk -F. '{print $1}'`
mailto=mailtovvrs@gmail.com

# Create the backup directory
mkdir -p $POSGRESDB_BACKUP

# Backup command
pg_dump ambari > /var/lib/pgsql/postgres_backup/$POSTGRES_BACKEDFILE
gzip > /var/lib/pgsql/postgres_backup/$POSTGRES_BACKEDFILE.gz

# Remove backups older than 1 days 
find /var/lib/pgsql/postgres_backup -maxdepth 1 -type d -mtime +10 -exec rm -rf {} \;

if  [  "$(grep -i 'iPostgreSQL database dump complete' /var/lib/pgsql/postgres_backup/$POSTGRES_BACKEDFILE)" ];
then
#mailx -s "SUCCESS: Ambari Daily backup Success string PostgreSQL database dump complete in the backup file $POSTGRES_BACKEDFILE" $mailto

echo

echo "Success string 'PostgreSQL database completed' found in the backup file $POSTGRES_BACKEDFILE"
echo
echo
else
mailx -s "FAILURE: Ambari Daily backup FAILED string PostgreSQL database dump complete not found in the backup file $POSTGRES_BACKEDFILE" $mailto

fi


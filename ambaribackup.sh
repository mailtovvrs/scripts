#!/bin/bash

#This is the script to backup ambari postgres database
POSTGRESDB_BACKUP="/opt/dataops/backups/`date +%Y-%m-%d`/ambari"
POSTGRES_BACKEDFILE="/opt/dataops/backups/`date +%Y-%m-%d`/ambari/`hostname -f`_ambari_metadata_postgres_backup_`/bin/date +\%Y\%m\%d`.sql"
POSTGRES_USER="postgres"
mailto=mailtovvrs@gmail.com

# Create the backup directory
mkdir -p $POSTGRESDB_BACKUP

# This is Very Very important to include if you are running as non-postgres user as the PATH envionment variable value needs to be appended with script location


# Backup command
runuser -l $POSTGRES_USER -c 'pg_dump ambari' > $POSTGRES_BACKEDFILE;

if  [  "$(grep -i 'PostgreSQL database dump complete' $POSTGRES_BACKEDFILE)" ];
then
#mailx -s "SUCCESS: Ambari Daily backup Success string PostgreSQL database dump complete in the backup file $POSTGRES_BACKEDFILE" -r "DoNotReply" $mailto

echo

echo
echo
else
 echo "Team please taken an action: Ambari Postgres backup failed due to the reason that the string PostgreSQL database completed was not found on `hostname` at `date` in $POSTGRES_BACKEDFILE"|  mailx -s "FAILURE: Ambari Postgres Backup failed on `hostname -f`" -r "DoNotReply" $mailto

fi

gzip $POSTGRES_BACKEDFILE;

# Remove backups older than 14 days
find $POSTGRESDB_BACKUP -maxdepth 1 -type d -mtime +14 -exec rm -rf {} \;

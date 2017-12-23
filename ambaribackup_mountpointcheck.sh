#!/bin/bash
#This is the script to backup ambari postgres database
POSTGRESDB_BACKUP="/backup/hadoop/DD/`date +%Y-%m-%d`/ambari"
POSTGRES_BACKEDFILE="/backup/hadoop/DD/`date +%Y-%m-%d`/ambari/`hostname -f`_ambari_metadata_postgres_backup_`/bin/date +\%Y\%m\%d`.sql"
POSTGRES_USER="postgres"
DELETEFILES="/backup/hadoop/DD/"
mailto=xxxxx

# Create the backup directory
mkdir -p $POSTGRESDB_BACKUP
PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/TradeCard/bin:/root/bin;/opt/dataops/scripts/ambaribackup_dd.sh;"

# Backup command
if  mountpoint -q /backup/hadoop/;
then
 runuser -l $POSTGRES_USER -c 'pg_dump ambari' > $POSTGRES_BACKEDFILE;
else
echo "You can't write to root"
exit 1
fi

if  [  "$(grep -i 'PostgreSQL database dump complete' $POSTGRES_BACKEDFILE)" ] && mountpoint -q /backup/hadoop;
then
echo "Success"
else
echo "Dataops Team please taken an action: Ambari Postgres backup failed due to the reason that the string PostgreSQL database completed was not found on `hostname` at `date` in $POSTGRES_BACKEDFILE"|  mailx -s "Email DL" -s "FAILURE: Ambari Postgres Backup failed on `hostname -f`" -S smtp="smtpserver:25" -S ssl-verify=ignore $mailto
fi

# Remove backups older than 14 days
find $DELETEFILES -maxdepth 1 -type d -mtime +14 -exec rm -rf {} \;

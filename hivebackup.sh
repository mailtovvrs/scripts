#!/bin/bash
Now=`date`
outputdir=/home/venkat/scripts/mysql-hive-backup
backupfile=mysql_hive_backup_`/bin/date +\%Y\%m\%d`.sql
mailto=mailtovvrs@gmail.com
echo "BACKUPFILE:" $backupfile

echo
echo   "*****Hortonworks Mysql Hive Database Backup started $Now on `hostname`*****"
echo

 mysqldump --log-error=/home/venkat/scripts/mysql_hive_backup.log --databases hive > /home/venkat/scripts/$backupfile;
 mv $backupfile $outputdir
 gzip  > /home/venkat/scripts/$backupfile.gz;
 mv $backupfile.gz $outputdir

 echo  ******Size of backup file*********
 echo
 echo "Size of backupfile:" `du -h /home/venkat/scripts/$backupfile`
 echo
 echo "Size of compressed backupfile:" `du -h /home/venkat/scripts/$backupfile.gz`
 echo



#Checking if the MySQL is successfully backup or not"

if  [  "$(grep -i 'Dump completed' /home/venkat/scripts/$backupfile)" ];
then
#mailx -s "SUCCESS: Hive Daily backup Success string Dump completed found in the backup file $backupfile" $mailto

echo

echo "Success string 'Dump completed' found in the backup file $backupfile"
echo
echo
else
mailx -s "FAILURE: Hive Daily backup FAILED Success string Dump completed not found in the backup file $backupfile" $mailto

fi

#Remove backups older than 2 days 
find /home/venkat/scripts/ -maxdepth 1 -type d -mtime +2 -exec rm -rf {} \; 


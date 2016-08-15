#!/bin/bash
Now=`date`
outputdir=/home/vvelagala/scripts/mysql-hive-backup
backupfile=mysql_hive_backup_`/bin/date +\%Y\%m\%d`.sql
mailto=venkat.velagala@infor.com
echo "BACKUPFILE:" $backupfile

echo
echo   "*****Hortonworks Mysql Hive Database Backup started $Now on `hostname`*****"
echo

 mysqldump --log-error=/home/vvelagala/scripts/mysql_hive_backup.log --databases hive > /home/vvelagala/scripts/$backupfile;
 mv $backupfile $outputdir
 gzip  > /home/vvelagala/scripts/$backupfile.gz;
 mv $backupfile.gz $outputdir

 echo  ******Size of backup file*********
 echo
 echo "Size of backupfile:" `du -h /home/vvelagala/scripts/$backupfile`
 echo
 echo "Size of compressed backupfile:" `du -h /home/vvelagala/scripts/$backupfile.gz`
 echo



#Checking if the MySQL is successfully backup or not"

if  [  "$(grep -i 'Dump completed' /home/vvelagala/scripts/$backupfile)" ];
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
find /home/vvelagala/scripts/ -maxdepth 1 -type d -mtime +2 -exec rm -rf {} \; 


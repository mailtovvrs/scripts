# scripts

#!/bin/bash
Now=`date`
outputdir=/home/vvelagala/scripts/mysql-hive-backup
backupfile=mysql_hive_backup_`/bin/date +\%Y\%m\%d`.sql
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

if [  "$(grep -i 'Dump completed' /home/vvelagala/scripts/$backupfile)" ];
then
/usr/bin/sendmail -s "Backup Succeeded Subject" venkat.velagala@infor.com
echo
echo "SUCCESS: Hive Daily backup completed.";
echo
echo "*****Hortonworks Mysql Hive Database Backup completed $Now on `hostname`*****"

echo

echo "Success string 'Dump completed' found in the backup file $backupfile"
echo
echo

echo  "*********Using mysqlcheck to validate if backedupfile:$backupfile is good or corrupted OK status stands for Good ********"

echo

mysqlcheck -c  -u vvelagala --databases hive

else

echo
echo "Success string 'Dump completed' not found in the backup file $backupfile.gz Backup appears to have been failed."
echo
echo "*********Backup is UNSUCCESSFUL.********"

fi

echo
echo

echo

#"Delete files older than 2 days"
find $outputdir/  *mysql_hive*.gz -mtime +2 -exec rm {} \;


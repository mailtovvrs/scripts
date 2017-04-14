#!/bin/bash

######################
#cat usertables
#DATAOPS_TABLE1 
#DATAOPS_TABLE2


#cat /home/base/OUTPUT1
# snapshot  'DATAOPS_TABLE2','SS-DATAOPS_TABLE2-04-13-17-22-35
# snapshot  'DATAOPS_TABLE2','SS-DATAOPS_TABLE2-04-13-17-22-36 etc.,
####################

OP1="/home/hbase/OUTPUT1"

# Function to create the snapshots
createss(){
  for sh in $(cat usertables)
  do
 
  # Command to create the snapshots
  echo "snapshot  '$sh','SS-$sh-`date +"%m-%d-%y-%H-%M"`'" | hbase shell >> $OP1
    if [ "$(grep 'ERROR' $OP1)" ];
            then
        echo "************Snapshot creation FAILED:$OUTPUT*************"
        exit 1
    else
        echo "Snapshot success"
        exportss
    fi
  done
}

# Command to export the snapshot from Source cluster to Target cluster
exportss(){
  for esh in $(cat $OP1 | awk -F "'" '{ print $4 }')
  do
  hbase org.apache.hadoop.hbase.snapshot.ExportSnapshot -snapshot $esh -copy-to hdfs://pprddr/apps/hbase/data -mappers 16
  done
  PPRDDRSS="`hdfs dfs -ls hdfs://pprddr/apps/hbase/data/* | grep SS-DATAOPS_TABLE* | wc -l`"
  PPRDSS="`grep -o 'SS-*' /home/hbase/OUTPUT2 | wc -l`"
   if [ $PPRDDRSS -ge $PPRDSS ];

   then
        echo "-----------------Now you are purging the Snapshots on the Source------------------"
        purgess

   else

        echo "-----------------Purging unsuccessful------------------"
        exit 2

   fi

}


# Fucntion to Purge the Snapshots

purgess(){


for sh in $(cat $OP1 | awk -F "'" '{ print $4 }')
 do
 echo "delete_snapshot '$sh'" | hbase shell
 done

}


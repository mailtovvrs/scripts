#!/bin/bash

OP1="/home/hbase/OUTPUT1"
OP2="/home/hbase/OUTPUT2"

#Function to create the snapshots
createss(){
  for sh in $(cat usertables)
  do

  # Command to create the snapshots
  echo "snapshot  '$sh','SS-$sh-`date +"%m-%d-%y-%H-%M"`'" | hbase shell >> $OP1
    if [ "$(grep 'ERROR' $OP1)" ];
    then
    echo "************Snapshot creation FAILED:$OUTPUT*************"
    else
    echo "Snapshot success"
    echo $?
   exportss
    fi
  done
  exit 0
}

#Command to export the snapshot from Source cluster to Target cluster
exportss(){
for esh in $(cat /home/hbase/OUTPUT1 | awk -F "'" '{ print $4 }')

do
  hbase org.apache.hadoop.hbase.snapshot.ExportSnapshot -snapshot $esh -copy-to hdfs://pprddr/apps/hbase/data -mappers 16
done

echo $esh
}

createss

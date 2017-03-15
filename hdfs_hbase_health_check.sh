#/bin/bash
# Make sure to run this script as hbase/hdfs user       
       HADOOP_HOME=`/usr/hdp/current/hadoop-client/bin/hadoop`
       HBASE_HOME=`/usr/hdp/current/hbase-client/bin/hbase`
       ABNORMAL_QUERY="INCONSISTENT|CORRUPT|FAILED|Exception"
       # hbck and fsck report
       output=hbasereport
       $HBASE_HOME/bin/hbase hbck >> $output 
       $HADOOP_HOME/bin/hadoop fsck /hbase >> $output

# check report, this is going to give the count of the results of words from ABNORMAL_QUERY outputted to $output file
count=`egrep -c "$ABNORMAL_QUERY" $output`
echo $count

if [ $count -eq 0 ]; then
    echo "[OK] Cluster is healthy." > $output
else
    echo "[ABNORMAL] Cluster is abnormal!" > $output
   
   # Get the last matching entry in the report file, also this is going to grep for last matching entry word from ABNORMAL_QUERY
   #and output to varible $last_entry
    last_entry=`egrep "$ABNORMAL_QUERY" $output | tail -1`
    echo "($count) $last_entry"
    exit $STATE_CRITICAL
fi

#!/bin/bash
USER_TO_RUN="hbase"
HBCKSTATUS="/root/scripts/HBCKSTATUS"
mailto="xxxxxx"

PATH="/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/java/jdk1.7.0_67/bin:/opt/TradeCard/bin:/root/bin;/root/scripts/hbasesh.sh;"

check()
{

# Checking detailed report of all regions(tables) in HBase

runuser -l $USER_TO_RUN -c '/usr/bin/hbase hbck -details' > /dev/null 2>&1 >  /root/scripts/HBase_ConsistencyReport

# From the redirected file:HBase_ConsistencyReport grep for Status: OK
cat HBase_ConsistencyReport | grep -i "Status: OK"  > /dev/null 2>&1

       if [ $? -eq 0 ]
       then
       echo "HBase Cluster Consistency check - [HEALTHY]"
       exit 0
       else
  
  # If there are any inconsistencies detected in the tables sending email with appending the file content  
  echo "HBase Cluster Consistency check[DETAILED] - [UNHEALTHY] $(cat HBASEREGIONSREPORT)" | mailx -s "HBASE UNHEALTHY - Action required" -r "DoNotReply" $mailto
        
        # Once if there are any inconsistencies detected the following funtion would be called to fix(/usr/bin/hbase hbck -fix) the inconsistencies
        fix()
        {
         runuser -l $USER_TO_RUN -c '/usr/bin/hbase hbck -fix' > /dev/null 2>&1 > /root/scripts/HBase_ConsistencyFixReport
         cat HBase_ConsistencyFixReport | grep -i "Status: OK"  > /dev/null 2>&1
         
         # Checking to ensure if after running the /usr/bin/hbase hbck -fix the inconsistencies are fixed from the file:HBase_ConsistencyFixReport
          if [ $? -eq 0 ]
          then
          echo "HBase Cluster Consistencies Fixed - [FIXED] $(cat HBase_ConsistencyFixReport)" | mailx -s "HBASE UNHEALTHY IS FIXED - No Action Required" -r "DoNotReply" $mailto
          else
          echo "HBase Cluster Consistencies not Fixed - [NOT FIXED] $(cat HBase_ConsistencyFixReport)" | mailx -s NOT-FIXED - Action Required" -r "DoNotReply" $mailto"
          fi
         }

       fi
}

check
fix

~

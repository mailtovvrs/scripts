
USER_TO_RUN="hbase"
HBCKSTATUS="/root/scripts/HBCKSTATUS"
mailto="xxxxx"



# Checking the HBASE File System

runuser -l $USER_TO_RUN -c '/usr/bin/hbase hbck'  > /dev/null 2>&1 > /root/scripts/HBCKSTATUS


cat HBCKSTATUS | grep -i "Status: OK"  > /dev/null 2>&1

if [ $? -eq 0 ]
then
echo "HBASE - [HEALTHY]"
else
echo "HBase FileSystem  - [UNHEALTHY] $(cat HBCKSTATUS)" | mailx -s "Attention - [HBase FileSystem - UNHEALTHY] - Action required" -r "DoNotReply" $mailto
fi


# Checking full report of all regions

runuser -l $USER_TO_RUN -c '/usr/bin/hbase hbck -details' > /dev/null 2>&1 >  /root/scripts/HBASEREGIONSREPORT

cat HBASEREGIONSREPORT | grep -i "Status: OK"  > /dev/null 2>&1

if [ $? -eq 0 ]
then
echo "REGION REPORT - [HEALTHY]"
else
echo "HBase RegionReport - [UNHEALTHY] $(cat HBASEREGIONSREPORT)" | mailx -s "Attention - [HBase Region Report - UNHEALTHY] - Action required" -r "DoNotReply" $mailto
fi


ER_TO_RUN="hbase"
HBCKSTATUS="/root/scripts/HBCKSTATUS"
mailto="xxxxx"

PATH="/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/java/jdk1.7.0_67/bin:/opt/TradeCard/bin:/root/bin;/root/scripts/hbasesh.sh;"


# Checking the HBASE File System

runuser -l $USER_TO_RUN -c '/usr/bin/hbase hbck'  > /dev/null 2>&1 > /root/scripts/HBCKSTATUS


cat HBCKSTATUS | grep -i "Status: iOK"  > /dev/null 2>&1

if [ $? -eq 0 ]
then
echo "HBASE - [HEALTHY]"
else
echo "HBase FileSystem  - [UNHEALTHY] $(cat HBCKSTATUS)" | mailx -s "Attention - [HBase FileSystem - UNHEALTHY] - Action required" -r "DoNotReply" $mailto
fi


# Checking full report of all regions

runuser -l $USER_TO_RUN -c '/usr/bin/hbase hbck -details' > /dev/null 2>&1 >  /root/scripts/HBASEREGIONSREPORT

cat HBASEREGIONSREPORT | grep -i "Status: OiK"  > /dev/null 2>&1

if [ $? -eq 0 ]
then
echo "REGION REPORT - [HEALTHY]"
else
echo "HBase RegionReport - [UNHEALTHY] $(cat HBASEREGIONSREPORT)" | mailx -s "Attention - [HBase Region Report - UNHEALTHY] - Action required" -r "DoNotReply" $mailto
fi

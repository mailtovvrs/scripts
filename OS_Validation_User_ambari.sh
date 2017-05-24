#!/bin/bash
for i in $(cat /home/ambari/hostscheck)
do
ssh $i 'echo "**************************************************************" ; \
echo "----- \"Fully Qualified Host Name:\" -----"
hostname -f ; echo ;                            \
java -version; echo;                            \
echo "----- \"File System:df -h\" ------" ; df -PhT ; echo; echo;     \
echo "----- \"Memory Status:\" ------"; free -m; echo; echo;      \
echo "----- \"Ulimits Status:\" -----";ulimit -Sn;               \
ulimit -Hn; echo;               \
echo "----- \"UMASK Value:\" -----" ;               \
umask; echo;                    \
echo "----- \"Check THP - Transparent Huge Pages:\" -----" ;                     \
cat /sys/kernel/mm/redhat_transparent_hugepage/enabled;         \
cat /sys/kernel/mm/redhat_transparent_hugepage/defrag;echo;echo;\
'
done


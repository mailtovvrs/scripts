#!/bin/bash

# This script is to validate the OS prerequisites for hadoop/hbase clusters build

for i in $(cat rctphosts);


# Check java
do ssh $i java -version;

echo

# Check storage
echo ****storage:$i****
df -h | grep /dfs;

echo
echo

# Check Memory
echo ****Memory:$i****
free -m;

echo
echo

# Check Ulimit
echo ***Ulimit:$i****
ulimit -Sn;
ulimit -Hn;

echo
echo

# Check FQDN
echo ****FQDN:$i****
hostnm=`hostname`;
hostfqdn=`hostname -f`;
echo $hostnm
echo $hostfqdn

echo
echo

# Check NTP service
echo ****NTP:$i****

service ntpd status;

echo
echo

# Check NSCD(Name Service Caching Daemon) service
echo ****NSCD:$i****
service nscd status;

echo
echo


# Check Firewall
echo ****IPTABLES:$i****
sudo service iptables status;

echo
echo

# Check SELinix
echo ****SELinux:$i****
getenforce;

echo
echo


# Check umask
echo ****UMASK:$i****
umask;

echo
echo

# Check THP(Transparent Huge Pages)
echo ****THP:$i****
cat /sys/kernel/mm/redhat_transparent_hugepage/enabled;
cat /sys/kernel/mm/redhat_transparent_hugepage/defrag;

echo
echo


# Check Ambari and HDP repositories
echo ****Repos:$i****
cat /etc/yum.repos.d/ambari.repo;
cat /etc/yum.repos.d/hdp.repo;

echo
echo

done

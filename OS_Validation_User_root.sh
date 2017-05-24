#!/bin/bash
echo "----- \"SESTATUS:\" -----"
sestatus ; echo;
echo
echo "----- \"Firewall status:\" -----"
service iptables status; echo;  \
echo
echo "----- \"Name Service Caching Daemon Status:\" -----"
service nscd status; echo; \
echo
echo "----- \"NTP status:\" -----"
service ntpd status
echo
echo "----- \"Swapiness status:\" -----"
cat /proc/sys/vm/swappiness
echo
echo "----- \"Chef 99-chef-attributes.conf:\" -----"
cat /etc/sysctl.d/99-chef-attributes.conf
echo
echo "----- \"Sysctl -a:\" ------"
cd /etc/sysctl.d ; sysctl -a


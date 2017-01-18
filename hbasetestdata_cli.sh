#!/bin/bash

# Test Data from CLI


PATH="/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/java/jdk1.7.0_67/bin:/opt/TradeCard/bin:/root/bin;/root/scripts/hbasetd.sh;"

# List the tables in HBase shell
echo "list" | hbase shell

# Create HBase table
echo "create 'RamSimha', 'colfam1'" | hbase shell > /dev/null 2>&1 > /root/scripts/HBASETD

# Put/Insert the data into HBase table
echo "put 'RamSimha', 'myrow-1', 'colfam1:q1', 'value-1'" | hbase shell > /dev/null 2>&1 > /root/scripts/HBASETD
echo "put 'RamSimha', 'myrow-2', 'colfam1:q2', 'value-2'" | hbase shell > /dev/null 2>&1 > /root/scripts/HBASETD
echo "put 'RamSimha', 'myrow-3', 'colfam1:q3', 'value-3'" | hbase shell > /dev/null 2>&1 > /root/scripts/HBASETD

# Insert 1K rows into the table - THIS IS NOT WORKING - TEST/CHECK IT OUT
echo "for i in '0'..'9' do for j in '0'..'9' do for k in '0'..'9' do put 'RamSimha', "row-#{i}#{j}#{k}", "colfam1:#{j}#{k}", "#{j}#{k}" end end end" | hbase shell > /dev/null 2>&1 > /root/scripts/HBASETD

# Get the data from the table
echo "get 'RamSimha', 'myrow-1'" | hbase shell

# Scannning the table
echo "scan 'RamSimha'" | hbase shell

# Count the no.of rows in a table
echo "count 'TESTTABLE'" | hbase shell

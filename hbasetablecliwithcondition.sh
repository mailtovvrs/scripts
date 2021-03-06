#!/bin/bash

# The intention of this script is to check if there is as existing table named:TESTTABLE in the hbase shell in the 
# non-interactive mode from CLI. If TESTTABLE is found its going to disable and drop and create a new one else will create
# as new table as TESTTABLE.. this script would run as user:hbase

echo "list" | hbase shell > "/home/hbase/test"

if [ "$(grep  'TESTTABLE' "/home/hbase/test")" ];
then
echo "---------TABLE EXISTS-------"
echo
echo
echo "--------DISABLING AND DROPPING EXISTING TABLE ----------"
echo "disable 'TESTTABLE'" | hbase shell
echo "drop 'TESTTABLE'" | hbase shell

else
echo "--------TABLE DOESN'T EXISTS THEREFORE -- ITS GETTING CREATED NOW....."
echo
echo

# Create HBase table
echo "create 'TESTTABLE', 'colfam1'" | hbase shell

# Put/Insert the data into HBase table
echo "put 'TESTTABLE', 'myrow-1', 'colfam1:q1', 'value-1'" | hbase shell
echo "put 'TESTTABLE', 'myrow-2', 'colfam1:q2', 'value-2'" | hbase shell
echo "put 'TESTTABLE', 'myrow-3', 'colfam1:q3', 'value-3'" | hbase shell

# Get the data from the table
echo "get 'TESTTABLE', 'myrow-1'" | hbase shell

# Scannning the table
echo "scan 'TESTTABLE'" | hbase shell


fi


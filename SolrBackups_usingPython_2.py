#!/usr/bin/env python

from __future__ import print_function
import os
import json
import urllib2

# setup variables
solr_url = "http://lab-kvs1-01-b.qa.gtnexus.com:8983/solr/UMB/"  # solr url "http://localhost:8983/solr/"
backup_dir = "/database/solr/data/UMB/data"  # solr backup directory "/home/solr/backup"


def solr_backup():


    # solr url to call backup api
    url = "curl" + " " + solr_url + "replication?command=backup"
    os.system(url)

    #print "\n"

    # status of last backup with JSON
    status_url = solr_url + "replication?command=details&wt=json"
    response = urllib2.Request(status_url)
    opener = urllib2.build_opener()
    f = opener.open(response)
    json1 = json.loads(f.read())
    
    # Creating a file:BackupStatus.txt using out = open('BackupStatus.txt', 'w') and file=out and out.close() for writing the JSON print results from the below stmts so that I can send
    # via the cron entry the JSON results
    # Cron entry is as follows:
    # MAILTO=xxxxx
    # * * * * * /root/solrbak.py > /dev/null 2>&1 | cat BackupStatus.txt | mailx -s "UMB Solr Backup results"  -r "DoNotReply" $MAILTO

    out = open('BackupStatus.txt', 'w')
    try:

      print("Start Time:", json1['details']['backup'][1],file=out)
      print("End Time:", json1['details']['backup'][7],file=out)
      print("Index Size: ", json1['details']['indexSize'],file=out)
      print("Backup Status:", json1['details']['backup'][5],file=out)
      print("Backup File Count:", json1['details']['backup'][3],file=out)
      print("IndexVersion:" ,json1['details']['commits'][0][1],file=out)
      print("Generation:", json1['details']['commits'][0][3],file=out)
      print("Backup Location:", backup_dir,file=out)

    except:
      # To ignore the exception use the pass in except
      pass

      out.close()

if __name__ == '__main__':
    solr_backup()


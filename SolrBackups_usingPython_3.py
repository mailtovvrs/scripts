#!/usr/bin/env python

from __future__ import print_function
import os
import json
import urllib2
# Module included to get the host fully qualified name
import socket

# socket.getfqdn() gets you the fully qualified name of the current host you logged in
ENV =  "http://" + socket.getfqdn() + ":8983/solr/UMB/"

# setup variables
solr_url = ENV
backup_dir = "/database/solr/data/UMB/data"


def solr_backup():


    # solr url to call backup api
    url = "curl" + " " + solr_url + "replication?command=backup"
    os.system(url)

    #print "\n"

    # status of last backup with JSON
    status_url = ENV + "replication?command=details&wt=json"
    response = urllib2.Request(status_url)
    opener = urllib2.build_opener()
    f = opener.open(response)
    json1 = json.loads(f.read())

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
      pass

      out.close()

if __name__ == '__main__':
    solr_backup()





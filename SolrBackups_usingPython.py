#!/usr/bin/env python

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

    print "\n"

    # status of last backup with JSON
    status_url = solr_url + "replication?command=details&wt=json"
    response = urllib2.Request(status_url)
    opener = urllib2.build_opener()
    f = opener.open(response)
    json1 = json.loads(f.read())

    try:

      print "Start Time:", json1['details']['backup'][1]
      print "End Time:", json1['details']['backup'][7]
      print "Index Size: ", json1['details']['indexSize']
      print "Backup Status:", json1['details']['backup'][5]
      print "Backup File Count:", json1['details']['backup'][3]
      print "IndexVersion:" ,json1['details']['commits'][0][1]
      print  "Generation:", json1['details']['commits'][0][3]
      print "Backup Location:", backup_dir

    except:
      pass

if __name__ == '__main__':
    solr_backup()



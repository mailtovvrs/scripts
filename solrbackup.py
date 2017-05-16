#!/usr/bin/python

# import requirements
import os
import urllib2
import json
from datetime import datetime


# setup solr replication for backup
# Ref URL : https://cwiki.apache.org/confluence/display/solr/Index+Replication

###################################
#
#<requestHandler name="/replication" class="solr.ReplicationHandler" >
#    <lst name="master">
#        <str name="replicateAfter">optimize</str>
#        <str name="backupAfter">optimize</str>
#        <str name="confFiles">schema.xml,stopwords.txt,elevate.xml</str>
#    </lst>
#</requestHandler>
#
###################################


# setup variables
solr_url = "http://localhost:8983/solr/#/" 			# solr url "http://localhost:8983/solr/"
backup_dir = "/users/vvelagala/solrbackup"			# solr backup directory "/home/solr/backup"


# set backup name
backup_name = "solr-backup-" + datetime.now().strftime("%Y-%M-%d-%H-%M")
	
# solr url to call backup api
url = "http://localhost:8983/solr/#/"  + "replication?command=backup&location="+backup_dir+"&name="+backup_name+"&wt=json"
res = urllib2.Request(url)
	
# tar file name to upload
tar_file_name = backup_dir + backup_name + ".tar.bz2 "
cmd = "tar -jcvf " + tar_file_name + "-C " + backup_dir + backup_name + " " + backup_name
os.system(cmd)

# status of last backup
status_url = "http://localhost:8983/solr/#/" +  "replication?command=details&wt=json"
print status_url
res = urllib2.Request(status_url)
print res
opener = urllib2.build_opener()
f = opener.open(res)
output = json.loads(f.read())
print "Start Time: ", output['details']['backup'][1]
print "End Time: ", output['details']['backup'][7]
print "Backup Status: ", output['details']['backup'][5]
print "Backup File Count: ", output['details']['backup'][3]
print "Backup Name: ", output['details']['backup'][9]


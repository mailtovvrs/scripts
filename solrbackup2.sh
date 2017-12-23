#!/bin/bash
#CORE="venkat"
#ENV="localhost"
#BAKLOC="/Users/venkat/venkatsolrbackup/"
MAILTO="abc.com"


#backup API
backup(){http1://localhost:8983/solr/venkat/replication?command=backup&name=venkat&location=/Users/venkat/venkatsolrbackup/'
curl ' >> backupstatus 2>&1
	if [ $? -eq 0 ]
        then
	 echo "[Solr Backup Succeeded]"
	else
	 echo "[Solr Backup Failed]"
	backupStatus
        fi
}


backupStatus(){
curl 'http://localhost:8983/solr/venkat/replication?command=details' >> backupstatus 2>&1
echo "Solr Backup Failed details - $(cat backupstatus)" | mailx -s "Attention - [Solr Backup Failed ] - Action required" -r "DoNotReply" $MAILTO
}

# Manual backup

# Mbackup(){
# curl 'http://localhost:8983/solr/venkat/replication?command=backup'
# echo $?

# Snapshot created location
# /usr/local/Cellar/solr/6.4.1/server/solr/venkat/data
#  ls -ltr 
# It would be under the name snapshot

#}



backup

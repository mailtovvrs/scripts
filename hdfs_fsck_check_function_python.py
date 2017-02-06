#!/usr/bin/python
import re
from subprocess import Popen, PIPE

hadoop = "hadoop"
fsck = "fsck"


def hdfsfsck():
 slash = "/"

 # Capturing hadoop filesystem output
 (stdout, stderr) = Popen([hadoop,fsck,slash], stdout=PIPE).communicate()
 writing = open("fsckoutput","w")
 writing.write(stdout)
 writing.close()

 # Read File
 file = open( "fsckoutput", "r" )
 lines = file.readlines()
 file.close()

 # Look for patterns
 countYes = 0
 countNo  = 0
 status = "HEALTHY"
 for line in lines:
    line = line.strip().upper()
    if line.find( "HEALTHY")!=-1 and len(status)==7:
        countYes = countYes + 1

 #display result
 print( "HEALTHY: ", countYes )
 print( "UNHEALTHY: ", countNo )



if __name__ == "__main__":
 hdfsfsck()


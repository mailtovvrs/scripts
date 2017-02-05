#!/usr/bin/python
import re
from subprocess import Popen, PIPE

hadoop = "hadoop"
fsck = "fsck"
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
for line in lines:
    line = line.strip()
    #print line
    if line.find( "HEALTHY" )!= -1:
        countYes = countYes + 1
    if line.find( "2163" )!= -1:
        countNo = countNo + 1

# display result
print( "HEALTHY: ", countYes )
print( "2163: ", countNo )

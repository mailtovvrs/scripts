#!/usr/bin/python
# You need to run this script as a HDFS user
import re
from subprocess import Popen, PIPE

# Defining global variables
hadoop = "hadoop"
fsck = "fsck"

# Defininig the function hdfsfsck()
def hdfsfsck():
 slash = "/"

 # Capturing hadoop filesystem output to stdout and errors to stderr
 (stdout, stderr) = Popen([hadoop,fsck,slash], stdout=PIPE).communicate()
 
 # Writing the output to fsckoutput if already present, if not would create a new one
 writing = open("fsckoutput","w")
 # Writing to stdout
 writing.write(stdout)
 # Make sure to close for read or write - Important
 writing.close()

 # Read File from file:fsckoutput
 file = open( "fsckoutput", "r" )
 # Read all the lines from file and store in variable:lines
 lines = file.readlines()
 # Close the file
 file.close()

 # Look for patterns
 countYes = 0
 countNo  = 0
 status = "HEALTHY"
 for line in lines:
    # After reading each and every line this would locate and strip any whitespaces present before HEALTHY with uppercase
    line = line.strip().upper()
    # The below condition checks if "HEALTHY" is present and its length is 7 from file:fsckoutput
    if line.find( "HEALTHY")!=-1 and len(status)==7:
       # Count the occurances of HEALTHY
        countYes = countYes + 1

 #display result
 print( "HEALTHY: ", countYes )
 print( "UNHEALTHY: ", countNo )


# This is mandatory definition before calling any functions in python script
if __name__ == "__main__":
 hdfsfsck()


#!/usr/bin/python

import urllib2
import json

# Need the urllib2 module to make a request to below jmx
req = urllib2.Request("http://lab-hddb-04-b.qa.gtnexus.com:50070/jmx")

# This is mandatory code to build_opener()
opener = urllib2.build_opener()

# Pass the string json URL object to variable f
f = opener.open(req)

# Convert the string url object to json
json = json.loads(f.read())

#print json

# Once the string is converted to json..via the dict data type supported in python you can use
# the Key value concept..here we are using the beans dict object for the 5th object in dict
#print(json['beans'][19]['VolumeFailuresTotal'])

Failures = json['beans'][19]['VolumeFailuresTotal']

if Failures == 1:
 print "[WARNING]: Alert their is one disk failure but still OK since HDFS accomdates 2 disk failures"
elif Failures == 2:
 print "[CRITICAL: Attention required that tow disk failure causes the DataNode to go down...React Immediately]"
else:
 print "[GOOD: No Action required]"

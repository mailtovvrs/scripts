#!/usr/bin/python

import urllib2
import json

# Need the urllib2 module to make a request to below jmx
req = urllib2.Request("http://lab-happ-01-b.qa.gtnexus.com:16010/jmx")

# This is mandatory code to build_opener()
opener = urllib2.build_opener()

# Pass the string json URL object to variable f
f = opener.open(req)

# Convert the string url object to json
json = json.loads(f.read())

# Once the string is converted to json..via the dict data type supported in python you can use
# the Key value concept..here we are using the beans dict object for the 5th object in dict
print(json['beans'][4]['LastGcInfo']['memoryUsageAfterGc'][0]['key'])

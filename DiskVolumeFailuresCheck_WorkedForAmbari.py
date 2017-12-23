#!/usr/bin/python

import urllib2
import json
def execute(a1,a2,a3):
# Need the urllib2 module to make a request to below jmxhttp://Namenodehost:50070/jmx
        req = urllib2.Request("")


# This is mandatory code to build_opener()
        opener = urllib2.build_opener()

# Pass the string json URL object to variable f
        f = opener.open(req)

# Convert the string url object to json
        json1 = json.loads(f.read())

#print json

# Once the string is converted to json..via the dict data type supported in python you can use
# the Key value concept..here we are using the beans dict object for the 5th object in dict
#print(json['beans'][19]['VolumeFailuresTotal'])

        Failures = json1['beans'][19]['VolumeFailuresTotal']
        result = "OK"
        label = "No Action Required"
        if Failures == 1:
                result = "WARNING"
                label = "Alert their is one disk failure but still OK since HDFS accomdates 2 disk failures"
        elif Failures >= 2:
                result = "CRITICAL"
                label = "Attention required that tow disk failure causes the DataNode to go down...React Immediately]"

        return result, [label]

if __name__ == "__main__":
        print execute(0,0,0)

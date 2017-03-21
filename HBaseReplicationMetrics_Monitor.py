#!/usr/bin/python

import urllib2
import json

def execute(a1,a2,a3):


 req1 = urllib2.Request('http://pprd-hddb2-01-b.dc.gtnexus.com:16030/jmx')
 req2 = urllib2.Request('http://pprd-hddb2-02-b.dc.gtnexus.com:16030/jmx')
 req3 = urllib2.Request('http://pprd-hddb2-03-b.dc.gtnexus.com:16030/jmx')

 opener = urllib2.build_opener()
 f1 = opener.open(req1)
 f2 = opener.open(req2)
 f3 = opener.open(req3)

 json1 = json.loads(f1.read())
 json2 = json.loads(f2.read())
 json3 = json.loads(f3.read())

 appliedOps1 = json1['beans'][13]['sink.appliedOps']
 appliedBatches1 = json1['beans'][13]['sink.appliedBatches']
 ageOfLastAppliedOp1 = json1['beans'][13]['sink.ageOfLastAppliedOp']



 appliedOps2 = json2['beans'][13]['sink.appliedOps']
 appliedBatches2 = json2['beans'][13]['sink.appliedBatches']
 ageOfLastAppliedOp2 = json2['beans'][13]['sink.ageOfLastAppliedOp']


 appliedOps3 = json3['beans'][14]['sink.appliedOps']
 appliedBatches3 = json3['beans'][14]['sink.appliedBatches']
 ageOfLastAppliedOp3 = json3['beans'][14]['sink.ageOfLastAppliedOp']


 print "RS1:appliedOps1:%s" % appliedOps1
 print "RS1:appliedBatches1:%s" % appliedBatches1
 print "RS1:ageOfLastAppliedOp1:%s" % ageOfLastAppliedOp1

 print "\n"


 print "RS2:appliedOps2:%s" % appliedOps2
 print "RS2:appliedBatches2:%s" % appliedBatches2
 print "RS2:ageOfLastAppliedOp2:%s" % ageOfLastAppliedOp2

 print "\n"

 print "RS3:appliedOps3:%s" % appliedOps3
 print "RS3:appliedBatches3:%s" % appliedBatches3
 print "RS3:ageOfLastAppliedOp3:%s" % ageOfLastAppliedOp3

 print "\n"

 StrObj1 =  str(appliedOps1)
 StrObj2 =  str(appliedBatches1)
 StrObj3 =  str(ageOfLastAppliedOp1)

 StrObj4 =  str(appliedOps2)
 StrObj5 =  str(appliedBatches2)
 StrObj6 =  str(ageOfLastAppliedOp2)

 StrObj7 =  str(appliedOps3)
 StrObj8 =  str(appliedBatches3)
 StrObj9 =  str(ageOfLastAppliedOp3)



 if ageOfLastAppliedOp1 == 0 or ageOfLastAppliedOp2 == 0 or ageOfLastAppliedOp3 == 0:
  result = "WARNING"
  label = "[WARNING] Alert Latency Exceeded by  0.5 seconds...Need to monitor: %s %s %s: %s %s %s: %s %s %s" %(StrObj1,StrObj2,StrObj3,StrObj4,StrObj5,StrObj6,StrObj7,StrObj8,StrObj9)


 elif ageOfLastAppliedOp1 > 0 or ageOfLastAppliedOp2 > 0 or ageOfLastAppliedOp3 > 0:

   appliedOps1 = json1['beans'][13]['sink.appliedOps']
   appliedBatches1 = json1['beans'][13]['sink.appliedBatches']
   ageOfLastAppliedOp1 = json1['beans'][13]['sink.ageOfLastAppliedOp']



   appliedOps2 = json2['beans'][13]['sink.appliedOps']
   appliedBatches2 = json2['beans'][13]['sink.appliedBatches']
   ageOfLastAppliedOp2 = json2['beans'][13]['sink.ageOfLastAppliedOp']


   appliedOps3 = json3['beans'][14]['sink.appliedOps']
   appliedBatches3 = json3['beans'][14]['sink.appliedBatches']
   ageOfLastAppliedOp3 = json3['beans'][14]['sink.ageOfLastAppliedOp']

   result = "CRITICAL"
   label = "[CRITICAL] ***** Attention:Alert Latency Exceeded by 1 second=> RS1:%s %s %s, RS2:%s %s %s, RS3:%s %s %s" %(StrObj1,StrObj2,StrObj3,StrObj4,StrObj5,StrObj6,StrObj7,StrObj8,StrObj9)

 return result, [label]

if __name__ == "__main__":
        print execute(0,0,0)


# Need to check to use the for loop
#jsono = ['json1','json2','json3']

#for rm in jsono['beans']:

 #print rm['beans'][13]['sink.appliedOps']


 #print "\n"


##############################################################
#  Max message length and each split message length variables 
#  should be set under main Totsglen (&) Splitmsglen
#  At the moment for testing they are set to Totsglen=60 & Splitmsglen=15
#  No changes required if we need to test with these values.
##############################################################



import re

def solution(s, k):
    slen=len(s)

    ## Count for total words
    count=0
    for i in s.split():
        count = count +1

    ## Exit if it is single word and bigger than split sms size defined in begining
    if count == 1:
        if slen > k:
            print "Cannot proceed, single word with more than %s chars " %(k)
            return -1
    else:
#       print "multiple words"
        t=""
        t1=""
        msgcount=0
        for i in s.split():
#           print i, len(i)
            t1 = t
            t = t + " " + i
#           print t1,len(t1)
#           print t,len(t)
            if len(t) > k:
                sendsms(t1)
                print t1.strip()
                msgcount = msgcount + 1
                t=i
                t1=""
        sendsms(t)
        print t.strip()
        msgcount = msgcount + 1
    print " Total messages = %d" %(msgcount)
    return msgcount
#   print "Ending lines in function "



##### Function for sending sms...concat all sms ###
def sendsms(str):
    global concat_msg
    concat_msg = concat_msg + str + " "
    concat_msg.strip()




############################################ Main #################################################

### Set your Max message size and each sms limits  ###
Totsglen=60
Splitmsglen=15


concat_msg=""

txt=raw_input("Enter Text:")
#print txt

txt=txt.strip()
txt=re.sub(' +',' ',txt)

print ""
print "Removing all leading, trail spaces and double spaces in middle of input text"
print ""
print txt
print "lenght of final string: %d" %(len(txt))
print ""
#print txt.isalpha()


if len(txt) == 0:
    print "Empty string .. please try agian"
elif len(txt) > Totsglen:
    print "Strign is morethan %d chars.... try again" %(Totsglen)
else:
    print "each sms should not exceed %d chars" %(Splitmsglen)
    solution(txt,Splitmsglen)

print ""
print "Final concatinated message"
print concat_msg

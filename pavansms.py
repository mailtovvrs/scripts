#!/usr/bin/python
import re
import sys

def solution(S,K):
 K = range(1,500)
 S = raw_input("Provide the text to SMS\n")
 if S == "":
  print "You have to enter text and the length of the text entered is:",len(S)
  sys.exit

 elif re.search(r'\S+(?:(?!\s{2}).)+', S).group():
   print "Length of the text entered is:",len(S)
   if K and len(S)<500:
    words = S.split()
    for messages in words:
     print messages
     print "total messages in words:", len(messages)
 else:
    return -1

SMS = solution("This i s a  t e                    st", 501) 
  
   
  





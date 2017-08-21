import smtplib
import string

HOST = "mail-B.qa.gtnexus.com"
SUBJECT = "Test email from Python"
TO = "venkat.velagala@infor.com"
FROM = "_dba@gtnexus.com"
text = "Python rules them all and this is another text!"
BODY = string.join((
        "From: %s" % FROM,
        "To: %s" % TO,
        "Subject: %s" % SUBJECT ,
        "",
        text
        ), "\r\n")
server = smtplib.SMTP(HOST)
server.sendmail(FROM, [TO], BODY)
server.quit()

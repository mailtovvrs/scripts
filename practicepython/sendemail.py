#!/usr/bin/python

import smtplib

content = 'example email stuff here'

mail = smtplib.SMTP('smtp.gmail.com',587)

mail.ehlo()

mail.starttls()

mail.login(mailtovvrs@gmail.com,shrewd)

mail.sendmail(mailtovvrs@gmail.com,mailtovvrs@gmail.com,content)

mail.close()
 

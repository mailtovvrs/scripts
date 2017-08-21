import datetime

# Create a program that asks the user to enter their name and their age. Print out a message addressed to them that tells them the year that they will turn 100 years old.

name = raw_input("Please enter your name:\n")
currentyear = datetime.date.today().year
currentage = raw_input("Please enter the year you are born:\n")
now = currentyear - int(currentage)
print "Hi" " "  +str(name) +". Your age is:" + str(now)

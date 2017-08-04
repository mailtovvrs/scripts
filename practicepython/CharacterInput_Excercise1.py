import datetime

# Create a program that asks the user to enter their name and their age. Print out a message addressed to them that tells them the year that they will turn 100 years old.

name = raw_input("Please enter your name:\n")
currentyear = datetime.date.today().year 
currentage = raw_input("Please enter your age:\n")
Agefor100 = (100 - int(currentage))
Yearfor100 = currentyear + Agefor100
print "Hi" " "  +str(name) +". The year your age would be 100 is:" +str(Yearfor100)


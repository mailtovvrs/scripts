performances = {'Ventriloquism':       '9:00am', 
                'Snake Charmer':       '12:00pm', 
                'Amazing Acrobatics':  '2:00pm', 
                'Venkat21245':	       '6:00pm',
                'Enchanted Elephants': '5:00pm'}
schedule_file = open('schedule.txt','w')
for key,val in performances.items():
    schedule_file.write(key + '-' + val + '\n')

    ==============
    OUTPUT:cat schedule.txt 
Amazing Acrobatics-2:00pm
Venkat212-6:00pm
Enchanted Elephants-5:00pm
Ventriloquism-9:00am
Snake Charmer-12:00pm
  
      

a=[1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
b = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
c=[]

seta=set(a)
setaL=list(seta)
print setaL

setb=set(b)
setbL=list(setb)
print setbL

common = set(setaL) & set(setbL)
print common
commonL = list(common)
print commonL

c.append(commonL)
print "c:", c



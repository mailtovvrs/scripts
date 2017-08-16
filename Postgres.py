#!/usr/bin/python
import psycopg2
import datetime
import Postgrescrud

def insert_env(env_name,minauditid,maxauditid):
   Env = env_name
   MinID = minauditid
   MaxID = maxauditid

   postgrescrud = Postgrescrud.Postgrescrud()

   try:
    conn = postgrescrud.connect()
    conn = psycopg2.connect(conn)
    cursor = conn.cursor()
    sqlstmt = "INSERT into aws.env (env_name,minauditid,maxauditid) values('"+Env+"',"+MinID+","+MaxID+")"
    cursor.execute(sqlstmt)
    conn.commit()
    cursor.close()
    print "Records Inserted successfully into Environment table"
   except psycopg2.DatabaseError as error:
    print(error)
   finally:
    if conn is not None:
     conn.close()
   return 1

one_returned = insert_env('rctp','1','12')




def insert_batch(envid,startauditid,endauditid,update_time,running_host,status):
   EnvID = str(envid)
   StartID = str(startauditid)
   EndID = str(endauditid)
   Updtime = update_time
   RunningHost = running_host
   BatchStatus = status

   postgrescrud = Postgrescrud.Postgrescrud()

   try:
    conn = postgrescrud.connect()
    conn = psycopg2.connect(conn)
    cursor = conn.cursor()
    sqlstmt = "INSERT into aws.batch (envid,startauditid,endauditid,update_time,running_host,status) values("+EnvID+","+StartID+","+EndID+",'"+Updtime+"','"+RunningHost+"','"+BatchStatus+"')"
    cursor.execute(sqlstmt)
    conn.commit()
    cursor.close()
    print "Records Inserted successfully into batch table"
   except psycopg2.DatabaseError as error:
    print(error)
   finally:
    if conn is not None:
     conn.close()
   return 1

one_returned = insert_batch(1,2,3,'2017-08-09 15:36:38','test','yes')


def insert_keydetails(batchid,auditid,errordesc,errortime,status,update_time):
   BatchID = str(batchid)
   AuditID = str(auditid)
   ErrorDes = errordesc
   ErrorTime = errortime
   KeyStatus = status
   Updtime = update_time

   postgrescrud = Postgrescrud.Postgrescrud()

   try:
    conn = postgrescrud.connect()
    conn = psycopg2.connect(conn)
    cursor = conn.cursor()
    sqlstmt = "INSERT into aws.keydetails (batchid,auditid,errordesc,errortime,status,update_time) values("+BatchID+","+AuditID+", '"+ErrorDes+"','"+ErrorTime+"','"+KeyStatus+"','"+Updtime+"')"
    cursor.execute(sqlstmt)
    conn.commit()
    cursor.close()
    print  "Records Inserted successfully into Keydetails table"
   except psycopg2.DatabaseError as error:
    print(error)
   finally:
    if conn is not None:
     conn.close()
   return 1

one_returned = insert_keydetails(1,2,'Error','2017-08-09 15:36:38','failed','2017-08-09 15:36:38')


def update_batch(batchid,status):
   BatchID = str(batchid)
   CurrentTimeStamp = str(datetime.datetime.now())
   Status = status

   postgrescrud = Postgrescrud.Postgrescrud()

   try:
    conn = postgrescrud.connect()
    conn = psycopg2.connect(conn)
    cursor = conn.cursor()
    sqlstmt = "UPDATE aws.batch SET  status = '"+Status+"', update_time = '"+CurrentTimeStamp+"' WHERE batch.id = "+BatchID+""
    cursor.execute(sqlstmt)
    conn.commit()
    cursor.close()
    print "Records updated successfully into update batch table"
   except psycopg2.DatabaseError as error:
    print(error)
   finally:
    if conn is not None:
     conn.close()
   return 1

one_returned = update_batch(3,'not running')




def update_keydetails(batchid,auditid,errorno,errordesc,status):
   BatchID = str(batchid)
   AuditID = str(auditid)
   ErrorNo = str(errorno)
   ErrorDes = errordesc
   ErrorTime = str(datetime.datetime.now())
   Status = status
   Updtime =  str(datetime.datetime.now())

   postgrescrud = Postgrescrud.Postgrescrud()

   try:
    conn = postgrescrud.connect()
    conn = psycopg2.connect(conn)
    cursor = conn.cursor()
    sqlstmt = "UPDATE aws.keydetails SET batchid =  "+BatchID+", auditid = "+AuditID+", errorno = "+ErrorNo+", errordesc = '"+ErrorDes+"', status = '"+Status+"', errortime = '"+ErrorTime+"', update_time = '"+Updtime+"'"
    cursor.execute(sqlstmt)
    conn.commit()
    print "Records updated to update keydetails table"
   except psycopg2.DatabaseError as error:
    print(error)
   finally:
    if conn is not None:
     conn.close()
   return 1

one_returned = update_keydetails(2,3,250,'250error', 'succeeded')

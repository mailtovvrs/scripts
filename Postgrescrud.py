#!/usr/bin/python

import psycopg2
import datetime

class Postgrescrud:

 def __init__(self):
  pass


 # Connect to Postgres DB and select
 def connect(self):
  conn = None
  conn = "host='localhost' dbname='awstransfer' user='postgres'"
  return conn

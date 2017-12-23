#!/usr/bin/env python
import boto.ec2
import boto3
from validate_email_address import validate_email
from boto.s3.key import Key

s3_bucket = "xxxxx"
output = "/Users/venkat/Downloads/owner-report.txt"
s3_fileName =  output
target = "venkat/owner-report.txt"

session = boto3.Session(profile_name="default",region_name = "us-west-2")
s3 = session.client('s3',region_name= "us-west-2")
ec2 = session.resource('ec2',"us-west-2")

# Filtering the running instances
instances = ec2.instances.filter(Filters=[{'Name': 'instance-state-name','Values':['running','stopped','terminated'],'Name': 'tag-key','Values':['Owner']}])

f = open("owner-report.txt","w")

for instance in instances:
 print instance
 for tags in instance.tags:
  print tags
  if tags["Key"] == "Owner":
    if validate_email(tags["Value"]):
       output = instance.id + "\tKey:" +tags["Key"]  + "\tValue/Email:" + tags["Value"] + "\n"
       print output
       f.write(output)


# Uploading to S3 bucket
s3 = boto3.client('s3')
print s3

filename = s3_fileName
bucket_name = s3_bucket
f.close()

s3.upload_file(s3_fileName, bucket_name, target)



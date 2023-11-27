import boto3
import os
import io
import datetime
from openpyxl import load_workbook
import pandas as pd
import boto3
import snowflake.connector



s3_client = boto3.client("s3")
bucket_name = "s3-biz-igg-lon-dev-incomming"
output_bucket = "s3-biz-igg-dev-processed"


def list_files_in_bucket():
    s3 = boto3.resource('s3')
    bucket = s3.Bucket(bucket_name)
    files = {}
    for obj in bucket.objects.all():
        files[obj.key] = f"s3://{bucket_name}/{obj.key}"
    return files

def connect_to_snowflake(user, password, account, warehouse, database, schema):
    conn = snowflake.connector.connect(
        user=user,
        password=password,
        account=account,
        warehouse=warehouse,
        database=database,
        schema=schema
    )
    return conn

# Function to remove all files from the dictionary that aren't excel or csv files
def remove_non_spreadsheet_files(filelist):
    for key in list(filelist):
        if not key.endswith((".xlsx", ".csv")):
            del filelist[key]
    return filelist

def main():
    files = list_files_in_bucket()
    # filter out non excel or csv files
    files = remove_non_spreadsheet_files(filelist=files)
    # connect to snowflake
    conn = connect_to_snowflake(user=os.environ.get("SNOWFLAKE_USER"),
                                password=os.environ.get("SNOWFLAKE_PASSWORD"),
                                account=os.environ.get("SNOWFLAKE_ACCOUNT"),
                                warehouse=os.environ.get("SNOWFLAKE_WAREHOUSE"),
                                database=os.environ.get("SNOWFLAKE_DATABASE"),
                                schema=os.environ.get("SNOWFLAKE_SCHEMA"))
    # get cursor
    cursor = conn.cursor()
# TODO: Add logic to iterate through files and append to snowflake
    

if __name__ == "__main__":
    main()
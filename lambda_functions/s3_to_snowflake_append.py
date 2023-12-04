import boto3
import os
import io
import datetime
from openpyxl import load_workbook
import pandas as pd
import boto3
import os
import os
from dotenv import load_dotenv
import snowflake.connector



s3_client = boto3.client("s3")


# Load environment variables from .env file
load_dotenv()

bucket_name = os.environ.get("INCOMING_S3_BUCKET")
output_bucket = os.environ.get("OUTPUT_S3_BUCKET")


def list_files_in_bucket(bucket):
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
    files = list_files_in_bucket(output_bucket)
    # filter out non excel or csv files
    files = remove_non_spreadsheet_files(filelist=files)
    # print(files)
    # connect to snowflake
    conn = connect_to_snowflake(user=os.environ.get("SNOWFLAKE_USER"),
                                password=os.environ.get("SNOWFLAKE_PASSWORD"),
                                account=os.environ.get("SNOWFLAKE_ACCOUNT"),
                                warehouse=os.environ.get("SNOWFLAKE_WAREHOUSE"),
                                database=os.environ.get("SNOWFLAKE_DATABASE"),
                                schema="LDI_LGIM")
    # get cursor
    # cursor = conn.cursor()
'''
TODO: Function to map schema/tables to filenames in dictionary
TODO: Iterate through files to append to snowflake
TODO: Regex for filename mapping to schema/table
TODO: skip file if table/schema not found
'''
    

if __name__ == "__main__":
    main()

    # {'23-10-27 Biztory Extended Dataset Example/LDI-LGIM/Fund Risk Ladders & Fund Collateral Matrices - 07.06.2023.xlsx': 's3://s3-biz-igg-lon-dev-incomming/23-10-27 Biztory Extended Dataset Example/LDI-LGIM/Fund Risk Ladders & Fund Collateral Matrices - 07.06.2023.xlsx'}

    # {"filename": {
    #     'schema': 'val',
    #     'table': 'val',
    # },
    # "filename2": {
    #     'schema': 'val',
    #     'table': 'val',
    # },}
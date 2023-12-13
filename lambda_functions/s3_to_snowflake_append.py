import boto3
import io
import datetime
from openpyxl import load_workbook
import pandas as pd
import boto3
import os
from dotenv import load_dotenv
import snowflake.connector
from botocore.exceptions import NoCredentialsError, ClientError
from snowflake.connector.errors import DatabaseError, ProgrammingError
import urllib

# Load environment variables from .env file
load_dotenv()

schema_table_file_dict = {'ICE_MARKET_CURVE':
    {'CURVEOIS':'.*CurveOIS.*'
    ,'CURVEXCCY':'.*CurveXCCY.*'
    ,'CURVEYC':'.*CurveYC.*'
    ,'CURVEZC':'.*CurveZC.*'
    ,'SPOT_FORWARD':'.*Spot_Forward.*'}}
    

def find_table_and_pattern(file_name, schema_table_file_dict):
    for schema, tables in schema_table_file_dict.items():
        for table, pattern in tables.items():
            if pattern and pattern.replace('*','').replace('.','') in file_name:
                return schema, table, pattern
    return None, None, None

def connect_to_snowflake(user, password, account, role, warehouse, database, schema):
    conn = snowflake.connector.connect(
        user=user,
        password=password,
        account=account,
        role=role,
        warehouse=warehouse,
        database=database,
        schema=schema
    )
    return conn

    
bucket_name = "s3-biz-igg-lon-dev-incomming"
output_bucket = "s3-biz-igg-lon-dev-processed"
stage_name = 'STG_ICE_MARKET_CURVE'

# Specify the key (filename) you want to download from the S3 bucket
file_key = "23-10-27 Biztory Extended Dataset Example/ICE_MarketCurve/DataX_FX_Spot_Forward_2023-12-04_1700LON_2023-12-04_170201LON.csv"

# Specify the local file path where you want to save the downloaded file
local_file_path = f"tmp/{file_key}"
os.makedirs(os.path.dirname(local_file_path), exist_ok=True)

s3_client = boto3.client('s3')
s3_client.download_file(output_bucket,file_key,local_file_path)
print("File downloaded from S3 successfully.")

snowflake_schema = find_table_and_pattern(schema_table_file_dict=schema_table_file_dict,file_name=file_key)[0]
snowflake_table = find_table_and_pattern(schema_table_file_dict=schema_table_file_dict,file_name=file_key)[1]
snowflake_file_format = find_table_and_pattern(schema_table_file_dict=schema_table_file_dict,file_name=file_key)[2]

conn = connect_to_snowflake(user=os.environ.get("SNOWFLAKE_USER"),
                                password=os.environ.get("SNOWFLAKE_PASSWORD"),
                                account=os.environ.get("SNOWFLAKE_ACCOUNT"),
                                role=os.environ.get("SNOWFLAKE_ROLE"),
                                warehouse=os.environ.get("SNOWFLAKE_WAREHOUSE"),
                                database=os.environ.get("SNOWFLAKE_DATABASE"),
                                schema=os.environ.get("SNOWFLAKE_SCHEMA"))

cur = conn.cursor()

cur.execute(f"USE WAREHOUSE {os.environ['SNOWFLAKE_WAREHOUSE']};")

cur.execute(f"USE {os.environ['SNOWFLAKE_DATABASE']}.{os.environ['SNOWFLAKE_SCHEMA']};")
print("Connected to Snowflake successfully.")

# Upload file to Snowflake stage
query = f"CREATE OR REPLACE STAGE stg_market_curve \
STORAGE_INTEGRATION = S3_INTEGRATION \
URL = 's3://s3-biz-igg-lon-dev-processed/23-10-27 Biztory Extended Dataset Example/ICE_MarketCurve/' \
FILE_FORMAT = csv_format \
DIRECTORY = ( ENABLE = true AUTO_REFRESH = true );" 

cur.execute(query)


print("File uploaded to Snowflake stage successfully.")

#Copy data into Snowflake table

cur.execute(f"COPY INTO {snowflake_table} FROM '@stg_market_curve'\
FILE_FORMAT = csv_format \
PATTERN = '{snowflake_file_format}';")

print(f"Data copied into Snowflake table successfully for files {file_key}")


'''
TODO: Function to map schema/tables to filenames in dictionary
TODO: Iterate through files to append to snowflake
TODO: Regex for filename mapping to schema/table
TODO: skip file if table/schema not found
'''


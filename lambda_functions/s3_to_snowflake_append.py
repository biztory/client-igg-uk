from openpyxl import load_workbook
import os
from dotenv import load_dotenv
import snowflake.connector
from botocore.exceptions import NoCredentialsError, ClientError
from snowflake.connector.errors import DatabaseError, ProgrammingError
import logging

# Configure logging
logging.basicConfig(filename='script.log', level=logging.INFO)

# Load environment variables from .env file
load_dotenv()

def find_values(file_name, data_mapping):
    try:

        for stage,table in data_mapping.items():
            if os.path.dirname(file_name).split('/')[-1] in table:
                for values in table.keys():
                    FolderName = values
                for files,formats in table.items():
                    for vals,keys in formats.items():
                        for names,file_format in keys.items():
                            if names in os.path.basename(file_key).upper():
                                # print(f"Schema_Name: {vals}")
                                # print(f"File_Format_Name: '{file_format}'")
                                # print(f"Table_Name: {names}")
                                return vals,file_format,names,FolderName,stage
            else:
                logging.error(f"This schema does not exist in the current dictionary please add or check the name for file: {file_key}")
            # print(f"Folder_Name: {FolderName}")
            # print(f"Stage_Name: {stage}")
                                
    except Exception as e:
        logging.error(f"An error occurred: {str(e)}")

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

def snowflake_requirements(cur,WAREHOUSE,DATABASE,SCHEMA):
    try:
        cur.execute(f"USE WAREHOUSE {WAREHOUSE};")
        cur.execute(f"USE {DATABASE}.{SCHEMA};")
        print("Connected to Snowflake successfully.")
    except Exception as e:
        logging.error(f"An error occurred when trying to connect to snowflake. please check : {str(e)}")

'''
TODO: not sure if we need the stage and if we need to rerun it everytime when an updated files comes in but it is here for now
'''
# Upload file to Snowflake stage
# query = f"CREATE OR REPLACE STAGE {snowflake_stage} \
# STORAGE_INTEGRATION = S3_INTEGRATION \
# URL = 's3://{os.environ['S3_BUCKET_NAME']}/{os.path.dirname(file_key)}' \
# FILE_FORMAT = csv_format \
# DIRECTORY = ( ENABLE = true AUTO_REFRESH = true );" 

# cur.execute(query)

# print("File uploaded to Snowflake stage successfully.")

#Copy data into Snowflake table

def copy_execute(snowflake_table,snowflake_stage,snowflake_file_format,cur):
    try:
        cur.execute(f"COPY INTO {snowflake_table} FROM '@{snowflake_stage}'\
        FILE_FORMAT = csv_format \
        PATTERN = '{snowflake_file_format}';")
        print(f"Data copied into Snowflake table successfully for files {file_key}")
    except Exception as e:
        logging.error(f"There is an error in the copy_execute statement: {str(e)}")


data_mapping = { 'STG_MARKET_CURVE': {
    'ICE_MarketCurve': {
        'ICE_MARKET_CURVE': {
            'CURVEOIS': '.*CurveOIS.*',
            'CURVEXCCY': '.*CurveXCCY.*',
            'CURVEYC': '.*CurveYC.*',
            'CURVEZC': '.*CurveZC.*',
            'SPOT_FORWARD': '.*Spot_Forward.*'
            }
        }
    }
}

file_key = "23-10-27 Biztory Extended Dataset Example/ICE_MarketCurve/DataX_FX_Spot_Forward_2023-12-04_1700LON_2023-12-04_170201LON.csv"


snowflake_schema = find_values(file_key, data_mapping)[0]
snowflake_table = find_values(file_key, data_mapping)[2]
snowflake_file_format = find_values(file_key, data_mapping)[1]
snowflake_stage = find_values(file_key, data_mapping)[4]


conn = connect_to_snowflake(user=os.environ.get("SNOWFLAKE_USER"),
                                password=os.environ.get("SNOWFLAKE_PASSWORD"),
                                account=os.environ.get("SNOWFLAKE_ACCOUNT"),
                                role=os.environ.get("SNOWFLAKE_ROLE"),
                                warehouse=os.environ.get("SNOWFLAKE_WAREHOUSE"),
                                database=os.environ.get("SNOWFLAKE_DATABASE"),
                                schema=os.environ.get("SNOWFLAKE_SCHEMA"))

cur = conn.cursor()

snowflake_requirements(cur=cur,WAREHOUSE=os.environ.get("SNOWFLAKE_WAREHOUSE"),DATABASE=os.environ.get("SNOWFLAKE_DATABASE"),SCHEMA=os.environ.get("SNOWFLAKE_SCHEMA"))

copy_execute(snowflake_table=snowflake_table,snowflake_stage=snowflake_stage,snowflake_file_format=snowflake_file_format,cur=cur    )



'''
TODO: Function to map schema/tables to filenames in dictionary
TODO: Iterate through files to append to snowflake
TODO: Regex for filename mapping to schema/table
TODO: skip file if table/schema not found
'''


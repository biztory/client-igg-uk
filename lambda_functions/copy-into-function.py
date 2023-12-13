import os
import boto3
import snowflake
import snowflake.connector
from botocore.exceptions import NoCredentialsError, ClientError
from snowflake.connector.errors import DatabaseError, ProgrammingError
import urllib

schema_table_file_dict = {'ICE_MARKET_CURVE':
    {'CURVEOIS':'.*CurveOIS.*'
    ,'CURVEXCCY':'.*CurveXCCY.*'
    ,'CURVEYC':'.*CurveYC.*'
    ,'CURVEZC':'.*CurveZC.*'
    ,'SPOT_FORWARD':'*Spot_Forward.*'}}
    
    
def find_table_and_pattern(file_name, schema_table_file_dict):
    for schema, tables in schema_table_file_dict.items():
        for table, pattern in tables.items():
            if pattern and pattern.replace('*','').replace('.','') in file_name:
                return schema, table, pattern
    return None, None, None


def lambda_handler(event, context):
    # AWS S3 and Snowflake configuration from environment variables
    
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    file_key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    
    stage_name = os.environ['STAGE_NAME']
    
    snowflake_schema = find_table_and_pattern(schema_table_file_dict=schema_table_file_dict,file_name=file_key)[0]
    snowflake_table = find_table_and_pattern(schema_table_file_dict=schema_table_file_dict,file_name=file_key)[1]
    snowflake_file_format = find_table_and_pattern(schema_table_file_dict=schema_table_file_dict,file_name=file_key)[2]
    try:
        # Connect to S3 and download file
        s3_client = boto3.client('s3')
        s3_client.download_file(bucket_name, file_key, '/tmp/' + file_key)
        print("File downloaded from S3 successfully.")

        # Connect to Snowflake
        conn = snowflake.connector.connect(
            user=os.environ['SNOWFLAKE_USER'],
            password=os.environ['SNOWFLAKE_PASSWORD'],
            account=os.environ['SNOWFLAKE_ACCOUNT']
        )
        cur = conn.cursor()
        cur.execute(f"USE WAREHOUSE {os.environ['WAREHOUSE']}")
        cur.execute(f"USE {os.environ['DATABASE']}.{snowflake_schema}")
        print("Connected to Snowflake successfully.")

        # Upload file to Snowflake stage
        cur.execute(f"PUT file:///tmp/{file_key} @~/{stage_name}")
        print("File uploaded to Snowflake stage successfully.")

        # Copy data into Snowflake table
        cur.execute(f"COPY INTO {snowflake_table} FROM @~/{stage_name}/{file_key}\
        FILE_FORMAT = csv_format\
        PATTERN = {snowflake_file_format}")
        print("Data copied into Snowflake table successfully.")

    except (NoCredentialsError, ClientError, DatabaseError, ProgrammingError) as e:
        print(f"Error: {e}")
        return {
            'statusCode': 500,
            'body': str(e)
        }
    finally:
        if 'cur' in locals():
            cur.close()
        if 'conn' in locals() and conn.is_connected():
            conn.close()
            print("Snowflake connection closed.")

    return {
        'statusCode': 200,
        'body': 'Data processing completed successfully.'
    }

import boto3
import os
import io
import datetime
import pandas as pd
from openpyxl import load_workbook
import numpy as np
import json


def cubed_data_biodiv():
    """
    This function lists all files in a folder from an S3 bucket, processes them, and uploads the results.
    """
    s3_client = boto3.client("s3")
    bucket_name = "s3-biz-igg-dev-incomming"
    output_bucket = "s3-biz-igg-dev-processed"
    response = s3_client.list_objects_v2(Bucket=bucket_name, Prefix="23-10-27 Biztory Extended Dataset Example/Impact_Cubed_ESG/")
    files_in_subfolder = response.get("Contents")

    for file in files_in_subfolder:
        if 'xlsx' in file['Key']:
            response = s3_client.get_object(Bucket=bucket_name, Key=file['Key'])
            excel_file = response['Body'].read()
            # Load the Excel workbook using openpyxl
            # workbook = load_workbook(io.BytesIO(excel_file), data_only=True)
            
            if "Biodiversity" in file['Key']:
                try:
                    df = pd.read_excel(io.BytesIO(excel_file), header=[0,1,2],sheet_name='Data')
                    
                    df.columns = [df.columns.get_level_values(i).astype(str) for i in range(len(df.columns.levels))]
                    df.columns = df.columns.map(' | '.join).str.strip('|')
                    regex_pattern = r'Unnamed:\s(\d+)_level_\d+ \|'
                    df.columns = df.columns.str.replace(regex_pattern, '',regex=True)
                    
                    print(f"Processed file: {file['Key']}")
                except Exception as e:
                    print(f"Error processing file: {file['Key']}, Error: {str(e)}")
                    
            elif "Company_Level_Climate" in file['Key']:
                try:
                    df = pd.read_excel(io.BytesIO(excel_file), header=[0,1,2],sheet_name='Datafeed')
                    
                    df.columns = [df.columns.get_level_values(i).astype(str) for i in range(len(df.columns.levels))]
                    df.columns = df.columns.map(' | '.join).str.strip('|')
                    regex_pattern = r'Unnamed:\s(\d+)_level_\d+ \|'
                    df.columns = df.columns.str.replace(regex_pattern, '',regex=True)
                    
                    print(f"Processed file: {file['Key']}")
                except Exception as e:
                    print(f"Error processing file: {file['Key']}, Error: {str(e)}")
            
            else:
                try:
                    df = pd.read_excel(io.BytesIO(excel_file), header=0) 
                    print(f"Processed file: {file['Key']}")
                except Exception as e:
                    print(f"Error processing file: {file['Key']}, Error: {str(e)}")
                    
            df['File Name'] = os.path.basename(file['Key'])
            df['Folder Name'] = os.path.dirname(file['Key'])
            df['AWS_Timestamp'] = datetime.datetime.now()
            
            csv_buffer = io.StringIO()
            df.to_csv(csv_buffer, index=True)
                
            # Create the S3 key for the output file
            csv_name = f"{os.path.basename(file['Key']).replace('.xlsx', '.csv')}"
            s3_key = f"{os.path.dirname(file['Key'])}/{csv_name}"
            
            # Upload the processed CSV to the output bucket
            s3_client.put_object(Bucket=output_bucket, Key=s3_key, Body=csv_buffer.getvalue())
                
    # except Exception as e:
    #     print(f"Error listing objects in the bucket: {str(e)}")

def lambda_handler(event, context):
    try:
        cubed_data_biodiv()
        return {
            'statusCode': 200,
            'body': json.dumps('Success')
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f'Error: {str(e)}')
        }


import boto3
import os
import io
import datetime
from openpyxl import load_workbook
import pandas as pd
import json

def list_s3_files_in_folder_using_client(bucket_name, output_bucket):
    """
    This function lists down all files in a folder from an S3 bucket, processes them, and stores the results in the output bucket.
    
    :param bucket_name: The source S3 bucket name.
    :param output_bucket: The output S3 bucket name.
    """
    s3_client = boto3.client("s3")
    
    try:
        response = s3_client.list_objects_v2(Bucket=bucket_name)
        files = response.get("Contents")
    except Exception as e:
        print(f"Error listing objects in {bucket_name}: {str(e)}")
        return
    
    sub_folders = set()
    
    for file in files:
        if "fund_duration" in file["Key"]:
            subfolder = os.path.dirname(file["Key"])
            sub_folders.add(subfolder)

    for subfolder in sub_folders:
        try:
            response = s3_client.list_objects_v2(Bucket=bucket_name, Prefix=f"{subfolder}/")
            files_in_subfolder = response.get("Contents")
        except Exception as e:
            print(f"Error listing objects in subfolder {subfolder}: {str(e)}")
            continue
        
        for file in files_in_subfolder:
            if "fund_duration" in file["Key"]:
                process_excel_file(s3_client, bucket_name, output_bucket, file)

def process_excel_file(s3_client, bucket_name, output_bucket, file):
    """
    This function processes an Excel file from S3, converts it to CSV, and uploads the CSV to the output bucket.
    
    :param s3_client: Boto3 S3 client.
    :param bucket_name: The source S3 bucket name.
    :param output_bucket: The output S3 bucket name.
    :param file: The S3 file to process.
    """
    file_key = file["Key"]
    try:
        response = s3_client.get_object(Bucket=bucket_name, Key=file_key)
        excel_file = response['Body'].read()
    except Exception as e:
        print(f"Error getting object {file_key}: {str(e)}")
        return
    
    workbook = load_workbook(io.BytesIO(excel_file), data_only=True)
    
    df = pd.read_excel(io.BytesIO(excel_file), skiprows=4, header=None, names=['Date', 'Data type', 'Fund code', 'Fund name', 'Type',
       'Unleveraged duration', 'Nominal duration', 'Inflation duration',
       'Next rebalancing ''trade'' date', 'Target duration', 'BAU min: Trigger',
       'BAU min: Required shock %', 'BAU min: Rebal per £1m',
       'BAU max: Trigger', 'BAU max: Required shock %',
       'BAU max: Rebal per £1m', 'Max: Trigger', 'Max: Required shock %',
       'Max: Rebal per £1m', 'Knock out: Trigger',
       'Knock out: Required shock %', 'Total resilience %'], skipfooter=18 )

    df['Type of fund'] = df.loc[df['Date'].str.contains('pooled funds', case=True, na=False), 'Date']
    df['Type of fund'].ffill(inplace=True)
    df = df[~df['Date'].str.contains('Date', case=True, na=False)]
    df = df[~df['Date'].str.contains('pooled fund', case=True, na=False)]
    df.dropna(subset=['Date'], inplace=True)
    df['File Name'] = os.path.basename(file["Key"])
    df['Folder Name'] = os.path.dirname(file["Key"])
    df['Company'] = 'Columbia Threadneedle'
    df['AWS Timestamp'] = datetime.datetime.utcnow()
    
    csv_buffer = io.StringIO()
    df.to_csv(csv_buffer, index=False)
    
    # Create the S3 key for the output file
    s3_key = f"processed/{os.path.basename(file_key).replace('.xlsx', '.csv')}"

    try:
        # Upload the processed CSV to the output bucket
        s3_client.put_object(Bucket=output_bucket, Key=s3_key, Body=csv_buffer.getvalue())
        print(f"Processed file: {file_key}, Output file: {s3_key}")
    except Exception as e:
        print(f"Error uploading processed file {s3_key}: {str(e)}")

def lambda_handler(event, context):
    bucket_name = "s3-biz-igg-dev-incomming"
    output_bucket = "s3-biz-igg-dev-processed"
    
    try:
        # Call the function to list S3 files and process them
        list_s3_files_in_folder_using_client(bucket_name, output_bucket)
        
        response = {
            "statusCode": 200,
            "body": "Processing completed successfully"
        }
    except Exception as e:
        response = {
            "statusCode": 500,
            "body": f"Processing failed: {str(e)}"
        }
    
    return response


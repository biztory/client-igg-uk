import boto3
import os
import io
import datetime
from openpyxl import load_workbook
import pandas as pd
import numpy as np

def list_s3_files_in_folder_using_client(bucket_name, output_bucket):
    try:
        s3_client = boto3.client("s3")
        response = s3_client.list_objects_v2(Bucket=bucket_name)
        files = response.get("Contents")

        sub_folders = set()

        for file in files:
            if "LDIAnalytics" in file["Key"]:
                subfolder = os.path.dirname(file["Key"])
                sub_folders.add(subfolder)

        for subfolder in sub_folders:
            response = s3_client.list_objects_v2(Bucket=bucket_name, Prefix=f"{subfolder}/")
            files_in_subfolder = response.get("Contents")

            for file in files_in_subfolder:
                if "LDIAnalytics" in file["Key"]:
                    file_key = file["Key"]

                    response = s3_client.get_object(Bucket=bucket_name, Key=file_key)
                    excel_file = response['Body'].read()

                    process_excel_file(excel_file, file_key, output_bucket)

    except Exception as e:
        print(f"An error occurred: {str(e)}")

def process_excel_file(excel_file, file_key, output_bucket):
    try:
        # Load the Excel workbook using openpyxl
        workbook = load_workbook(io.BytesIO(excel_file), data_only=True)

        # Read the worksheet into a DataFrame using pd.read_excel
        df = pd.read_excel(
            io.BytesIO(excel_file),
            skiprows=4,
            header=None,
            skipfooter=60,
            keep_default_na=False,
            names=['funds', 'Maturity', 'Term to maturity', 'Nominal rate',
                   'PV01 per £10,000 investment', 'Mid offer spread', 'Mid bid spread',
                   'Hedging multiple', 'Upper hedging multiple',
                   'Indicative rate movement to hit upper limit (bps)',
                   'Lower hedging multiple',
                   'Indicative rate movement to hit lower limit (bps)',
                   'Investment to return to optimal if upper limit hit',
                   'Investment to return to optimal if lower limit hit',
                   'Optimal hedging multiple', 'Optimal Duration',
                   'Distance to exhaustion (bps)']
        )

        df['Type of fund'] = df.loc[df['funds'].str.contains('fund', case=True, na=False), 'funds']
        df['Type of fund'].ffill(inplace=True)
        df = df[~df['funds'].str.contains('fund', case=True, na=False)]
        df.replace('', np.nan, inplace=True)
        df.dropna(subset=['funds'], inplace=True)
        df['File Name'] = os.path.basename(file_key)
        df['Folder Name'] = os.path.dirname(file_key)
        df['AWS_timestamp'] = datetime.datetime.now()

        # Prepare the processed data as a CSV
        csv_buffer = io.StringIO()
        df.to_csv(csv_buffer, index=False)

        # Create the S3 key for the output file
        s3_key = f"{os.path.dirname(file_key)}/{os.path.basename(file_key).replace('.xlsm', '.csv')}"

        # Upload the processed CSV to the output bucket
        s3_client = boto3.client("s3")
        s3_client.put_object(Bucket=output_bucket, Key=s3_key, Body=csv_buffer.getvalue())

        print(f"Processed file: {file_key}, Output file: {s3_key}")

    except Exception as e:
        print(f"An error occurred while processing the file {file_key}: {str(e)}")

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

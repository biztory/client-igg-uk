import boto3
import os
import io
import datetime
import pandas as pd
from openpyxl import load_workbook
import json

# Initialize the S3 client
s3_client = boto3.client("s3")

# Define the S3 bucket names
bucket_name = "s3-biz-igg-dev-incomming"
output_bucket = "s3-biz-igg-dev-processed"

def process_excel_file(file_key, subfolder):
    try:
        # Retrieve the Excel file from the source bucket
        response = s3_client.get_object(Bucket=bucket_name, Key=file_key)
        excel_file = response['Body'].read()

        # Load the Excel workbook using openpyxl
        workbook = load_workbook(io.BytesIO(excel_file), data_only=True)

        # Read the Excel data into a DataFrame
        df = pd.read_excel(io.BytesIO(excel_file), header=0, engine='openpyxl')

        # Add additional columns to the DataFrame
        df['File Name'] = os.path.basename(file_key)
        df['Folder Name'] = os.path.dirname(file_key)
        df['AWS_Timestamp'] = datetime.datetime.now()

        # Convert the DataFrame to CSV
        csv_buffer = io.StringIO()
        df.to_csv(csv_buffer, index=False)

        # Create the S3 key for the output file
        csv_name = f"{os.path.basename(file_key).replace('.xlsx', '.csv')}"
        s3_key = f"{subfolder}/{csv_name}"

        # Upload the processed CSV to the output bucket
        s3_client.put_object(Bucket=output_bucket, Key=s3_key, Body=csv_buffer.getvalue())

        print(f"Processed file: {file_key}, Output file: {s3_key}")
    except Exception as e:
        print(f"Error processing file: {file_key}, Error: {str(e)}")

def single_index_xlsx_files():
    try:
        # List objects in the source bucket
        response = s3_client.list_objects_v2(Bucket=bucket_name)
        files = response.get("Contents")

        sub_folders = set()

        for file in files:
            file_key = file["Key"]
            
            # Check if the file key contains specific substrings
            if "Search" in file_key or "Scheme_Holdings" in file_key or "R_IGG" in file_key:
                print(f"Processing file: {file_key}")
                subfolder = os.path.dirname(file_key)
                sub_folders.add(subfolder)

        for subfolder in sub_folders:
            # List objects in the subfolder
            response = s3_client.list_objects_v2(Bucket=bucket_name, Prefix=f"{subfolder}/")
            files_in_subfolder = response.get("Contents")

            for file in files_in_subfolder:
                file_key = file["Key"]
                
                # Check if the file key contains specific substrings
                if "Search" in file_key or "Scheme_Holdings" in file_key or "R_IGG" in file_key:
                    process_excel_file(file_key, subfolder)

    except Exception as e:
        print(f"Error listing objects in the bucket: {str(e)}")

def lambda_handler(event, context):
    try:
        single_index_xlsx_files()
        return {
            'statusCode': 200,
            'body': json.dumps('Success')
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f'Error: {str(e)}')
        }

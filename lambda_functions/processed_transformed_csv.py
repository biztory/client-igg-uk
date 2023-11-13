import boto3
import os
import io
import datetime
from openpyxl import load_workbook
import pandas as pd

s3_client = boto3.client("s3")
bucket_name = "s3-biz-igg-dev-incomming"
output_bucket = "s3-biz-igg-dev-processed"


def list_csv_files(bucket_name):
    """
    Lists all CSV files in a bucket.
    """
    try:
        response = s3_client.list_objects_v2(Bucket=bucket_name)
        return response.get("Contents")
    except Exception as e:
        print(f"Error listing objects: {str(e)}")
        return []


def process_csv_file(file):
    """
    Processes a CSV file and converts it to a DataFrame.
    """
    try:
        file_key = file["Key"]
        response = s3_client.get_object(Bucket=bucket_name, Key=file_key)
        excel_file = response['Body'].read()

        if "PMA" not in file_key and "PFA" not in file_key and '.csv' in file_key and "Framework" not in os.path.dirname(
                file_key) and "DataX_FX_Spot_Forward" not in file_key:
            df = pd.read_csv(io.BytesIO(excel_file), header=0)
        elif "Framework" in os.path.dirname(file_key):
            df = pd.read_csv(io.BytesIO(excel_file), header=None, names=['level', 'basis points resilience'])
        elif "PMA" in file_key and "PFA" in file_key:
            df = pd.read_csv(io.BytesIO(excel_file), header=[0, 1, 2])

            Effective_Date = df.columns.get_level_values(0)[1]
            Year = df.columns.get_level_values(1)[1]

            Effective_Date_name = df.columns.get_level_values(0)[0]
            Year_name = df.columns.get_level_values(1)[0]

            df.columns = df.columns.droplevel(0)
            df.columns = df.columns.droplevel(0)

            df['Effective_Date'] = Effective_Date
            df['Year'] = Year
        elif "DataX_FX_Spot_Forward" in file_key:
            df = pd.read_csv(io.BytesIO(excel_file), header=2)
        else:
            return None

        df['File Name'] = os.path.basename(file_key)
        df['Folder Name'] = os.path.dirname(file_key)
        df['AWS_Timestamp'] = datetime.datetime.now()
        df.index.name = 'Key'

        return df
    except Exception as e:
        print(f"Error processing file: {file_key}, {str(e)}")
        return None


def upload_csv_to_s3(dataframe, file_key):
    """
    Uploads a DataFrame as a CSV to the output bucket.
    """
    try:
        # Convert the processed data to a CSV string
        csv_data = dataframe.to_csv(index=True)

        # Create the S3 key for the output file with a .csv extension
        s3_key = f"{os.path.dirname(file_key)}/{os.path.basename(file_key)}"

        # Upload the processed CSV data to the output bucket
        s3_client.put_object(Bucket=output_bucket, Key=s3_key, Body=csv_data)

        print(f"Processed file: {file_key}, Output file: {s3_key}")
    except Exception as e:
        print(f"Error uploading CSV to S3: {str(e)}")


def process_and_upload_files(files):
    """
    Processes and uploads CSV files from the input list.
    """
    for file in files:
        dataframe = process_csv_file(file)
        if dataframe is not None:
            upload_csv_to_s3(dataframe, file["Key"])


def lambda_handler(event, context):
    
    try:
        # List all CSV files in the input bucket
        files = list_csv_files(bucket_name)

        # Process and upload CSV files
        process_and_upload_files(files)

        return {
            "statusCode": 200,
            "body": "Processing completed"
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": f"Error: {str(e)}"
        }

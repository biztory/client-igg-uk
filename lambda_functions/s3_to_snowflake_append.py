import boto3
import os
import io
import datetime
from openpyxl import load_workbook
import pandas as pd


s3_client = boto3.client("s3")
bucket_name = "s3-biz-igg-dev-incomming"
output_bucket = "s3-biz-igg-dev-processed"

def fetch_data_from_s3(bucket_name):
    # recursive search for all files in bucket and return dict of file names and full paths
    response = s3_client.list_objects_v2(Bucket=bucket_name)
    files = response.get("Contents")
    file_dict = {}
    for file in files:
        file_key = file["Key"]
        file_dict[file_key] = f"s3://{bucket_name}/{file_key}"
    return file_dict

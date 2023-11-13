import os
import boto3
import sys
import json

def lambda_handler(event, context):
    # Define the environment variables you want to retrieve
    env_vars_to_retrieve = ["BUCKET_INCOMMING", "BUCKET_PROCESSED"]

    # Iterate through the specified environment variables and print their values
    for env_var_name in env_vars_to_retrieve:
        env_var_value = os.environ.get(env_var_name)
        if env_var_value is not None:
            print(f"Environment Variable: {env_var_name} = {env_var_value}")
        else:
            print(f"Environment Variable {env_var_name} not found.")

    # Print the Python version
    print(f"Python Version: {sys.version}")

    # Print the incoming event
    print("Incoming Event:")
    print(json.dumps(event, indent=2))

    # Initialize the S3 client
    s3 = boto3.client('s3')

    # Define the source and destination buckets
    source_bucket = event['Records'][0]['s3']['bucket']['name']
    destination_bucket = os.environ.get('BUCKET_PROCESSED')

    # Get the S3 object key from the event
    object_key = event['Records'][0]['s3']['object']['key']

    try:
        # Download the object from the source bucket
        response = s3.get_object(Bucket=source_bucket, Key=object_key)
        file_content = response['Body'].read()

        # Upload the object to the destination bucket
        s3.put_object(Bucket=destination_bucket, Key=object_key, Body=file_content)

        print(f"File {object_key} downloaded from {source_bucket} and uploaded to {destination_bucket}")
    except Exception as e:
        print(f"Error downloading and uploading file: {str(e)}")

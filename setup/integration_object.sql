use role accountadmin;
use database igg_source;
use warehouse INGEST_WH;

create or replace STORAGE INTEGRATION S3_INT
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = 'S3'
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::400693409844:role/snowflake'
STORAGE_ALLOWED_LOCATIONS = ('s3://s3-biz-igg-lon-dev-processed/23-10-27 Biztory Extended Dataset Example/')
COMMENT = 'integration stage for all processed files in S3';

desc integration S3_INT;

show integrations;

grant usage ON integration s3_int to ROLE SYSADMIN;

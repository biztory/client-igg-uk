
use role accountadmin;
use database igg_source;
use schema bloomberg_bond;
use warehouse compute_wh;

create or replace STORAGE INTEGRATION S3_INTERGRATION
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = 'S3'
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::400693409844:role/snowflake'
STORAGE_ALLOWED_LOCATIONS = ('s3://s3-biz-igg-dev-processed/23-10-27 Biztory Extended Dataset Example/');

desc integration S3_INTERGRATION;
-- arn + external id need to be added to snowflake role policy in AWS


GRANT CREATE STAGE ON SCHEMA IGG_SOURCE_DEV.BLOOMBERG_BOND TO ROLE sysadmin;

GRANT USAGE ON INTEGRATION S3_INTERGRATION TO ROLE sysadmin;
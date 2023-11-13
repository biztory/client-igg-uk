use role accountadmin;

create or replace STORAGE INTEGRATION S3_INTERGRATION
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = 'S3'
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::400693409844:role/snowflake'
STORAGE_ALLOWED_LOCATIONS = ('s3://s3-biz-igg-dev-processed/23-10-27 Biztory Extended Dataset Example/');

desc integration S3_INTERGRATION;


-- arn + external id need to be added to snowflake role policy in AWS
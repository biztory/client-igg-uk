use sysadmin;
USE SCHEMA igg_source.ldi_blackrock;
USE WAREHOUSE INGEST_WH;

CREATE OR REPLACE STAGE stg_blackrock
  STORAGE_INTEGRATION = S3_INT
  URL = 's3://s3-biz-igg-lon-dev-processed/23-10-27 Biztory Extended Dataset Example/LDI-BlackRock/'
  FILE_FORMAT = csv_format
  DIRECTORY = ( ENABLE = true AUTO_REFRESH = true );

      LIST '@stg_blackrock';



COPY INTO blackrock_framework
FROM '@stg_blackrock'
FILE_FORMAT = csv_format
PATTERN = '.*Framework.*';

COPY INTO blackrock_weekly_report
FROM '@stg_blackrock'
FILE_FORMAT = csv_format
PATTERN = '.*LMF_and_Profile_Funds_Weekly_Report.*';


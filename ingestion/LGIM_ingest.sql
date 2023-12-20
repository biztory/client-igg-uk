use sysadmin;
USE SCHEMA igg_source.LDI_LGIM;
USE WAREHOUSE INGEST_WH;



CREATE OR REPLACE STAGE stg_lgim
  STORAGE_INTEGRATION = S3_INT
  URL = 's3://s3-biz-igg-lon-dev-processed/23-10-27 Biztory Extended Dataset Example/LDI-LGIM/'
  FILE_FORMAT = csv_format
  DIRECTORY = ( ENABLE = true AUTO_REFRESH = true );

      LIST '@stg_lgim';


      
COPY INTO LDI_ANALYTICS
FROM '@stg_lgim'
FILE_FORMAT = csv_format
PATTERN = '.*LDIAnalytics.*';

COPY INTO LGIM_LDI_FUND_CHARACTERISTICS
FROM '@stg_lgim'
FILE_FORMAT = csv_format
PATTERN = '.*Fund Collateral.*';


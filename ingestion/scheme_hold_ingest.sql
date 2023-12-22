use sysadmin;
USE SCHEMA igg_source.scheme_holdings;
USE WAREHOUSE INGEST_WH;


CREATE OR REPLACE STAGE stg_scheme_characteristics
  STORAGE_INTEGRATION = S3_INT
  URL = 's3://s3-biz-igg-lon-dev-processed/23-10-27 Biztory Extended Dataset Example/IGG_SchemeCharacteristics/'
  FILE_FORMAT = csv_format
  DIRECTORY = ( ENABLE = true AUTO_REFRESH = true );

      LIST '@stg_scheme_holdings';

COPY INTO scheme_holdings
FROM '@stg_scheme_holdings'
FILE_FORMAT = csv_format
PATTERN = '.*R_IGG- Client.*'
;


use sysadmin;
USE SCHEMA igg_source.bloomberg_equity;
USE WAREHOUSE INGEST_WH;

CREATE OR REPLACE STAGE stg_bloomberg_equity
  STORAGE_INTEGRATION = S3_INT
  URL = 's3://s3-biz-igg-lon-dev-processed/23-10-27 Biztory Extended Dataset Example/Bloomberg_Equity' 
  FILE_FORMAT = csv_format
  DIRECTORY = ( ENABLE = true AUTO_REFRESH = true );


    LIST '@stg_bloomberg_equity';

 --  ' s3://s3-biz-igg-dev-processed/23-10-27 Biztory Extended Dataset Example/Bloomberg_Bond/20230831_10371_17681_index.csv'


COPY INTO bloomberg_holdings_close
FROM '@stg_bloomberg_equity'
FILE_FORMAT = csv_format
PATTERN = '.*HoldingsClose.csv';

COPY INTO bloomberg_holdings_open
FROM '@stg_bloomberg_equity'
FILE_FORMAT = csv_format
PATTERN = '.*HoldingsOpen.csv';

COPY INTO bloomberg_holdings_delta
FROM '@stg_bloomberg_equity'
FILE_FORMAT = csv_format
PATTERN = '.*HoldingsDelta.csv';

COPY INTO bloomberg_index_events
FROM '@stg_bloomberg_equity'
FILE_FORMAT = csv_format
PATTERN = '.*IndexEvents.csv';

COPY INTO bloomberg_levels_open
FROM '@stg_bloomberg_equity'
FILE_FORMAT = csv_format
PATTERN = '.*LevelsOpen.csv';

COPY INTO bloomberg_levels_close
FROM '@stg_bloomberg_equity'
FILE_FORMAT = csv_format
PATTERN = '.*LevelsClose.csv';

select * from bloomberg_levels_close LIMIT 4;


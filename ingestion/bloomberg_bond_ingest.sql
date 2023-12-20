use role SYSADMIN;
USE SCHEMA igg_source.bloomberg_bond;
USE WAREHOUSE INGEST_WH;

CREATE OR REPLACE STAGE stg_bloomberg_bond
  STORAGE_INTEGRATION = S3_INT
  URL = 's3://s3-biz-igg-lon-dev-processed/23-10-27 Biztory Extended Dataset Example/Bloomberg_Bond/' 
  FILE_FORMAT = csv_format
  DIRECTORY = ( ENABLE = true AUTO_REFRESH = true );

describe integration s3_int; 



    LIST '@stg_bloomberg_bond';

 --  ' s3://s3-biz-igg-dev-processed/23-10-27 Biztory Extended Dataset Example/Bloomberg_Bond/20230831_10371_17681_index.csv'


COPY INTO bloomberg_index
FROM '@stg_bloomberg_bond'
FILE_FORMAT = csv_format
PATTERN = '.*index.csv';

COPY INTO bloomberg_bonds
FROM '@stg_bloomberg_bond'
FILE_FORMAT = csv_format
PATTERN = '.*bond.csv';

COPY INTO bloomberg_map
FROM '@stg_bloomberg_bond'
FILE_FORMAT = csv_format
PATTERN = '.*map.csv';

select * from bloomberg_index;


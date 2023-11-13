use sysadmin;

USE SCHEMA igg_source_dev.bloomberg_bond;

CREATE OR REPLACE STAGE stg_bloomberg_bond
  STORAGE_INTEGRATION = S3_INTERGRATION
  URL = 's3://s3-biz-igg-dev-processed/23-10-27 Biztory Extended Dataset Example/Bloomberg_Bond/' 
  FILE_FORMAT = csv_format
  DIRECTORY = ( ENABLE = true AUTO_REFRESH = true );


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


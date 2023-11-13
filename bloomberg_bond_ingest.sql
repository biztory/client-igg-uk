use sysadmin;
use warehouse compute_wh;
use database igg_source_dev;
use schema bloomberg_bond;

CREATE STAGE stg_bloomberg_bond 
	URL = 's3://s3-biz-igg-dev-processed/23-10-27 Biztory Extended Dataset Example/Bloomberg_Bond/' 
	STORAGE_INTEGRATION = S3_INTERGRATION 
	DIRECTORY = ( ENABLE = true AUTO_REFRESH = true );


    LIST '@stg_bloomberg_bond';

 --  ' s3://s3-biz-igg-dev-processed/23-10-27 Biztory Extended Dataset Example/Bloomberg_Bond/20230831_10371_17681_index.csv'

COPY INTO bloomberg_index
FROM '@stg_bloomberg_bond'
FILE_FORMAT = csv_format
PATTERN = '%index.csv';


select * from bloomberg_index;
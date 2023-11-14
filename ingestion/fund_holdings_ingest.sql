
CREATE OR REPLACE STAGE stg_fundholdings
  STORAGE_INTEGRATION = S3_INTERGRATION
  URL = 's3://s3-biz-igg-dev-processed/23-10-27 Biztory Extended Dataset Example/FundHoldings' 
  FILE_FORMAT = csv_format
  DIRECTORY = ( ENABLE = true AUTO_REFRESH = true );


    LIST '@stg_fundholdings';

 --  ' s3://s3-biz-igg-dev-processed/23-10-27 Biztory Extended Dataset Example/Bloomberg_Bond/20230831_10371_17681_index.csv'


COPY INTO fund_holdings
FROM '@stg_fundholdings'
FILE_FORMAT = csv_format
;
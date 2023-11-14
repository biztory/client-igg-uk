


CREATE OR REPLACE STAGE stg_scheme_holdings
  STORAGE_INTEGRATION = S3_INTERGRATION
  URL = 's3://s3-biz-igg-dev-processed/23-10-27 Biztory Extended Dataset Example/SchemeHoldings/'
  FILE_FORMAT = csv_format
  DIRECTORY = ( ENABLE = true AUTO_REFRESH = true );

      LIST '@stg_scheme_holdings';

COPY INTO scheme_holdings
FROM '@stg_scheme_holdings'
FILE_FORMAT = csv_format
;

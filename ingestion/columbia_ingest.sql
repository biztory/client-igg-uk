
CREATE OR REPLACE STAGE stg_columbia
  STORAGE_INTEGRATION = S3_INTERGRATION
  URL = 's3://s3-biz-igg-dev-processed/23-10-27 Biztory Extended Dataset Example/LDI-Columbia_Threadneedle/'
  FILE_FORMAT = csv_format
  DIRECTORY = ( ENABLE = true AUTO_REFRESH = true );

      LIST '@stg_columbia';



COPY INTO LDI_FUND_CHARACTERISTICS
FROM '@stg_columbia'
FILE_FORMAT = csv_format
PATTERN = '.*fund_durations.*';
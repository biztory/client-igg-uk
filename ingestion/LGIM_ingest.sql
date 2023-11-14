CREATE OR REPLACE STAGE stg_lgim
  STORAGE_INTEGRATION = S3_INTERGRATION
  URL = 's3://s3-biz-igg-dev-processed/23-10-27 Biztory Extended Dataset Example/LDI-LGIM/'
  FILE_FORMAT = csv_format
  DIRECTORY = ( ENABLE = true AUTO_REFRESH = true );

      LIST '@stg_lgim';


      
COPY INTO Mortality_Base
FROM '@stg_lgim'
FILE_FORMAT = csv_format
PATTERN = '.*Mortality_Base.*';

COPY INTO LDI_FUND_CHARACTERISTICS
FROM '@stg_lgim'
FILE_FORMAT = csv_format
PATTERN = '.*Mortality_Base.*';


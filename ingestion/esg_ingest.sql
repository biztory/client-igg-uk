
CREATE OR REPLACE STAGE stg_esg
  STORAGE_INTEGRATION = S3_INTERGRATION
  URL = 's3://s3-biz-igg-dev-processed/23-10-27 Biztory Extended Dataset Example/Impact_Cubed_ESG/'
  FILE_FORMAT = csv_format
  DIRECTORY = ( ENABLE = true AUTO_REFRESH = true );

      LIST '@stg_esg';

COPY INTO country_code
FROM '@stg_esg'
FILE_FORMAT = csv_format
PATTERN = '.*CountryCode.*';

COPY INTO biodiversity
FROM '@stg_esg'
FILE_FORMAT = csv_format
PATTERN = '.*Biodiversity.*';

COPY INTO climate
FROM '@stg_esg'
FILE_FORMAT = csv_format
PATTERN = '.*Climate.*';

COPY INTO sovereign
FROM '@stg_esg'
FILE_FORMAT = csv_format
PATTERN = '.*Sovereign.*';
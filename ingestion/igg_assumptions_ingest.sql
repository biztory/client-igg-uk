
CREATE OR REPLACE STAGE stg_igg_assumptions
  STORAGE_INTEGRATION = S3_INTERGRATION
  URL = 's3://s3-biz-igg-dev-processed/23-10-27 Biztory Extended Dataset Example/IGG_Assumptions/'
  FILE_FORMAT = csv_format
  DIRECTORY = ( ENABLE = true AUTO_REFRESH = true );

      LIST '@stg_igg_assumptions';

COPY INTO liability_basis
FROM '@stg_igg_assumptions'
FILE_FORMAT = csv_format
PATTERN = '.*Liability_Basis.*';

COPY INTO commutation_factors
FROM '@stg_igg_assumptions'
FILE_FORMAT = csv_format
PATTERN = '.*Commutation_Factors.*';

COPY INTO early_late_factors
FROM '@stg_igg_assumptions'
FILE_FORMAT = csv_format
PATTERN = '.*Early_Late_Factors.*';
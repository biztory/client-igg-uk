


CREATE OR REPLACE STAGE stg_gen_assumption
  STORAGE_INTEGRATION = S3_INTEGRATION
  URL = 's3://s3-biz-igg-lon-dev-processed/23-10-27 Biztory Extended Dataset Example/IGG_GeneralAssumptionTables/'
  FILE_FORMAT = csv_format
  DIRECTORY = ( ENABLE = true AUTO_REFRESH = true );

      LIST '@stg_gen_assumption';

COPY INTO mortality_improvement
FROM '@stg_gen_assumption'
FILE_FORMAT = csv_format
PATTERN = '.*Mortality_Improvement.*'
;

COPY INTO mortality_base
FROM '@stg_gen_assumption'
FILE_FORMAT = csv_format
PATTERN =  '.*Mortality_Base.*'
;

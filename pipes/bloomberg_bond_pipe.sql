-- add pipes which append and overwrite
use role SYSADMIN;
USE SCHEMA igg_source.bloomberg_bond;
USE WAREHOUSE INGEST_WH;

show pipes;

create pipe IGG_SOURCE.BLOOMBERG_BOND.BLOOMBERG_BONDS auto_ingest=true as
  COPY INTO bloomberg_bonds
    FROM '@stg_bloomberg_bond'
    FILE_FORMAT = csv_format
    PATTERN = '.*bond.csv';

desc pipe BLOOMBERG_BONDS;

-- arn:aws:sqs:eu-west-2:186002598237:sf-snowpipe-AIDASWTU6NFOX4HYFQO2T-6RviS9_K_FKCRXV__c2vrw


create pipe IGG_SOURCE.BLOOMBERG_BOND.BLOOMBERG_INDEX auto_ingest=true as
  COPY INTO bloomberg_index
    FROM '@stg_bloomberg_bond'
    FILE_FORMAT = csv_format
    PATTERN = '.*index.csv';

desc pipe BLOOMBERG_INDEX;
--arn:aws:sqs:eu-west-2:186002598237:sf-snowpipe-AIDASWTU6NFOX4HYFQO2T-6RviS9_K_FKCRXV__c2vrw


create pipe IGG_SOURCE.BLOOMBERG_BOND.BLOOMBERG_MAP auto_ingest=true as
  COPY INTO bloomberg_map
    FROM '@stg_bloomberg_bond'
    FILE_FORMAT = csv_format
    PATTERN = '.*map.csv';

desc pipe BLOOMBERG_MAP;
-- arn:aws:sqs:eu-west-2:186002598237:sf-snowpipe-AIDASWTU6NFOX4HYFQO2T-6RviS9_K_FKCRXV__c2vrw



CREATE OR REPLACE STAGE stg_market_curve
  STORAGE_INTEGRATION = S3_INTEGRATION
  URL = 's3://s3-biz-igg-lon-dev-processed/23-10-27 Biztory Extended Dataset Example/ICE_MarketCurve/'
  FILE_FORMAT = csv_format
  DIRECTORY = ( ENABLE = true AUTO_REFRESH = true );

      LIST '@stg_market_curve';

COPY INTO spot_forward
FROM '@stg_market_curve'
FILE_FORMAT = csv_format
PATTERN = '.*Spot_Forward.*';

COPY INTO curveois
FROM '@stg_market_curve'
FILE_FORMAT = csv_format
PATTERN = '.*CurveOIS.*';

COPY INTO curvexccy
FROM '@stg_market_curve'
FILE_FORMAT = csv_format
PATTERN = '.*CurveXCCY.*';

COPY INTO curveYC
FROM '@stg_market_curve'
FILE_FORMAT = csv_format
PATTERN = '.*CurveYC.*';

COPY INTO CURVEZC
FROM '@stg_market_curve'
FILE_FORMAT = csv_format
PATTERN = '.*CurveZC.*';


CREATE OR REPLACE TABLE member_characteristics(

Key INT,
RecordDate DATE,
SchemeName STRING,
SchemeEmployer STRING,
SchemeCategory STRING,
SchemeSection STRING,
MemberID STRING,
MemberStatus STRING,
MemberType STRING,
MemberDateOfBirth DATE,
MemberSex STRING,
DateJoinedScheme STRING,
DateOfLeaving DATE,
MaritalStatus STRING,
SpouseDateOfBirth DATE,
DateOfRetirement DATE,
RetirementType STRING,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ


);

CREATE OR REPLACE TABLE member_benefits(

Key INT,
RecordDate STRING,
MemberID STRING,
BenefitType STRING,
BenefitsID STRING,
BenefitsElement STRING,
NormalRetirementAge STRING,
CommencementDate DATE,
XSGMPFlag STRING,
GMPType STRING,
GMPXSDeductionMap STRING,
SPAXSDeductionMap STRING,
RevaluationType STRING,
RevaluationUnderpin STRING,
StatutoryID STRING,
PensionIncreaseType STRING,
PensionIncreaseMonth STRING,
CumulativeAnnualFlag STRING,
PensionIncreaseUnderpin FLOAT,
GMPAmountDOL FLOAT,
GMPAmountGPA FLOAT,
SpouseProportion FLOAT,
PreCommutationPension FLOAT,
PostCommutationPension FLOAT,
AnnualPensionInForce FLOAT,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ


);














drop stage stg_scheme_characteristics
use sysadmin;
USE SCHEMA igg_source.IGG_MEMBER_DATA;
USE WAREHOUSE INGEST_WH;

CREATE OR REPLACE STAGE stg_members
  STORAGE_INTEGRATION = S3_INT
  URL = 's3://s3-biz-igg-lon-dev-processed/23-10-27 Biztory Extended Dataset Example/IGG_MemberData/'
  FILE_FORMAT = csv_format
  DIRECTORY = ( ENABLE = true AUTO_REFRESH = true );

      LIST '@stg_members';

COPY INTO member_characteristics
FROM '@stg_members'
FILE_FORMAT = csv_format
PATTERN = '.*Member_Characteristics.*';

COPY INTO member_benefits
FROM '@stg_members'
FILE_FORMAT = csv_format
PATTERN = '.*Member_Benefits.*';

create or replace table spot_forward (

Key INT,
SDKey STRING,
Status STRING,
BaseCurrency VARCHAR(3),
TermCurrency VARCHAR(3),
Tenor STRING,
SpotMid FLOAT,
SpotDate DATE,
FwdRateMid STRING,
FwdPtsMid STRING,
InterestDays INT,
DeliveryDays INT,
DeliveryDate DATE,
FwdPtsMidMktConvention FLOAT,
Sent_timestamp	TIMESTAMP_LTZ,
Received_timestamp TIMESTAMP_LTZ,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ

);

CREATE OR REPLACE TABLE curveOIS (

Key INT,
SDKey STRING,
Status STRING,
Currency VARCHAR(3),
Index STRING,
Tenor STRING,
TenorDate STRING,
PaymentFrequency STRING,
DayCountBasis STRING,
RateMid STRING,
DF FLOAT,
Zero FLOAT,
Received_timestamp TIMESTAMP_LTZ,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ

);

CREATE OR REPLACE TABLE curveXCCY (
Key INT,
SDKey STRING,
Status STRING,
Currency VARCHAR(3),
Currency2 VARCHAR(3),
Index STRING,
Index2 STRING,
IndexType1 STRING,
IndexType2 STRING,
Tenor STRING,
TenorDate STRING,
PaymentFrequency1 STRING,
PaymentFrequency2 STRING,
XCCYRateMid FLOAT,
DF FLOAT,
Zero FLOAT,
XCCYSpread FLOAT,
XCCYSpreadNonMTM FLOAT,
Received_timestamp TIMESTAMP_LTZ,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE curveYC (

Key INT,
SDKey STRING,
Status STRING,
Currency VARCHAR(3),
Index STRING,
CurveIndex STRING,
Instrument STRING,
Tenor STRING,
TenorDate STRING,
PaymentFrequency STRING,
DayCountBasis STRING,
RateMid FLOAT,
DF FLOAT,
Zero FLOAT,
Received_timestamp TIMESTAMP_LTZ,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ
);

CREATE OR REPLACE TABLE curveZC (

Key INT,
SDKey STRING,
Status STRING,
Currency VARCHAR(3),
Index STRING,
Tenor STRING,
TenorDate DATE,
DayCountBasis STRING,
CompoundingFreq STRING,
CurrentIndex FLOAT,
FWDIndex FLOAT,
RateMid FLOAT,
Lag FLOAT,
Received_timestamp TIMESTAMP_LTZ,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ
);

CREATE OR REPLACE TABLE curveZC (

Key INT,
SDKey STRING,
Status STRING,
Currency VARCHAR(3),
Index STRING,
Tenor STRING,
TenorDate DATE,
DayCountBasis STRING,
CompoundingFreq STRING,
CurrentIndex FLOAT,
FWDIndex FLOAT,
RateMid FLOAT,
Lag FLOAT,
Received_timestamp TIMESTAMP_LTZ,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ
);

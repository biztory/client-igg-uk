CREATE OR REPLACE table Commutation_Factors (

Key INT,
In_Force_Date DATE,
Scheme_ID STRING,
Sex VARCHAR(1),
Tranche STRING,
Age VARCHAR(2),
Rate FLOAT,
Default_Flag BOOLEAN,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ

);

CREATE OR REPLACE table Commutation_Factors (

Key INT,
In_Force_Date DATE,
Scheme_ID STRING,
Sex VARCHAR(1),
Tranche STRING,
Age VARCHAR(2),
Rate FLOAT,
Default_Flag BOOLEAN,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ

);

CREATE OR REPLACE table Early_Late_Factors (

Key INT,
In_Force_Date DATE,
Scheme_ID STRING,
Sex VARCHAR(1),
Tranche STRING,
Age VARCHAR(2),
Rate FLOAT,
Default_Flag BOOLEAN,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ

);


CREATE OR REPLACE table Early_Late_Factors (

Key INT,
In_Force_Date DATE,
Scheme_ID STRING,
Sex VARCHAR(1),
Tranche STRING,
Type STRING,
Years_Early_Late INT,
Rate INT,
Default_Flag BOOLEAN,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ

);

CREATE OR REPLACE table Liability_Basis (
Key INT,
SchemeName STRING,
ValuationBasis STRING,
SchemeSection STRING,
MarketInterestRateCurve STRING,
MarketInterestRateSpread STRING,
MarketInterestRateMargin STRING,
MarketInflationRateCurve STRING,
MarketInflationRatePremium STRING,
MarketRPICPIGap STRING,
MarketPensionIncreaseBlack76 BOOLEAN,
MarketRPIVolatilityCap STRING,
MarketCPIVolatilityCap STRING,
MarketRPIVolatilityFloor STRING,
MarketCPIVolatilityFloor STRING,
MarketRPIAWEGap STRING,
MortalityBaseTableMale STRING,
MortalityBaseTableFemale STRING,
MortalityImprovTableMale STRING,
MortalityImprovTableFemale STRING,
MortalityAgeAdjustmentMale STRING,
MortalityAgeAdjustmentFemale STRING,
MortalityMultiplierMale STRING,
MortalityMultiplierFemale STRING,
MortalityCommutationFactorAdjustmentFlag BOOLEAN,
BehaviourCommutationRate STRING,
BehaviourTransferOutRate STRING,
BehaviourRetirementDate STRING,
DemographicMarriedProportionMale STRING,
DemographicMarriedProportionFemale STRING,
DemographicMarriedProportionMortalityDecremented BOOLEAN,
DemographicMarriedApplyAgeMale STRING,
DemographicMarriedApplyAgeFemale STRING,
DemographicAgeDifferenceUseAll BOOLEAN,
DemographicAgeDifferenceMale STRING,
DemographicAgeDifferenceFemale STRING,
SchemeGMPEqualisationLoading STRING,
SchemeExpenseLoading STRING,
SchemeCashflowLoading STRING,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ);
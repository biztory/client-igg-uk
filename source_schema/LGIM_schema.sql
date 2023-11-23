create or replace table LDI_analytics (

funds string,
Maturity STRING,
Term_to_maturity STRING,
Nominal_rate STRING,
PV01_per_10K_investment FLOAT,
Mid_offer_spread FLOAT,
Mid_bid_spread FLOAT,
Hedging_multiple FLOAT,
Upper_hedging_multiple FLOAT,
Indicative_rate_movement_to_hit_upper_limit FLOAT,
Lower_hedging_multiple FLOAT,
Indicative_rate_movement_to_hit_lower_limit FLOAT,
Investment_to_return_to_optimal_if_upper_limit_hit FLOAT,
Investment_to_return_to_optimal_if_lower_limit_hit FLOAT,
Optimal_hedging_multiple FLOAT,
Optimal_Duration FLOAT,
Distance_to_exhaustion FLOAT,
Type_of_fund STRING,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_timestamp TIMESTAMP_LTZ

);


 create or replace table LGIM_LDI_FUND_CHARACTERISTICS (

Key INT,
InterestRate STRING,
IS_0 FLOAT,
IS_25 FLOAT,
IS_50 FLOAT,
IS_75 FLOAT,
IS_100 FLOAT,
IS_150 FLOAT,
IS_200 FLOAT,
IS_250 FLOAT,
IS_300 FLOAT,
IS_400 FLOAT,
Table_Subheader VARCHAR(255),
Table_Name VARCHAR(255),
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ,
InterestRateinflationShock STRING



);

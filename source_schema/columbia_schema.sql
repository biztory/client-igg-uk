CREATE OR REPLACE TABLE COL_LDI_FUND_CHARACTERISTICS (

Date TIMESTAMP_LTZ,
Data_type STRING,
Fund_code STRING,
Fund_name STRING,
Type STRING,
Unleveraged_duration STRING,
Nominal_duration STRING,
Inflation_duration STRING,
Next_rebalancing_trade_date STRING,
Target_duration STRING,
BAU_min_Trigger STRING,
BAU_min_Required_shock STRING,
BAU_min_Rebal_per_1m VARCHAR(255),
BAU_max_Trigger STRING,
BAU_max_Required_shock STRING,
BAU_max_Rebal_per_1m STRING,
Max_Trigger STRING,
Max_Required_shock STRING,
Max_Rebal_per_1m STRING,
Knock_out_Trigger STRING,
Knock_out_Required_shock STRING,
Total_resilience STRING,
Type_of_fund STRING,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
Company STRING,
AWS_Timestamp TIMESTAMP_LTZ

);

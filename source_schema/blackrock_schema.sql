create or replace table blackrock_framework (

key INT,
level STRING,
basis_ponts INT,
Folder_Name VARCHAR(255),
File_Name VARCHAR(255),
AWS_timestamp TIMESTAMP_LTZ



);


create or replace table blackrock_weekly_report(

Type_of_Fund STRING,
Name STRING,
Fund_ISIN STRING,
Unit_price FLOAT,
NAV STRING,
Benchmark_Yield STRING,
Benchmark_Leverage STRING,
Unleveraged_Duration_Benchmark STRING,
Leveraged_Duration_Benchmark STRING,
Unleveraged_Inflation_Duration_Benchmark STRING,
Leveraged_Inflation_Duration_Benchmark STRING,
Fund_PV01_InterestRates STRING,
Fund_PV01_Inflation STRING,
Indicative_Transaction_Costs_in_bps_Offer STRING,
Indicative_Transaction_Costs_in_bps_Bid STRING,
Target_Leverage_Post_Future_Recap STRING,
Recapitalisation_Point_Leverage_Approx STRING,
Yield_Distance_to_Insolvency STRING,
Cash_Call_Expected_at_Recapitalisation_Point_per_unit STRING,
Folder_Name VARCHAR(255),
File_Name VARCHAR(255),
Sheet_Name VARCHAR(255),
AWS_timestamp TIMESTAMP_LTZ


);
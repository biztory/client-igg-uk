use sysadmin;
use warehouse compute_wh;
use database igg_source;
use schema bloomberg_equity;

CREATE or replace TABLE bloomberg_holdings_delta  (

Key INT,
Index_Calculation_Date STRING,
Version INT,
Index_Key STRING,
Index_Provider STRING,
Index_Name STRING,
Index_Ticker STRING,
Index_FIGI STRING,
Index_Currency VARCHAR(3),
Effective_Date STRING,
Security_Name STRING,
Security_Ticker STRING,
Security_ISIN STRING,
Security_CUSIP STRING,
Security_SEDOL STRING,
Security_FIGI STRING,
Security_Type STRING,
Primary_Exchange_Name STRING,
Primary_Exchange_BBG_Code STRING,
Primary_Exchange_MIC STRING,
Country_Of_Listing STRING,
Country_Of_Incorporation STRING,
Economy STRING,
Country STRING,
Size STRING,
BICS_Level_Code_Assigned BIGINT,
Security_Currency VARCHAR(3),
Price FLOAT,
Base_Shares FLOAT,
Weighting_Factor FLOAT,
Index_Shares FLOAT,
Market_Cap_Local FLOAT,
Security_FX_Rate FLOAT,
Security_FX_Source STRING,
Security_FX_Date STRING,
Market_Cap FLOAT,
Weight FLOAT,
Corporate_Event STRING,
Gross_Dividend_Amount FLOAT,
Net_Dividend_Amount FLOAT,
Dividend_Shares FLOAT,
Gross_Dividend_Cash_Flow FLOAT,
Net_Dividend_Cash_Flow FLOAT,
Adjusted_Gross_Dividend_Cash_Flow FLOAT,
Adjusted_Net_Dividend_Cash_Flow FLOAT,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ
);

CREATE OR REPLACE TABLE bloomberg_index_events (

Key INT,
Index_Calculation_Date STRING,
Version INT,
Index_Key STRING,
Index_Provider STRING,
Index_Name STRING,
Index_Ticker STRING,
Index_FIGI STRING,
Index_Currency VARCHAR(3),
Security_Name STRING,
Security_Ticker STRING,
Security_ISIN STRING,
Security_CUSIP STRING,
Security_SEDOL STRING,
Security_FIGI STRING,
Security_Type STRING,
Primary_Exchange_Name STRING,
Primary_Exchange_BBG_Code STRING,
Primary_Exchange_MIC STRING,
Economy STRING,
Country STRING,
Size STRING,
BICS_Level_Code_Assigned BIGINT,
Corporate_Event_ID BIGINT,
Sequence_Number INT,
Announcement_Date STRING,
Last_Updated_Date STRING,
Implementation_Date STRING,
Effective_Date STRING,
Effective_Date_Override STRING,
Pay_Date STRING,
Corporate_Event_Class STRING,
Corporate_Event STRING,
Corporate_Event_Type STRING,
Event_Description STRING,
Event_Notes STRING,
Status STRING,
Ratio_Held FLOAT,
Ratio_Received FLOAT,
Price_Adjustment_Factor FLOAT,
Currency VARCHAR(3),
Gross_Dividend_Amount FLOAT,
Net_Dividend_Amount FLOAT,
Withholding_Tax_Rate FLOAT,
PID_Amount FLOAT,
Franking_Rate FLOAT,
Conduit_Foreign_Income_Amount FLOAT,
Rights_Subs_Price FLOAT,
Received_Security_Name STRING,
Received_Security_Ticker STRING,
Acquirer_Name STRING,
Acquirer_Tickers STRING,
Target_Name STRING,
Target_Tickers STRING,
Acquisition_Type STRING,
Pct_Owned INT,
Pct_Sought INT,
Cash_Currency VARCHAR(3),
Cash_Terms FLOAT,
Cash_Flag STRING,
Share_Terms FLOAT,
Shares_Flag STRING,
Proration_Stock_Pct INT,
Share_Class STRING,
New_Share_Class STRING,
Security_Currency STRING,
Price STRING,
Adjusted_Price STRING,
Base_Shares STRING,
New_Base_Shares STRING,
Weighting_Factor STRING,
New_Weighting_Factor STRING,
Index_Shares STRING,
New_Index_Shares STRING,
New_Economy STRING,
New_Country STRING,
New_Size STRING,
New_BICS_Level_Code_Assigned STRING,
New_Security_Name STRING,
New_Security_Ticker STRING,
New_Security_ISIN STRING,
New_Security_CUSIP STRING,
New_Security_SEDOL STRING,
New_Security_FIGI STRING,
New_Security_Type STRING,
New_Primary_Exchange_Name STRING,
New_Primary_Exchange_BBG_Code STRING,
New_Primary_Exchange_MIC STRING,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ
);

create or replace table bloomberg_levels_open(
Key INT,
Index_Calculation_Date STRING,
Version INT,
Index_Key STRING,
Index_Provider STRING,
Index_Name STRING,
Index_Ticker STRING,
Index_FIGI STRING,
Index_Currency VARCHAR(3),
Effective_Date STRING,
Return_Type STRING,
Index_Level STRING,
Market_Cap FLOAT,
Divisor FLOAT,
Dividend_Points FLOAT,
Index_Dividend FLOAT,
Adjusted_Index_Dividend FLOAT,
Constituent_Count INT,
Daily_Return STRING,
Proforma_Start_Date STRING,
Rebalance_Date STRING,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ
);



create or replace table scheme_holdings (

Scheme_Code STRING,
Scheme STRING,
Statement_Date DATE,
Fund_Code STRING,
Fund_Name STRING,
Charge_Percent FLOAT,
Units_Held FLOAT,
Unit_Price FLOAT,
Value FLOAT,
Holding_Percent FLOAT,
Total_Scheme_Value FLOAT,
Transaction_Type STRING,
Transaction_Status STRING,
Transaction_Value FLOAT,
Transaction_Number_Units FLOAT,
Transaction_Unit_Price FLOAT,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ

);
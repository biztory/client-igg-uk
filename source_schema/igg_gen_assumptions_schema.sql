CREATE OR REPLACE TABLE mortality_improvement (
Key INT,
RowNm INT,
Table_Name STRING,
Age VARCHAR(3),
Year INT,
Rate FLOAT,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ


);

CREATE OR REPLACE TABLE mortality_base (

Key INT,
RowNm INT,
Table_Name STRING,
Effective_Date DATE,
First_Year_Improve_Percentage FLOAT,
Age VARCHAR(3),
Rate FLOAT,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ


);
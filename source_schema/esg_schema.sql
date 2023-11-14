create or replace table country_code (

Key	INT,
Country	STRING,
Country_Code VARCHAR(2),
File_Name	VARCHAR(255),
Folder_Name	VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ

);

create or replace table biodiversity (

key TIMESTAMP_LTZ,
TICKER STRING,
ISIN STRING,
CompanyName STRING,
Operations_Revenue_Value FLOAT,
Operations_Revenue_Year FLOAT,
Operations_CarbonEmissions_Value FLOAT,
Operations_CarbonEmissions_Year FLOAT,
Operations_CarbonEmissions_Estimated FLOAT,
Operations_Carbonefficiency_Value FLOAT,
Operations_Carbonefficiency_Estimated FLOAT,
Operations_Carbonemissionsscope3_Value FLOAT,
Operations_Carbonemissionsscope3_Year INT,
Operations_Carbonemissionsscope3_Estimated FLOAT,
Operations_Carbonscope3efficiency_Value FLOAT,
Operations_Carbonscope3efficiency_Estimated FLOAT,
Operations_Wasteefficiency_Value FLOAT,
Operations_Wasteefficiency_Estimated FLOAT,
Operations_Hazardouswasteemissions_Value FLOAT,
Operations_Hazardouswasteemissions_Year INT,
Operations_Hazardouswasteemissions_Estimated FLOAT,
Operations_Waterefficiency_Value FLOAT,
Operations_Waterefficiency_Estimated STRING,
Operations_Wateremissions_Value FLOAT,
Operations_Wateremissions_Year INT,
Operations_Wateremissions_Estimated FLOAT,
Operations_Avoidingwaterscarcity_Value FLOAT,
Operations_Avoidingwaterscarcity_Estimated FLOAT,
Operations_SFDRbiodiversityPAI_Value FLOAT,
Productsandservicesrevenue_Landandseausechange_Positiverevenue FLOAT,
Productsandservicesrevenue_Landandseausechange_Negativerevenue FLOAT,
Productsandservicesrevenue_Climatechange_Positiverevenue FLOAT,
Productsandservicesrevenue_Climatechange_Negativerevenue FLOAT,
Productsandservicesrevenue_Naturalresourceexploitation_Positiverevenue FLOAT,
Productsandservicesrevenue_Naturalresourceexploitation_Negativerevenue FLOAT,
Productsandservicesrevenue_Pollution_Positiverevenue FLOAT,
Productsandservicesrevenue_Pollution_Negativerevenue FLOAT,
SDGAlignedRevenue_SDG6Revenue FLOAT,
SDGAlignedRevenue_SDG12Revenue FLOAT,
SDGAlignedRevenue_SDG14Revenue FLOAT,
SDGAlignedRevenue_SDG15Revenue FLOAT,
FileName VARCHAR(255),
FolderName VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ

);

create or replace table climate (

);


create or replace table sovereign (

Key TIMESTAMP_LTZ,
Country STRING,
Factor STRING,
Theme STRING,
Year FLOAT,
Universe STRING,
SDG FLOAT,
Category STRING,
Level FLOAT,
latest_Level FLOAT,
Normalised_Level FLOAT,
Latest_Normalised_Level FLOAT,
Pathway INT,
Latest_Pathway FLOAT,
File_Name VARCHAR(255),
Folder_Name VARCHAR(255),
AWS_Timestamp TIMESTAMP_LTZ

);

USE ACCOUNTADMIN;
USE WAREHOUSE INGEST_WH;


CALL IGG_SOURCE.PUBLIC.COPY_COMMANDS();

    
CREATE OR REPLACE PROCEDURE COPY_COMMANDS()
    RETURNS STRING
    LANGUAGE JAVASCRIPT
    EXECUTE AS CALLER
AS
$$
var schema_stg_table_folder = "select s.stage_schema as stage_schema, concat('@',s.stage_name) as stg, t.table_name as table_name, split_part(iff(endswith(s.stage_url, '/'),s.stage_url,concat(s.stage_url, '/')),'/',-2) as folder_name from snowflake.account_usage.stages s left join snowflake.account_usage.tables t on s.stage_schema = t.table_schema where s.stage_catalog = 'IGG_SOURCE' and s.deleted is null and t.deleted is null and stage_name !='STG_ICE_MARKET_CURVE' order by 2, 3, 1;";

var finding_tables = snowflake.createStatement({sqlText: schema_stg_table_folder});
var result_set = finding_tables.execute();

var table_name_file_format_dict = {
'BIODIVERSITY':'.*Biodiversity.*',
'BLACKROCK_FRAMEWORK':'.*Framework.*',
'BLACKROCK_WEEKLY_REPORT':'.*LMF_and_Profile_Funds_Weekly_Report.*',
'BLOOMBERG_BONDS':'.*index.csv',
'BLOOMBERG_HOLDINGS_CLOSE':'.*HoldingsClose.csv',
'BLOOMBERG_HOLDINGS_DELTA':'.*LevelsClose.csv',
'BLOOMBERG_HOLDINGS_OPEN':'.*IndexEvents.csv',
'BLOOMBERG_INDEX':'.*bond.csv',
'BLOOMBERG_INDEX_EVENTS':'.*HoldingsDelta.csv',
'BLOOMBERG_LEVELS_CLOSE':'.*LevelsOpen.csv',
'BLOOMBERG_LEVELS_OPEN':'.*HoldingsOpen.csv',
'BLOOMBERG_MAP':'.*map.csv',
'CLIMATE':'.*Climate.*',
'COL_LDI_FUND_CHARACTERISTICS':'.*durations.*',
'COMMUTATION_FACTORS':'.*Commutation_Factors.csv',
'COUNTRY_CODE':'.*CountryCode.csv',
'CURVEOIS':'.*CurveOIS.*',
'CURVEXCCY':'.*CurveXCCY.*',
'CURVEYC':'.*IR_CurveYC.*',
'CURVEZC':'.*InflationCurveZC.*',
'EARLY_LATE_FACTORS':'.*Early_Late_Factors.csv',
'FUND_HOLDINGS':'.*Fund_Holdings.*',
'LDI_ANALYTICS':'.*LDIAnalytics.*',
'LGIM_LDI_FUND_CHARACTERISTICS':'.*Fund Risk Ladders.*',
'LIABILITY_BASIS':'.*Liability_Basis_Database.csv',
'MEMBER_CHARACTERISTICS':'.*Member_Characteristics.csv',
'MEMBER_BENEFITS': '.*Member_Benefits.*',
'MORTALITY_BASE':'.*Mortality_Base_Upload.csv',
'MORTALITY_IMPROVEMENT':'.*Mortality_Improvement.*',
'SCHEME_CHARACTERISTICS':'.*Scheme_Characteristics.csv',
'SCHEME_HOLDINGS':'.*R_IGG- Client.*',
'SOVEREIGN':'.*Sovereign.*',
'SPOT_FORWARD':'.*FX_Spot_Forward.*'};

var sqlStatements = [];

while (result_set.next()) {
    var schema_name = result_set.getColumnValue('STAGE_SCHEMA');
    var stage_name = result_set.getColumnValue('STG');
    var table_name = result_set.getColumnValue('TABLE_NAME');


    var file_format_regex = table_name_file_format_dict[table_name];

    var schemasql = "USE SCHEMA " + schema_name + "; \n\n";
    sqlStatements.push(schemasql);

    var sqlStatement = "create or replace pipe pipe_" + table_name + 
  " auto_ingest = true as COPY INTO " + schema_name + "." + table_name + " FROM '" + stage_name + "' FILE_FORMAT = csv_format PATTERN = " + "'" + file_format_regex + "'" + "; \n\n";
    sqlStatements.push(sqlStatement);
}
var sqlString = sqlStatements.join("\n");

return sqlString;
$$;



-- select *
-- from information_schema.functions;

-- select *
-- from snowflake.account_usage.functions;

select s.*,t.*,s.stage_schema as stage_schema, concat('@',s.stage_name) as stg, t.table_name as table_name, split_part(iff(endswith(s.stage_url, '/'),s.stage_url,concat(s.stage_url, '/')),'/',-2) as folder_name from snowflake.account_usage.stages s left join snowflake.account_usage.tables t on s.stage_schema = t.table_schema where s.stage_catalog = 'IGG_SOURCE' and s.deleted is null and t.deleted is null and stage_name !='STG_ICE_MARKET_CURVE' order by 2, 3, 1;


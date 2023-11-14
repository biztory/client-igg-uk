CREATE or replace FILE FORMAT csv_format 
  TYPE = 'CSV' 
  FIELD_DELIMITER = ',' 
  SKIP_HEADER = 1 
  FIELD_OPTIONALLY_ENCLOSED_BY = '"' 
  NULL_IF = ('NULL', 'null');
  
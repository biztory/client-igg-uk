-- change role to securityadmin for user / role steps
use role securityadmin;

-- create role for dbt
create role if not exists dbt_role;
grant role dbt_role to role SYSADMIN;

-- change role to sysadmin for warehouse / database steps
use role sysadmin;

-- create a warehouse for dbt
create warehouse if not exists transform_wh
warehouse_size = xsmall
warehouse_type = standard
auto_suspend = 60
auto_resume = true
initially_suspended = true;

-- create database for dbt
create database if not exists dwh;

-- grant dbt role access to warehouse
grant USAGE
on warehouse transform_wh
to role dbt_role;

-- grant dbt access to database
grant CREATE SCHEMA, MONITOR, USAGE
on database dwh
to role dbt_role;

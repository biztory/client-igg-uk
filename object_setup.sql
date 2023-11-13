use role SYSADMIN;

create database if not exists igg_source_dev;

use database igg_source_dev;


create schema if not exists bloomberg_bond;
create schema if not exists bloomberg_equity;
create schema if not exists fund_holdings;
create schema if not exists ICE_market_curve;
create schema if not exists IGG_assumptions;
create schema if not exists IGG_general_assumption_tables;
create schema if not exists IGG_member_data;
create schema if not exists IGG_scheme_characteristics;
create schema if not exists impact_cubed_ESG;
create schema if not exists LDI_columbia_threadneedle;
create schema if not exists LDI_blackrock;
create schema if not exists LDI_LGIM;
create schema if not exists scheme_holdings;



use database igg_source_dev;
use schema igg_source_dev.bloomberg_bond;
use warehouse compute_wh;


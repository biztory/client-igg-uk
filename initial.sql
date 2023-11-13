use role sysadmin;

create database if not exists igg_source_dev;
create schema if not exists bloomberg_bond;

use database igg_source_dev;
use schema igg_source_dev.bloomberg_bond;

use warehouse compute_wh;





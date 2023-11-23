use role accountadmin;
grant execute task on account to role sysadmin; 

use role sysadmin;
use warehouse compute_wh; 
use database igg_source; 
create schema tasks;  

create or replace task task_bloomberg_levels_close
warehouse = COMPUTE_WH
--schedule = 'USING CRON 0 7 * * * UTC'
SUSPEND_TASK_AFTER_NUM_FAILURES = 3
as
COPY INTO IGG_SOURCE.BLOOMBERG_EQUITY.BLOOMBERG_LEVELS_CLOSE
FROM '@IGG_SOURCE.BLOOMBERG_EQUITY.STG_BLOOMBERG_EQUITY'
FILE_FORMAT = IGG_SOURCE.BLOOMBERG_EQUITY.CSV_FORMAT
PATTERN = '.*LevelsClose.csv';

create or replace task task_bloomberg_levels_open
warehouse = COMPUTE_WH
--after task_bloomberg_levels_close
as
COPY INTO IGG_SOURCE.BLOOMBERG_EQUITY.BLOOMBERG_LEVELS_OPEN
FROM '@IGG_SOURCE.BLOOMBERG_EQUITY.STG_BLOOMBERG_EQUITY'
FILE_FORMAT = IGG_SOURCE.BLOOMBERG_EQUITY.CSV_FORMAT
PATTERN = '.*LevelsOpen.csv';

/* lists all tasks */
show tasks; 

/* manually executed tasks */
execute task task_bloomberg_levels_close; 
execute task task_bloomberg_levels_open;

/* resume = sets task to run on its schedule | suspend = stops task running on its schedule */
--alter task task_bloomberg_levels_close resume; 
--alter task task_bloomberg_levels_open resume; 

/* view task history */
select * from table(information_schema.task_history(TASK_NAME => 'task_bloomberg_levels_close'));

select * from table(information_schema.task_history())
order by query_start_time desc;




-- name flinksql_binlog_x
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-03-21 15:50:59
-- desc
CREATE TABLE source(
    id             bigint
 )WITH(
    'connector'='binlog-x',
    'username'='drpeco',
    'password' = '******',
    'cat'='insert,delete,update',
    'url'='jdbc:mysql://172.16.100.186:3306/automation?useSSL=false',
    'host'='172.16.100.186',
    'port'='3306'
--   ,'journal-name' = 'mysql-bin.000001'
,
    'table'='automation.mysql_flink_cdc_all_type',
    'timestamp-format.standard'='SQL'
 );
CREATE TABLE sink(
    id             bigint
 )WITH(
    'connector'='stream-x'
 );
insert  
into
    sink
    select
        *      
    from
        source u;

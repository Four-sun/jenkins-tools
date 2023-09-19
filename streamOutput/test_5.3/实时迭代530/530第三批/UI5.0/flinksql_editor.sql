
CREATE TABLE side(
    sink_id INT,
    sink_name VARCHAR,
    sink_start_time TIME,
    sink_school VARCHAR,
    sink_message VARCHAR,
    sink_end_time TIMESTAMP
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='123tablejoin_resulttable12',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE sink(
    ID decimal(38,0) ,
    NAME varchar
 )WITH(
    'password' = '******',
    'connector'='oracle-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='ANONYMOUS',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='ORACLE_TEST_0420',
    'sink.parallelism'='1',
    'url'='jdbc:oracle:thin:@172.16.100.243:1521:orcl',
    'username'='shixiao'
 );
-- name flinksql_editor
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-12-29 17:05:24
-- desc 
create table finance.tmp_dm_rpt_110015_fsa_app_d_23 
as 
select  a.stat_date as stat_date    
  ,a.intfc_tp as intfc_tp
  ,a.trmnl_tp_id as trmnl_tp_id
  ,a.app_version  as app_version 
  ,a.clnt_chnl  as clnt_chnl
  ,a.trmnl_clnt as  trmnl_clnt

CREATE TABLE sourceTable(
    id int,
    varchar_data varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE sqlserverResultTable(
    id int,
    varchar_data STRING,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='sqlserver-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='dbo',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='source_112_sqlserver_varchar',
    'sink.parallelism'='1',
    'url'='jdbc:sqlserver://172.16.101.246:1433;database=db_test',
    'username'='sa'
 );
-- name Flink112_kafka_sqlserver_update_not_null
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-09-07 14:55:58
-- desc 
INSERT  
INTO
    sqlserverResultTable
    select
        id,
        varchar_data    
    from
        sourceTable;


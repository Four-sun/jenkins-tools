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

CREATE TABLE kingbaseResult(
    id int,
    varchar_data varchar,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='kingbase-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='PUBLIC',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='kingbaseFanshuOne',
    'sink.parallelism'='1',
    'url'='jdbc:kingbase8://172.16.83.182:54321/TEST',
    'username'='SYSTEM'
 );
-- name Flink112_kafka_sqlserver_update
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-08 15:16:03
-- desc 
INSERT  
INTO
    kingbaseResult
    select
        id,
        varchar_data    
    from
        sourceTable;

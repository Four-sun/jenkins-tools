CREATE TABLE sourceTable(
    id int,
    bigint_data bigint,
    varchar_data varchar,
    double_data double,
    numeric_data numeric(10,0) ,
    timestamp_data timestamp
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE oushuResultTable(
    id bigint,
    bigint_data bigint,
    character_varying_data varchar,
    character_data varchar,
    double_data double,
    numeric_data numeric,
    text_data varchar,
    timestamp_data timestamp
 )WITH(
    'password' = '******',
    'connector'='oushu-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='public',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='stream_all_type_test_two',
    'sink.parallelism'='1',
    'url'='jdbc:postgresql://172.16.83.170:5432/postgres',
    'username'='oushu'
 );
-- name Flink112_kafka_oushu_test_two
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-09-07 14:51:37
-- desc 
INSERT        
into
    oushuResultTable
    select
        id,
        bigint_data,
        varchar_data as character_varying_data,
        varchar_data as character_data,
        double_data,
        numeric_data,
        varchar_data as text_data,
        timestamp_data     
    from
        sourceTable; 


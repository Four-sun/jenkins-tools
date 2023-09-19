CREATE TABLE sourceTable(
    id int,
    bigint_data bigint,
    boolean_data boolean,
    varchar_data varchar,
    double_data double,
    numeric_data numeric,
    timestamp_data timestamp,
    proc_time AS PROCTIME() 
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
    boolean_data boolean,
    character_varying_data varchar,
    character_data varchar,
    date_data date,
    double_data double,
    numeric_data decimal,
    text_data varchar,
    timestamp_data timestamp
 )WITH(
    'password' = '******',
    'connector'='oushu-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='public',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='stream_all_type_test_one',
    'sink.parallelism'='1',
    'url'='jdbc:postgresql://172.16.83.170:5432/postgres',
    'username'='oushu'
 );
-- name Flink112_kafka_oushu_test_one
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-04 14:09:09
-- desc
INSERT        
into
    oushuResultTable
    select
        id,
        bigint_data,
        boolean_data as boolean_data,
        varchar_data as character_varying_data,
        varchar_data as character_data,
        TO_DATE('2023-04-24','yyyy-MM-dd') as date_data,
        double_data,
        numeric_data,
        varchar_data as text_data,
        timestamp_data     
    from
        sourceTable; 

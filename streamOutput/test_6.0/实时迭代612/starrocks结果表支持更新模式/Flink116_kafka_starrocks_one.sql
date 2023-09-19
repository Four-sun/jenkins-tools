CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu4',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE starrocksResultTable(
    id string,
    gender string
 )WITH(
    'password' = '******',
    'connector'='starrocks-x',
    'schema-name'='flinkx_test',
    'feNodes'='172.16.82.221:8030',
    'sink.buffer-flush.max-rows'='2',
    'table-name'='starrocks_stream_test_one',
    'sink.parallelism'='2',
    'url'='jdbc:mysql://172.16.82.221:9030',
    'username'='root'
 );
-- name Flink112_kafka_starrocks_one
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-07 20:01:33
-- desc
INSERT 
INTO
    starrocksResultTable
    select
        cast(id as string) id,
        name as gender 
    from
        sourceTable;

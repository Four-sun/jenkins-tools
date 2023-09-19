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
    id int,
    gender string,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='starrocks-x',
    'schema-name'='flinkx_test',
    'feNodes'='172.16.82.221:8030',
    'sink.buffer-flush.max-rows'='2',
    'table-name'='starrocks_stream_test_two',
    'sink.parallelism'='2',
    'url'='jdbc:mysql://172.16.82.221:9030',
    'username'='root'
 );
-- name Flink112_kafka_starrocks_upsert
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-09-07 14:52:35
-- desc 
CREATE TABLE source(
    id int,
    name varchar(50) 
 )WITH(
    'connector'='binlog-x',
    'username'='drpeco',
    'password' = '******',
    'cat'='insert,delete,update',
    'url'='jdbc:mysql://172.16.100.186:3306/liuliu_test?useSSL=false',
    'host'='172.16.100.186',
    'port'='3306',
    'table'='liuliu_test.cdc_source_test',
    'timestamp-format.standard'='SQL'
 );
INSERT  
INTO
    starrocksResultTable
    select
        id,
        name as gender      
    from
        source;


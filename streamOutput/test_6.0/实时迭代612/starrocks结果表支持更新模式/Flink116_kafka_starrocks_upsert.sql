

CREATE TABLE starrocksResultTable(
    id int,
    gender string,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'semantic'='none',
    'password' = '******',
    'connector'='starrocks-x',
    'schema-name'='flinkx_test',
    'feNodes'='172.16.82.221:8030',
    'sink.buffer-flush.max-rows'='2',
    'table-name'='starrocks_stream_test_two',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.82.221:9030',
    'username'='root'
 );
CREATE TABLE kafkaResultOne(
    id int,
    gender varchar,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='upsert-kafka-x',
    'value.format'='json',
    'value.fields-include'='ALL',
    'key.format'='json',
    'topic'='fanshu5',
    'sink.parallelism'='1'
 );
-- name Flink112_kafka_starrocks_one
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-07 20:01:33
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

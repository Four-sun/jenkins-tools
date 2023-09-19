CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE kafkaResultTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu7',
    'sink.parallelism'='1'
 );
-- name Flink_Catalog_kafka_kafka
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-07-18 14:00:51
-- desc

insert 
into
    kafkaResultTable
    select
        id,
        name,
        age 
    from
        dev_flinkx_catalog.dev_flinkx_database.iceberg_test;



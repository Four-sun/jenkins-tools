CREATE TABLE sourceTable(
    id varchar,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );


-- name hmscatalog_kafka_iceberg
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-29 14:10:49
-- desc
INSERT 
INTO
     hudiCatalog_one.hudiDatabase_one.fanshu_hudi_1
    select
        id,
        age 
    from
        sourceTable;


CREATE TABLE sourceTable(
    uuid varchar,
    name varchar,
    age int,
    pt varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );


-- name FlinkSQL_Hudi_kafka
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-07-10 14:17:18
-- desc
INSERT 
INTO
    cow_cdc_fanshu_7
    select
        pt,
        name,
        uuid,
        age
    from
        sourceTable;

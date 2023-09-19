CREATE TABLE sourceTable(
    uuid varchar,
    name varchar,
    age int,
    ts bigint
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
    cow_cdc_fanshu_8
    select
        uuid,
        name,
        age,
        aggast_001(uuid) as pt
    from
        sourceTable;



-- create table mor_bulk(
--   uuid VARCHAR(20) PRIMARY KEY NOT ENFORCED,
--   name VARCHAR(10),
--   age INT,
--   ts TIMESTAMP(3),
--   `partition` VARCHAR(20)
-- ) PARTITIONED BY (`partition`) WITH (
--   'connector' = 'hudi',
--   'path' = '/tmp/liuliu/hudi_test/mor_bulk',
--   'table.type' = 'MERGE_ON_READ',
--   'write.operation' = 'insert/upsert/bulk_insert'
-- );

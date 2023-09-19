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
    'topic'='mizhi1',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE cow_cdc_fanshu_7(
    pt VARCHAR(2147483647) ,
    name VARCHAR(2147483647) ,
    uuid VARCHAR(2147483647) ,
    age INT
 )partitioned by(
    pt
 )WITH(
    'pk.constraint.name'='PK_3601370',
    'transient_lastDdlTime'='1689066792',
    'hoodie.datasource.write.recordkey.field'='uuid',
    'path'='/tmp/liuliu/hudi_test/cow_cdc_fanshu_7',
    'connector'='hudi',
    'comment'='',
    'table.type'='COPY_ON_WRITE',
    'write.operation'='upsert'
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

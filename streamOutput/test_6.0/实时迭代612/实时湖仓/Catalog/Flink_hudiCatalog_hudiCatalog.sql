CREATE TABLE sourceTable(
    id varchar,
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


-- name Flink_Catalog_kafka_kafka
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-07-18 14:00:51
-- desc

insert 
into
    dev_flinkx_catalog.dev_flinkx_database.fanshu003
    select
        t1.id,
        t1.name,
        t1.age 
    from
        dev_flinkx_catalog.dev_flinkx_database.fanshu_002 /*+ OPTIONS('scan.startup.mode'='earliest-offset','hoodie.datasource.query.type' ='incremental') */ t1;



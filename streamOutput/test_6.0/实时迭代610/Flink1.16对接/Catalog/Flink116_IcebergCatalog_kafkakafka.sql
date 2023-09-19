CREATE TABLE sourceTable(
    id int,
    name string,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );


-- name FlinkX116_IcebergCatalog_kafkakafka
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-29 17:19:54
-- desc
INSERT 
INTO
    icebergCatalog.icebergdatabaseone.iceberg_result_table
    select
        id,
        name,
        age 
    from
        sourceTable;

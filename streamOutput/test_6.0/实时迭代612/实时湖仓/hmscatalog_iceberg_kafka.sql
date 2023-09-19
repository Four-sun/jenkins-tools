

CREATE TABLE kafkaResultOne(
    id varchar,
    name varchar,
    age varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu7',
    'sink.parallelism'='1'
 );
-- name hmscatalog_kafka_iceberg
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-29 14:10:49
-- desc
INSERT 
INTO
    kafkaResultOne 
    select
        id,
        name,
        age 
    from
        fanshuCatalog_one.fanshuDatabase_one.liuliu_3;

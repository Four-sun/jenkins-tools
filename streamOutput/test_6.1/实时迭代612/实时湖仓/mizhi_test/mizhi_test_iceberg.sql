

CREATE TABLE kafkaResultOne(
    id bigint,
    name varchar,
    age bigint
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='mizhi',
    'sink.parallelism'='1'
 );
-- name hmscatalog_iceberg_kafka
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-09-07 14:50:13
-- desc 
INSERT 
INTO
    kafkaResultOne 
    select
        id,
        name,
        age 
    from
        mizhi_test_HMS_iceberg.mizhi_test_iceberg.mizhi_iceberg_source;


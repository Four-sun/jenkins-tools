

CREATE TABLE kafkaResult(
    uuid varchar,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu7',
    'sink.parallelism'='1'
 );
-- name FlinkSQL_Hudi_kafka
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-07-10 14:17:18
-- desc
INSERT 
INTO
    kafkaResult
    select
        uuid,
        name,
        age
    from
        cow_cdc_fanshu;

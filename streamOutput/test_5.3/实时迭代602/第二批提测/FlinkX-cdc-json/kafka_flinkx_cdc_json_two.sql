CREATE TABLE sourceTableOne(
    id int,
    name STRING,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='chunjun-cdc-json-x',
    'topic'='dtstream_four',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE kafkaResultOne(
    id int,
    name varchar,
    age int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='upsert-kafka-x',
    'value.format'='json',
    'value.fields-include'='ALL',
    'key.format'='json',
    'topic'='dtstream_five',
    'sink.parallelism'='1'
 );
-- name kafka_flinkx_cdc_json_one
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-03-30 14:31:58
-- desc
INSERT  
INTO
    kafkaResultOne
    SELECT
        id,
        name,
        age     
    from
        sourceTableOne;

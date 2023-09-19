CREATE TABLE sourceTableOne(
    name varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='raw',
    'topic'='dtstream_two',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE kafkaResultOne(
    id varchar,
    name varchar,
    age varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='dtstream_three',
    'sink.parallelism'='1'
 );
-- name kafkaJson_kafkaRaw
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-03-30 11:10:57
-- desc
INSERT 
INTO
    kafkaResultOne
    SELECT
        SPLIT_INDEX(name, ',', 0) as id,
        SPLIT_INDEX(name, ',', 1) as name,
        SPLIT_INDEX(name, ',', 2) as age
    from
        sourceTableOne;

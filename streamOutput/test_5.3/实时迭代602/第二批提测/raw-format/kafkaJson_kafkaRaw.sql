CREATE TABLE sourceTableOne(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'scan.startup.timestamp-millis'='1683272026964',
    'topic'='dtstream_one',
    'scan.startup.mode'='timestamp'
 );

CREATE TABLE kafkaResultOne(
    name varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='raw',
    'topic'='dtstream_two',
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
        name
    from
        sourceTableOne;

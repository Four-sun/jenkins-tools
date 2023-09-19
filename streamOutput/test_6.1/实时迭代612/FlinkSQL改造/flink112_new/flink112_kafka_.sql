CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='mizhi001',
    'scan.startup.mode'='latest-offset'
 );


-- name flink112_kafka_
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-22 14:39:49
-- desc 


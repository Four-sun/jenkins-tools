CREATE TABLE sourceTable(
    id int,
    name varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE kafkaResultTable(
    id int,
    name varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu7',
    'sink.parallelism'='1'
 );
-- name ogg_flinksql
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-01-16 16:19:01
-- desc 
INSERT INTO kafkaResultTable select id,ogg_test_case(name) from sourceTable;

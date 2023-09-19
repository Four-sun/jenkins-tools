CREATE TABLE sourceTable(
    id int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='test_topic_name_gcwfybte',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE kafkaResultTable(
    id int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='shifang_s3',
    'sink.parallelism'='1'
 );
-- name kafka2kafka001
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-01-10 15:48:44
-- desc kafka2kafka001
INSERT INTO kafkaResultTable select id from sourceTable;

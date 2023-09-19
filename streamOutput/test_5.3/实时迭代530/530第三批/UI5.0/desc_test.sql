CREATE TABLE source(
    id int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='test_topic_name_gcwfybte',
    'scan.startup.mode'='latest-offset'
 );


-- name desc_test
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-12-07 15:25:43
-- desc this is desc
select * from source;

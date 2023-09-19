CREATE TABLE sourceTableOne(
    id varchar,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE kafkaResultOne(
    id varchar,
    name varchar,
    name_1 varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu4',
    'sink.parallelism'='1'
 );
-- name stream2stream
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-03-30 19:49:31
-- desc
insert 
into
    kafkaResultOne
    select
        id,
        aggast_002(name),
        aggast_001(name) as name_1,
        age 
    from
        sourceTableOne;

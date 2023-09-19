CREATE TABLE sourceTable(
    id int,
    id1 int,
    id2 int,
    id3 int,
    id4 int,
    id5 int,
    name1 varchar,
    name2 varchar,
    name3 varchar,
    name4 varchar,
    name5 varchar,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='stream_blood_seven',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE kafkaResultTable(
    id int,
    id1 int,
    id2 int,
    id3 int,
    id4 int,
    id5 int,
    name1 varchar,
    name2 varchar,
    name3 varchar,
    name4 varchar,
    name5 varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='stream_blood_eight',
    'sink.parallelism'='1'
 );
-- name blood_kafka_mysql_kafka
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-02-16 15:11:28
-- desc 
INSERT  
INTO
    kafkaResultTable
    SELECT
        o.id,
        o.id1,
        o.id2,
        o.id3,
        o.id4,
        o.id5,
        aggast_001(o.name1),
        o.name2,
        o.name3,
        o.name4,
        o.name5       
    FROM
        sourceTable o;

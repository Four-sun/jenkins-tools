


-- name backpress_new_test
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-02-21 19:30:07
-- desc 
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
    'topic'='dtstream_one',
    'scan.startup.mode'='earliest-offset'
 );
CREATE TABLE sourceTableOne(
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
    'topic'='dtstream_two',
    'scan.startup.mode'='earliest-offset'
 );
CREATE TABLE MyResult(
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
    'connector'='stream-x'
 );
INSERT  
INTO
    MyResult
    SELECT
        o.id as id,
        o.id1,
        o.id2,
        o.id3,
        o.id4,
        o.id5,
        s.name1 as name1,
        s.name2,
        s.name3,
        s.name4,
        s.name5       
    FROM
        sourceTable o            
    left join
        sourceTableOne s                                            
            on o.id = s.id;

CREATE TABLE sourceTable(
    id int,
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


-- name ICESource_ICEResult
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-12-30 16:15:10
-- desc
insert 
into
    stream_iceberg_one.stream_iceberg_db.sourcetableone
    select
        id,
        name,
        age 
    from
        sourceTable;

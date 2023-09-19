

CREATE TABLE kafkaResultTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu7',
    'sink.parallelism'='1'
 );
-- name ICESource_ICEResult
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-12-30 16:15:10
-- desc
insert 
into
    kafkaResultTable
    select
        id,
        name,
        age 
    from
        stream_iceberg_one.stream_iceberg_db.sourcetableone;



CREATE TABLE kafkaResultTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu2',
    'sink.parallelism'='1'
 );
-- name dtcatalog_stream_hwkafka
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-02-01 11:21:52
-- desc 

INSERT 
INTO
    kafkaResultTable
    select
        id,
        name,
        age 
    from
        stream_600_test.stream_db_600_fanshu.hwkafkasourcetable;

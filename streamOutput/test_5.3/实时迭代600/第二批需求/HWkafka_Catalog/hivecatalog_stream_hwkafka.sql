


-- name dtcatalog_stream_hwkafka
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-02-01 11:21:52
-- desc 

CREATE TABLE source(
    id int,
    name varchar,
    age int
 )WITH(
    'connector'='stream-x',
    'number-of-rows'='1000'
 );
INSERT 
INTO
    stream_600_test.stream_db_600_fanshu.hwkafkaresulttable
    select
        id,
        name,
        age 
    from
        source;


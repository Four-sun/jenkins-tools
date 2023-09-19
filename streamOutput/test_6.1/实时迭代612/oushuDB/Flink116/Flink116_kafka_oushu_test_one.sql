CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE oushuResultTable(
    id int,
    name varchar,
    age int
 )WITH(
    'password' = '******',
    'connector'='oushu-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='public',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='stream_test_one',
    'sink.parallelism'='1',
    'url'='jdbc:postgresql://172.16.83.170:5432/postgres',
    'username'='oushu'
 );
-- name Flink116_kafka_oushu_test_one
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-09-07 14:51:37
-- desc 
INSERT       
into
    oushuResultTable
    select
        st.id,
        st.name,
        st.age         
    from
        sourceTable st;


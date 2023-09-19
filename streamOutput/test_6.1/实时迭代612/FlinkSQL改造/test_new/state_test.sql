CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2fanshu2',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE kafkaResultOne(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='test_topic_name_nyuhpmvj',
    'sink.parallelism'='1'
 );
-- name FlinkSQL112_sourceKafka_sideMysql_sinkMysql
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-17 11:04:01
-- desc FlinkSQL112_sourceKafka_sideMysql_sinkMysql
INSERT 
INTO
    kafkaResultOne
    select
        st.id,
        st.name,
        st.age
    from
        sourceTable st

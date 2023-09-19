CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE phoenixSinkTable(
    ID BIGINT,
    NAME VARCHAR,
    AGE VARCHAR,
    PRIMARY KEY(ID) NOT ENFORCED
 )WITH(
    'connector'='phoenix5-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='true',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='TEST_RES_2022_10000',
    'sink.parallelism'='1',
    'url'='jdbc:phoenix:172.16.83.242:2181'
 );
-- name FlinkSQL116_sourceKafka_sinkPhoenix5x
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 12:45:48
-- desc 
INSERT 
INTO
    phoenixSinkTable
    select
        st.id ,
        st.name as name,
        cast(st.age as varchar) as age
    from
        sourceTable st;

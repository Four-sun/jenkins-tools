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
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE esSideTable(
    id int,
    name varchar,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='elasticsearch7-x',
    'lookup.cache-type'='LRU',
    'hosts'='172.16.100.243:9200',
    'lookup.parallelism'='2',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'index'='stream_test'
 );
CREATE TABLE kafkaResultOne(
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
-- name Flink116_kafka_mysql
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-07-17 15:03:55
-- desc
INSERT 
INTO
    kafkaResultOne
    select
        st.id,
        mst.name as name,
        st.id as age 
    from
        sourceTable st
    left join
        fanshuCatalog.fanshuDatabase.esSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;

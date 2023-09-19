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
    'topic'='mizhi001',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE mongoSIdeTable(
    id int,
    name varchar,
    age int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'database'='test',
    'connector'='mongodb-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'collection'='test_result_table_name_sfragulv',
    'uri'='mongodb://172.16.101.246:27017'
 );
CREATE TABLE mongoResultTable(
    id int,
    name varchar,
    age int
 )WITH(
    'database'='test',
    'connector'='mongodb-x',
    'collection'='test_result_table_name_yozdqlmu',
    'sink.parallelism'='1',
    'uri'='mongodb://172.16.101.246:27017'
 );
-- desc MongoDB维表
INSERT 
INTO
    mongoResultTable
    select
        st.id,
        mst.name as name,
        st.id as age 
    from
        sourceTable st
    left join
        mongoSIdeTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;



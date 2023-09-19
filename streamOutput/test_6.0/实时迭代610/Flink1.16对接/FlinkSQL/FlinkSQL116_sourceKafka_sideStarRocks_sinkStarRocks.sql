CREATE TABLE sourceTable(
    id varchar,
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
CREATE TABLE starrocksSideTable(
    id string,
    gender string,
    source string,
    str1 string,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='starrocks-x',
    'lookup.cache-type'='LRU',
    'schema-name'='flinkx_test',
    'lookup.parallelism'='1',
    'feNodes'='172.16.82.221:8030',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='starrocks_test_63704',
    'url'='jdbc:mysql://172.16.82.221:9030',
    'username'='root'
 );
CREATE TABLE starrocksResultTable(
    id string,
    gender string,
    source string,
    str1 string
 )WITH(
    'password' = '******',
    'connector'='starrocks-x',
    'schema-name'='flinkx_test',
    'feNodes'='172.16.82.221:8030',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='starrocks_test_63651',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.82.221:9030',
    'username'='root'
 );
-- name FlinkSQL116_sourceKafka_sideStarRocks_sinkStarRocks
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 11:04:12
-- desc 
-- desc StarRocks维表
-- INSERT 
-- INTO
--     starrocksResultTable
--     select
--         cast(st.id as varchar) as id ,
--         mst.gender ,
--         mst.source,
--         mst.str1 
--     from
--         sourceTable st
--     left join
--         starrocksSideTable for SYSTEM_TIME as of st.proc_time as mst 
--             on st.id = mst.id;


INSERT 
INTO
    starrocksResultTable
    select
        cast(st.id as varchar) as id ,
        st.name as gender ,
        st.name as source,
        st.name as str1 
    from
        sourceTable st;


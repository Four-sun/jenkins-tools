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
    'topic'='fanshu5',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE mysqlSideTable(
    id bigint,
    name string,
    age bigint,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='mizhi_side1_0817',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE mysqlResultTableOne(
    id bigint,
    name string,
    age bigint
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='mizhi_test1_0817',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
-- name FlinkSQL116_sourceKafka_sideMysql_sinkMysql
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-19 15:36:44
-- desc FlinkSQL116_sourceKafka_sideMysql_sinkMysql
INSERT 
INTO
    mysqlResultTableOne
    select
        st.id,
        mst.name,
        mst.age
    from
        sourceTable st
    left join
        mysqlSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;

-- INSERT 
-- INTO
--     mysqlResultTableTwo
--     select
--         st.id,
--         mst.varchar_data
--     from
--         sourceTable st
--     left join
--         mysqlSideTable for SYSTEM_TIME as of st.proc_time as mst 
--             on st.id = mst.id;

-- INSERT 
-- INTO
--     mysqlResultTableThree
--     select
--         st.id,
--         mst.varchar_data
--     from
--         sourceTable st
--     left join
--         mysqlSideTable for SYSTEM_TIME as of st.proc_time as mst 
--             on st.id = mst.id;

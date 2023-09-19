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
CREATE TABLE mysqlSideTable(
    id int,
    int_data int,
    varchar_data string,
    timestamp_data timestamp,
    PRIMARY KEY(int_data) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='side_112_mysql_all_type_table',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE kafkaResultOne(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu4',
    'sink.parallelism'='1'
 );
-- name FlinkSQL116_sourceKafka_sideMysql_sinkMysql
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-19 15:36:44
-- desc FlinkSQL116_sourceKafka_sideMysql_sinkMysql
-- INSERT 
-- INTO
--     mysqlResultTableOne
--     select
--         st.id,
--         mst.varchar_data
--     from
--         sourceTable st
--     left join
--         mysqlSideTable for SYSTEM_TIME as of st.proc_time as mst 
--             on st.id = mst.id;

INSERT 
INTO
    kafkaResultOne
    select
        st.id,
        st.name,
        st.age 
    from
        sourceTable st

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

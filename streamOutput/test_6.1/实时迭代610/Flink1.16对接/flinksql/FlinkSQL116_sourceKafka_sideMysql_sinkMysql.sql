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
    'topic'='fanshu7',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE mysqlSideTable(
    id bigint,
    int_data bigint,
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
    'table-name'='result_112_mysql_all_type_table',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE mysqlResultTableOne(
    id bigint,
    varchar_data string
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='stream_mysql_ogg_one',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE mysqlResultTableTwo(
    id bigint,
    varchar_data string,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='stream_mysql_ogg_two',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE mysqlResultTableThree(
    id bigint,
    varchar_data string,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='stream_mysql_ogg_three',
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
        mst.varchar_data
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

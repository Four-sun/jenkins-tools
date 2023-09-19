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
CREATE TABLE impalaSideTable(
    id int,
    start_time varchar,
    start_date varchar,
    start_timestamp timestamp,
    end_time varchar,
    end_date varchar,
    end_timestamp timestamp,
    age int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='impala-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'schema-name'='default',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='impala_fanshu_test_3',
    'url'='jdbc:impala://172.16.100.32:21050/default;AuthMech=0'
 );
CREATE TABLE impalaResultTableOne(
    id int,
    name varchar,
    age int
 )WITH(
    'connector'='impala-x',
    'schema-name'='default',
    'table-name'='impala_fanshu_test_4',
    'sink.parallelism'='1',
    'url'='jdbc:impala://172.16.100.32:21050/default;AuthMech=0'
 );
-- name FlinkSQL116_sourceKafka_sideImpala_sinkImpala
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 11:22:28
-- desc 
-- desc Impala维表
INSERT 
INTO
    impalaResultTableOne
    select
        st.id,
        mst.start_time as name,
        mst.age as age 
    from
        sourceTable st
    left join
        impalaSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;

-- INSERT 
-- INTO
--     impalaResultTableTwo
--     select
--         st.id,
--         mst.start_time as name,
--         mst.age as age 
--     from
--         sourceTable st
--     left join
--         impalaSideTable for SYSTEM_TIME as of st.proc_time as mst 
--             on st.id = mst.id;


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
CREATE TABLE sourceTableOne(
    id int,
    name varchar,
    age int,
    start_time timestamp,
    WATERMARK FOR start_time AS start_time - INTERVAL'10'SECOND,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='test_topic_name_gcwfybte',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE sourceTableTwo(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'scan.startup.timestamp-millis'='1673355324056',
    'topic'='test_topic_name_wtzaudhp',
    'scan.startup.mode'='timestamp'
 );
CREATE TABLE sourceTableThree(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'scan.startup.specific-offsets'='partition:0,offset:43',
    'format'='csv',
    'topic'='test_topic_name_bxronphj',
    'scan.startup.mode'='specific-offsets'
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
    'lookup.parallelism'='2',
    'schema-name'='default',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='impala_fanshu_test_3',
    'url'='jdbc:impala://172.16.100.32:21050/default;AuthMech=0'
 );
CREATE TABLE impalaResultTableOne(
    id int,
    name varchar,
    age int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='impala-x',
    'schema-name'='default',
    'table-name'='impala_fanshu_test_4',
    'sink.parallelism'='1',
    'url'='jdbc:impala://172.16.100.32:21050/default;AuthMech=0'
 );
CREATE TABLE impalaResultTableTwo(
    id int,
    name varchar,
    age_1 decimal,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='impala-x',
    'schema-name'='default',
    'table-name'='impala_fanshu_test_4',
    'sink.parallelism'='1',
    'url'='jdbc:impala://172.16.100.32:21050/default;AuthMech=0'
 );
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


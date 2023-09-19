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
CREATE TABLE clickhouseSideTable(
    id int,
    name varchar,
    idcard varchar,
    birthday date,
    mobile varchar,
    email varchar,
    gender int,
    create_time STRING,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='clickhouse-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='basic_data_1w',
    'url'='jdbc:clickhouse://172.16.21.76:8123/test',
    'username'='default'
 );
CREATE TABLE clickhouseResultTable(
    id int,
    name varchar,
    gender int
 )WITH(
    'connector'='clickhouse-x',
    'sink.buffer-flush.interval'='1000',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='basic_data_1w_two',
    'sink.parallelism'='1',
    'url'='jdbc:clickhouse://172.16.21.76:8123/test',
    'username'='default'
 );
-- name FlinkSQL112_sourceKafka_sideclickhouse_sinkclickhouse
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-22 13:43:36
-- desc FlinkSQL112_sourceKafka_sideclickhouse_sinkclickhouse
INSERT 
INTO
    clickhouseResultTable
    select
        st.id,
        mst.name as name,
        mst.gender
    from
        sourceTable st
    left join
        clickhouseSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;


CREATE TABLE sourceTable(
    id varchar,
    name varchar,
    age varchar,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='4',
    'format'='json',
    'topic'='dtstream_six',
    'scan.startup.mode'='earliest-offset'
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
    'topic'='dtstream_four',
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
CREATE TABLE Hbase1SideTable(
    rowkey string,
    cf ROW<id string,
    name varchar,
    age int>,
    rowkey string,
    PRIMARY KEY(rowkey) NOT ENFORCED
 )WITH(
    'connector'='hbase14-x',
    'lookup.cache-type'='LRU',
    'zookeeper.quorum'='172.16.83.84:2181,172.16.83.101:2181,172.16.83.201:2181',
    'lookup.parallelism'='1',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='fanshu_test_1'
 );
CREATE TABLE kafkaResultTable(
    st_id int,
    st_age varchar,
    mst_name varchar,
    mst_id int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='dtstream_four',
    'sink.parallelism'='1'
 );
-- name FlinkSQL112_sourceKafka_sideHbase1_sinkKafka
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-17 16:11:41
-- desc FlinkSQL112_sourceKafka_sideHbase1_sinkKafka
INSERT 
INTO
    kafkaResultTable
    select
        cast(st.id as int) as st_id,
        st.age as st_age,
        mst.name as mst_name,
        cast(mst.id as int) as mst_id
    from
        sourceTable st
    left join
        Hbase1SideTable for SYSTEM_TIME as of st.proc_time as mst 
            on CONCAT('fanshu', st.age) = mst.rowkey;


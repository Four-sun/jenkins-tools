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
CREATE TABLE kuduSideTable(
    id INT,
    name STRING,
    idcard INT,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='kudu-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'lookup.cache.ttl'='60000',
    'masters'='172.16.100.109:7051',
    'lookup.cache.max-rows'='10000',
    'table-name'='fanshu1'
 );
CREATE TABLE kuduResultTableOne(
    id STRING,
    name STRING
 )WITH(
    'connector'='kudu-x',
    'sink.buffer-flush.interval'='1000',
    'masters'='172.16.100.109:7051',
    'session.mutation-buffer-space'='100',
    'table-name'='fanshuDemoOne',
    'sink.parallelism'='1'
 );
CREATE TABLE kuduResultTableTwo(
    id STRING,
    name STRING,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'sink.write-mode'='upsert',
    'connector'='kudu-x',
    'sink.buffer-flush.interval'='1000',
    'masters'='172.16.100.109:7051',
    'session.mutation-buffer-space'='100',
    'table-name'='fanshuDemoOne',
    'sink.parallelism'='1'
 );
-- name FlinkSQL112_sourceKafka_sidekudu_sinkkudu
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-22 13:43:36
-- desc FlinkSQL112_sourceKafka_sidekudu_sinkkudu
INSERT 
INTO
    kuduResultTableOne
    select
        cast(st.id as varchar) as id,
        mst.name as name
    from
        sourceTable st
    left join
        kuduSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;
INSERT 
INTO
    kuduResultTableTwo
    select
        cast(st.id as varchar) as id,
        mst.name as name
    from
        sourceTable st
    left join
        kuduSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;


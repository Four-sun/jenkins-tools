CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='2',
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
CREATE TABLE esSideTable(
    id int,
    name varchar,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='elasticsearch7-x',
    'lookup.cache-type'='LRU',
    'hosts'='172.16.100.243:9200',
    'lookup.parallelism'='2',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'index'='stream_test'
 );
CREATE TABLE esResultTable(
    id int,
    name varchar,
    age int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='elasticsearch7-x',
    'sink.bulk-flush.max-actions'='100',
    'hosts'='172.16.100.243:9200',
    'index'='fanshu_test',
    'sink.parallelism'='2'
 );
-- desc ES7维表
INSERT 
INTO
    esResultTable
    select
        st.id,
        mst.name as name,
        st.id as age 
    from
        sourceTable st
    left join
        esSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;



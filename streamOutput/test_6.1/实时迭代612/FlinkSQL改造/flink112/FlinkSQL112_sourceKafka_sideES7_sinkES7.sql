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
    'topic'='mizhi',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE esSideTable(
    id int,
    name varchar
 )WITH(
    'connector'='elasticsearch7-x',
    'lookup.cache-type'='LRU',
    'hosts'='172.16.100.243:9200',
    'lookup.parallelism'='1',
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
    'sink.parallelism'='1'
 );
-- name FlinkSQL116_sourceKafka_sideES7_sinkES7
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 16:06:36
-- desc 
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



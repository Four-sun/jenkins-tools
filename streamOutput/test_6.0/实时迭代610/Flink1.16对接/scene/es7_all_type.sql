


-- 已验证完成
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
    'topic'='source_112_es7_all_type',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE esResultTable(
    id int,
    username varchar,
    gender int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='elasticsearch7-x',
    'sink.bulk-flush.max-actions'='100',
    'hosts'='172.16.100.243:9200',
    'index'='stream_es_result_table',
    'sink.parallelism'='1'
 );
CREATE TABLE esSideTable(
    id int,
    username varchar,
    gender int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='elasticsearch7-x',
    'lookup.cache-type'='LRU',
    'hosts'='172.16.100.243:9200',
    'lookup.parallelism'='1',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'index'='stream_es_side_table'
 );
INSERT
INTO
    esResultTable
    select
        st.id,
        mst.username as username,
        mst.gender as gender
    from
        sourceTable st
    left join
        esSideTable for SYSTEM_TIME as of st.proc_time as mst
            on st.id = mst.id;


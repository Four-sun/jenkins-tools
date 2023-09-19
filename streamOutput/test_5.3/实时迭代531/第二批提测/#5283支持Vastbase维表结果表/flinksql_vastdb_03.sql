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
CREATE TABLE vastSideTable(
    id bigint,
    smallint_data int,
    integer_data int,
    bigint_data bigint,
    varchar_10_data varchar,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='postgresql-x',
    'lookup.cache-type'='LRU',
    'schema-name'='testuser',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='source_112_vast_all_type',
    'url'='jdbc:postgresql://172.16.84.251:5432/postgres',
    'username'='testuser'
 );
CREATE TABLE vastResultTable(
    id bigint,
    smallint_data int,
    integer_data int,
    bigint_data bigint,
    varchar_10_data varchar
 )WITH(
    'password' = '******',
    'connector'='postgresql-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='testuser',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_vast_all_type_two',
    'sink.parallelism'='1',
    'url'='jdbc:postgresql://172.16.84.251:5432/postgres',
    'username'='testuser'
 );
-- name flinksql_vastdb_01
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-11-28 16:15:03
-- desc
INSERT   
INTO
    vastResultTable
    select
        st.id,
        vst.smallint_data,
        vst.integer_data,
        vst.bigint_data,
        vst.varchar_10_data
    from
        sourceTable st           
    left join
        vastSideTable for SYSTEM_TIME as of st.proc_time as vst                   
            on st.id = vst.id;

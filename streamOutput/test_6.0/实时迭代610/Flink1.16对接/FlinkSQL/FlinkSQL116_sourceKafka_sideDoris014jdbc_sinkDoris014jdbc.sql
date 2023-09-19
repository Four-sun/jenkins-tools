CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='2',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE dorisSideTable(
    id int,
    int_data int,
    bigint_data bigint,
    decimal_data decimal,
    varchar_data string,
    timestamp_data timestamp,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='doris-x',
    'lookup.cache-type'='LRU',
    'schema-name'='automation',
    'lookup.parallelism'='2',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='mysql_flink_cdc_test_one',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE dorisResultTableOne(
    id int,
    int_data int,
    varchar_data string
 )WITH(
    'password' = '******',
    'connector'='doris-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='automation',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='flink_catalog_one',
    'sink.parallelism'='2',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
-- name FlinkSQL116_sourceKafka_sideDoris014jdbc_sinkDoris014jdbc
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 11:11:42
-- desc 
INSERT  
INTO
    dorisResultTableOne
    select
        st.id,
        mst.int_data,
        mst.varchar_data     
    from
        sourceTable st     
    left join
        dorisSideTable for SYSTEM_TIME as of st.proc_time as mst              
            on st.id = mst.id;

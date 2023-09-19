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
CREATE TABLE SqlServerSideTable(
    id int,
    name STRING,
    age int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='sqlserver-x',
    'lookup.cache-type'='LRU',
    'schema-name'='dbo',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='mizhi_side_1',
    'url'='jdbc:sqlserver://172.16.101.246:1433;database=TestDB',
    'username'='sa'
 );
CREATE TABLE SqlServerTableOne(
    id int,
    name STRING,
    age int
 )WITH(
    'password' = '******',
    'connector'='sqlserver-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='dbo',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='mizhi_result_1',
    'sink.parallelism'='1',
    'url'='jdbc:sqlserver://172.16.101.246:1433;database=TestDB',
    'username'='sa'
 );
-- name FlinkSQL112_sourceKafka_sideMysql_sinkMysql
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-17 11:04:01
-- desc FlinkSQL112_sourceKafka_sideMysql_sinkMysql
INSERT 
INTO
    SqlServerTableOne
    select
        st.id,
        mst.name,
        mst.age
    from
        sourceTable st
    left join
        SqlServerSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;



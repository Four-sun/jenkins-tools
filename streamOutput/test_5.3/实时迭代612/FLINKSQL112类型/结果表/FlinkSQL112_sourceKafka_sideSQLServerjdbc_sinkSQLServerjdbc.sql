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
CREATE TABLE sqlserverSideTable(
    id bigint,
    varchar_255_data varchar,
    int_data int,
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
    'table-name'='source_112_sqlserver_all_type',
    'url'='jdbc:sqlserver://172.16.101.246:1433;database=db_test',
    'username'='sa'
 );
CREATE TABLE sqlserverResultTableOne(
    id bigint,
    varchar_255_data varchar,
    int_data int
 )WITH(
    'password' = '******',
    'connector'='sqlserver-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='dbo',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_sqlserver_all_type',
    'sink.parallelism'='1',
    'url'='jdbc:sqlserver://172.16.101.246:1433;database=db_test',
    'username'='sa'
 );
CREATE TABLE sqlserverResultTableTwo(
    id bigint,
    varchar_data varchar,
    int_data int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='sqlserver-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='dbo',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_sqlserver_all_type',
    'sink.parallelism'='1',
    'url'='jdbc:sqlserver://172.16.101.246:1433;database=db_test',
    'username'='sa'
 );
CREATE TABLE sqlserverResultTableThree(
    id bigint,
    varchar_data varchar,
    int_data int,
    PRIMARY KEY(id,varchar_data) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='sqlserver-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='dbo',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_sqlserver_all_type',
    'sink.parallelism'='1',
    'url'='jdbc:sqlserver://172.16.101.246:1433;database=db_test',
    'username'='sa'
 );
-- name FlinkSQL112_sourceKafka_sideSQLServerjdbc_sinkSQLServerjdbc
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-22 13:43:36
-- desc FlinkSQL112_sourceKafka_sideSQLServerjdbc_sinkSQLServerjdbc
INSERT 
INTO
    sqlserverResultTableOne
    select
        st.id,
        mst.varchar_255_data,
        mst.int_data
    from
        sourceTable st
    left join
        sqlserverSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;
INSERT 
INTO
    sqlserverResultTableTwo
    select
        st.id,
        mst.varchar_255_data,
        mst.int_data
    from
        sourceTable st
    left join
        sqlserverSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;
INSERT 
INTO
    sqlserverResultTableThree
    select
        st.id,
        mst.varchar_255_data,
        mst.int_data
    from
        sourceTable st
    left join
        sqlserverSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;


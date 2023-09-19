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
    'SYSTEM_TIME'='SYSTEM_TIME',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE oracleSideTableOne(
    ID decimal(38,0) ,
    VARCHAR_255 varchar,
    DATE_DATA timestamp,
    TIMESTAMP_DATA timestamp,
    PRIMARY KEY(ID) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='oracle-x',
    'lookup.cache-type'='LRU',
    'schema-name'='SHIXIAO',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='FLINKX_CDC_ALL_TYPE',
    'url'='jdbc:oracle:thin:@172.16.100.243:1521:orcl',
    'username'='shixiao'
 );
CREATE TABLE oracleResultTableOne(
    ID decimal(38,0) ,
    NAME varchar
 )WITH(
    'password' = '******',
    'connector'='oracle-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='SHIXIAO',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='FLINKX_CDC_ONE',
    'sink.parallelism'='1',
    'url'='jdbc:oracle:thin:@172.16.100.243:1521:orcl',
    'username'='shixiao'
 );
-- name FlinkSQL116_sourceKafka_sideOralce_sinkOracle
INSERT 
INTO
    oracleResultTableOne
    select
        st.id as ID,
        mst.VARCHAR_255 as NAME
    from
        sourceTable st
    left join
        oracleSideTableOne for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.ID;

-- INSERT 
-- INTO
--     oracleResultTableTwo
--     select
--         st.id as ID,
--         mst.VARCHAR_255 as NAME
--     from
--         sourceTable st
--     left join
--         oracleSideTableOne for SYSTEM_TIME as of st.proc_time as mst 
--             on st.id = mst.ID;

-- INSERT 
-- INTO
--     oracleResultTableThree
--     select
--         st.id as ID,
--         mst.VARCHAR_255 as NAME
--     from
--         sourceTable st
--     left join
--         oracleSideTableOne for SYSTEM_TIME as of st.proc_time as mst 
--             on st.id = mst.ID;

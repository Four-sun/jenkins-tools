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
    'topic'='mizhi1',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE kingbaseSideTable(
    expr varchar,
    parttype int,
    PRIMARY KEY(parttype) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='kingbase-x',
    'lookup.cache-type'='LRU',
    'schema-name'='PUBLIC',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='pathman_config',
    'url'='jdbc:kingbase8://172.16.83.182:54321/TEST',
    'username'='SYSTEM'
 );
CREATE TABLE kingbaseResultTableOne(
    id int,
    varchar_data varchar
 )WITH(
    'password' = '******',
    'connector'='kingbase-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='PUBLIC',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='kingbaseFanshuOne',
    'sink.parallelism'='1',
    'url'='jdbc:kingbase8://172.16.83.182:54321/TEST',
    'username'='SYSTEM'
 );
-- name FlinkSQL116_sourceKafka_sideKingbaseES8_sinkKingbaseES8
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 10:40:05
-- desc 
-- desc FlinkSQL112_sourceKafka_sideKingbaseES8_sinkKingbaseES8
INSERT  
INTO
    kingbaseResultTableOne
    select
        st.id,
        mst.expr as varchar_data  
    from
        sourceTable st     
    left join
        kingbaseSideTable for SYSTEM_TIME as of st.proc_time as mst              
            on st.id = mst.parttype;
-- INSERT  
-- INTO
--     kingbaseResultTableTwo
--     select
--         st.id,
--         mst.name as name,
--         mst.age as age ,
--         mst.start_time as start_time     
--     from
--         sourceTable st     
--     left join
--         kingbaseSideTable for SYSTEM_TIME as of st.proc_time as mst              
--             on st.id = mst.id;
-- INSERT  
-- INTO
--     kingbaseResultTableThree
--     select
--         st.id,
--         mst.name as name,
--         mst.age as age ,
--         mst.start_time as start_time     
--     from
--         sourceTable st     
--     left join
--         kingbaseSideTable for SYSTEM_TIME as of st.proc_time as mst              
--             on st.id = mst.id;

CREATE TABLE sourceTable(
    id int,
    name varchar,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE mysqlSideTable(
    id bigint,
    varchar_data string,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='stream_mysql_ogg_one',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE kafkaResultTable(
    id int,
    name varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu7',
    'sink.parallelism'='1'
 );
-- name FlinkSQL_checkpoint_1
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-02-16 11:33:11
-- desc FlinkSQL_checkpoint_1
-- INSERT   
-- INTO
--     kafkaResultTable
--     select
--         id,
--         name
--     from
--         sourceTable;
;
INSERT 
INTO
    kafkaResultTable
    select
        st.id,
        mst.varchar_data as name
    from
        sourceTable st 
    left JOIN  mysqlSideTable for SYSTEM_TIME as of st.proc_time as mst 
    on st.id = mst.id;
         

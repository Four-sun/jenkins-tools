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
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE redisSideTable(
    id int,
    name varchar,
    age int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'database'='0',
    'master-name'='mymaster',
    'connector'='redis-x',
    'lookup.parallelism'='1',
    'redis-type'='2',
    'table-name'='fanshu_test_1',
    'url'='172.16.82.144:26379'
 );
CREATE TABLE redisResultTable(
    id int,
    name varchar,
    age int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'mode'='hset',
    'password' = '******',
    'database'='0',
    'master-name'='mymaster',
    'connector'='redis-x',
    'redis-type'='2',
    'table-name'='stream_test_1',
    'sink.parallelism'='1',
    'type'='string',
    'url'='172.16.82.144:26379'
 );
-- name FlinkSQL116_sourceKafka_sideRedis_sinkRedis
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 11:24:33
-- desc 
INSERT 
INTO
    redisResultTable
    select
        cast(st.id as int) id,
        mst.name as name,
        cast(mst.age as int) as age 
    from
        sourceTable st
    left join
        redisSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id ;



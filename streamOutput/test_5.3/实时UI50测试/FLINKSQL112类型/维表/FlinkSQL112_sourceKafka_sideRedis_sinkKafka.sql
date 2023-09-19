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
CREATE TABLE kafkaResultTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='csv',
    'key.format'='json',
    'topic'='fanshu3',
    'sink.parallelism'='1',
    'key.fields'='id',
    'sink.partitioner'='com.dtstack.chunjun.connector.kafka.partitioner.CustomerFlinkPartition'
 );
-- desc Redis维表
INSERT 
INTO
    kafkaResultTable
    select
        cast(st.id as int) id,
        mst.name as name,
        cast(mst.age as int) as age 
    from
        sourceTable st
    left join
        redisSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id ;



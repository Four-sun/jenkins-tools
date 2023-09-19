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

CREATE TABLE kafkaResult(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu7',
    'sink.parallelism'='1'
 );
-- name hmscatalog_kafka_iceberg
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-29 14:10:49
-- desc
INSERT   
INTO
    kafkaResult
    select
        st.id,
        mst.name,
        st.age          
    from
        sourceTable st               
    LEFT JOIN
        fanshuCatalog10.fanshuDatabase10.esSideTable for SYSTEM_TIME as of st.proc_time as mst                   
            ON st.id =mst.id;

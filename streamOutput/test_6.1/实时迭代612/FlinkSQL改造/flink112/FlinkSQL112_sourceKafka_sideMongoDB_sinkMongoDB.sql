CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='mizhi',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE mongoResultTable(
    id int,
    name varchar,
    age int
 )WITH(
    'database'='test',
    'connector'='mongodb-x',
    'collection'='test_result_table_name_bdfgaqik',
    'sink.parallelism'='1',
    'uri'='mongodb://172.16.101.246:27017'
 );
-- name FlinkSQL116_sourceKafka_sideMongoDB_sinkMongoDB
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 11:43:54
-- desc 
-- desc MongoDB维表
-- INSERT 
-- INTO
--     mongoResultTable
--     select
--         st.id,
--         mst.name as name,
--         st.id as age 
--     from
--         sourceTable st
--     left join
--         mongoSIdeTable for SYSTEM_TIME as of st.proc_time as mst 
--             on st.id = mst.id;



INSERT 
INTO
    mongoResultTable
    select
        st.id,
        st.name as name,
        st.id as age 
    from
        sourceTable st


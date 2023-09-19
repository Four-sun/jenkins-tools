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
        mst.name as name,
        mst.age as age ,
        mst.start_time as start_time     
    from
        sourceTable st     
    left join
        kingbaseSideTable for SYSTEM_TIME as of st.proc_time as mst              
            on st.id = mst.id;
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

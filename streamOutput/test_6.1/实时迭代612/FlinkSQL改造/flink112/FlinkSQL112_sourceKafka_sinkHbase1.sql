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

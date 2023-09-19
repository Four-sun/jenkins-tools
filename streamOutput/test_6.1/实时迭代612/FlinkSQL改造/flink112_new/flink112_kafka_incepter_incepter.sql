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


-- desc Doris014jdbc维表
INSERT 
INTO
    inceptorResultTable
    select
        st.id as id,
        mst.name as name,
        mst.age as age 
    from
        sourceTable st
    left join
        inceptorSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;



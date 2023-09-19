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


INSERT 
INTO
    verticaResultTableOne
    SELECT
        st.id,
        st.name as varchar_data     
    FROM
        sourceTable st;

-- INSERT 
-- INTO
--     verticaResultTableTwo
--     SELECT
--         st.id,
--         st.name as varchar_data     
--     FROM
--         sourceTable st;
    
-- INSERT 
-- INTO
--     verticaResultTableThree
--     SELECT
--         st.id,
--         st.name as varchar_data     
--     FROM
--         sourceTable st;

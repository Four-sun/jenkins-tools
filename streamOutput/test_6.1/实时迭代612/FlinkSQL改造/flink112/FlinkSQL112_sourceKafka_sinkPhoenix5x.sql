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


-- name FlinkSQL116_sourceKafka_sinkPhoenix5x
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 12:45:48
-- desc 
INSERT 
INTO
    phoenixSinkTable
    select
        st.id ,
        st.name as name,
        cast(st.age as varchar) as age
    from
        sourceTable st;

CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int,
    address varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );


-- name FlinkSQL116_sourceKafka_sinkhive2_bak
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 14:12:27
-- desc 
INSERT  
INTO
    hiveResultTableOne
    select
        st.id,
        st.name,
        st.age,
        st.address     
    from
        sourceTable st;




CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE kafkaResultTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu4',
    'sink.parallelism'='1'
 );
-- name flinksql_session_2
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-11-23 11:55:01
-- desc 
select
    st.id,
    st.name,
    st.age         
from
    sourceTable st;


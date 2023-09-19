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

CREATE TABLE vastdbResultTable(
    id bigint,
    varchar_10_data varchar
 )WITH(
    'password' = '******',
    'connector'='postgresql-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='testuser',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_vast_all_type_three',
    'sink.parallelism'='1',
    'url'='jdbc:postgresql://172.16.84.251:5432/postgres',
    'username'='testuser'
 );
-- name flinksql_vastdb_01
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-11-28 16:15:03
-- desc
INSERT 
INTO
    vastdbResultTable
    select
        st.id as id,
        st.name as varchar_10_data 
    from
        sourceTable st;

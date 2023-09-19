CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='mizhi001',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE starrocksResultTable(
    id string,
    gender string,
    source string,
    str1 string
 )WITH(
    'password' = '******',
    'connector'='starrocks-x',
    'schema-name'='flinkx_test',
    'feNodes'='172.16.82.221:8030',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='starrocks_test_63651',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.82.221:9030',
    'username'='root'
 );

INSERT 
INTO
    starrocksResultTable
    select
        cast(st.id as varchar) as id ,
        st.name as gender ,
        st.name as source,
        st.name as str1 
    from
        sourceTable st;


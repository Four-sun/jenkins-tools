CREATE TABLE sourceTable(
    id varchar,
    name varchar,
    age varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='mizhi001',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE sink(
    ID VARCHAR,
    NAME VARCHAR,
    AGE VARCHAR,
    PRIMARY KEY(ID) NOT ENFORCED
 )WITH(
    'connector'='phoenix5-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='CASE_68691',
    'sink.parallelism'='1',
    'url'='jdbc:phoenix:172.16.83.242:2181'
 );
-- desc FlinkSQL112_sourceKafka_sinkSolr
INSERT 
INTO
    sink
    SELECT
        st.id,
        st.name,
        st.age    
    FROM
        sourceTable st;

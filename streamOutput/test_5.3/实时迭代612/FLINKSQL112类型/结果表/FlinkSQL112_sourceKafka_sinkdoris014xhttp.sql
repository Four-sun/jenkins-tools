CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE dorisResultTable(
    id INT,
    name VARCHAR(256) 
 )WITH(
    'connector'='doris-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='flinkx_test',
    'feNodes'='172.16.83.193:8030',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='test002',
    'sink.parallelism'='1',
    'username'='root'
 );
-- name FlinkSQL112_sourceKafka_sinkdoris014xhttp
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-22 13:43:36
-- desc FlinkSQL112_sourceKafka_sinkdoris014xhttp
INSERT 
INTO
    dorisResultTable
    SELECT
        st.id,
        st.name     
    FROM
        sourceTable st;


CREATE TABLE sourceTable(
    id int,
    name varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='mizhi',
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
INSERT 
INTO
    dorisResultTable
    SELECT
        st.id,
        st.name     
    FROM
        sourceTable st;


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

CREATE TABLE verticaResultTableOne(
    id INT,
    varchar_data STRING
 )WITH(
    'password' = '******',
    'connector'='vertica11-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='public',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='vertica_data_type_test_four',
    'sink.parallelism'='1',
    'url'='jdbc:vertica://172.16.83.182:5433/',
    'username'='dbadmin'
 );
CREATE TABLE verticaResultTableTwo(
    id INT,
    varchar_data STRING,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='vertica11-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='public',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='vertica_data_type_test_four',
    'sink.parallelism'='1',
    'url'='jdbc:vertica://172.16.83.182:5433/',
    'username'='dbadmin'
 );
CREATE TABLE verticaResultTableThree(
    id INT,
    varchar_data STRING,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='vertica11-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='public',
    'sink.all-replace'='true',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='vertica_data_type_test_four',
    'sink.parallelism'='1',
    'url'='jdbc:vertica://172.16.83.182:5433/',
    'username'='dbadmin'
 );
-- desc FlinkSQL112_sourceKafka_sinkVertica
INSERT 
INTO
    verticaResultTableOne
    SELECT
        st.id,
        st.name as varchar_data     
    FROM
        sourceTable st;

INSERT 
INTO
    verticaResultTableTwo
    SELECT
        st.id,
        st.name as varchar_data     
    FROM
        sourceTable st;
    
INSERT 
INTO
    verticaResultTableThree
    SELECT
        st.id,
        st.name as varchar_data     
    FROM
        sourceTable st;

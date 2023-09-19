CREATE TABLE sourceTable(
    id INT,
    name VARCHAR,
    age DECIMAL,
    address VARCHAR,
    school VARCHAR,
    message VARCHAR,
    start_time TIMESTAMP,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='dtstream_two',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE mysqlSideTable(
    id INT,
    name VARCHAR,
    age DECIMAL(10,2) ,
    address VARCHAR,
    school VARCHAR,
    message VARCHAR,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='base_c_sidetableone',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE kafkaResultTable(
    id INT,
    name VARCHAR,
    age DECIMAL,
    address VARCHAR,
    school VARCHAR,
    message VARCHAR,
    start_time TIMESTAMP,
    end_time TIMESTAMP
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='dtstream_four',
    'sink.parallelism'='1'
 );
CREATE TABLE kafkaResultTableOne(
    id INT,
    name VARCHAR,
    age DECIMAL,
    address VARCHAR,
    school VARCHAR,
    message VARCHAR,
    start_time TIMESTAMP,
    end_time TIMESTAMP
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='dtstream_three',
    'sink.parallelism'='1'
 );
-- name blood_kafka_mysql_kafka
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-02-16 15:11:28
-- desc 
INSERT
INTO
    kafkaResultTable
    SELECT
        st.id,
        st.name,
        st.age as age,
        mst.address,
        mst.school,
        mst.message,
        mst.start_time,
        mst.end_time
    FROM
        sourceTable st
    LEFT JOIN
        mysqlSideTable FOR SYSTEM_TIME AS OF st.proc_time mst
            ON st.id = mst.id;

INSERT
INTO
    kafkaResultTableOne
    SELECT
        st.id,
        st.name,
        st.age as age,
        mst.address,
        mst.school,
        mst.message,
        mst.start_time,
        mst.end_time
    FROM
        sourceTable st
    LEFT JOIN
        mysqlSideTable FOR SYSTEM_TIME AS OF st.proc_time mst
            ON st.id = mst.id;

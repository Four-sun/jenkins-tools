


-- 失败已提交
CREATE TABLE MyTable(
    id int,
    name varchar,
    age varchar,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_join_constant',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyResult(
    mt_id INT,
    st_name VARCHAR,
    st_time_info VARCHAR
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_join_constant_resulttable',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE SideTable(
    id INT,
    channel VARCHAR,
    time_info VARCHAR,
    name VARCHAR,
    price DOUBLE,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='join_constant_sidetable',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
INSERT
INTO
    MyResult
    SELECT
        mt.id as mt_id,
        st.name as st_name,
        st.time_info as st_time_info
    FROM
        MyTable mt
    LEFT JOIN
        SideTable for SYSTEM_TIME as OF mt.proc_time as st
            ON st.id = mt.id
            AND st.name = 'name';


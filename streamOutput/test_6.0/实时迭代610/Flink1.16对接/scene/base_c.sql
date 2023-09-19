


-- 已验证通过
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
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_base_c',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE mysqlResultTable(
    id INT,
    name VARCHAR,
    age DECIMAL(21,18) ,
    address VARCHAR,
    school VARCHAR,
    message VARCHAR,
    start_time TIMESTAMP,
    end_time TIMESTAMP
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_base_c_table',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
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
INSERT
INTO
    mysqlResultTable
    SELECT
        st.id,
        st.name,
        CAST(st.age AS DECIMAL(21,
        18)) + CAST(mst.age AS DECIMAL(21,
        18)) as age,
        mst.address,
        mst.school,
        mst.message,
        mst.start_time,
        mst.end_time
    FROM
        sourceTable st
    LEFT JOIN
        mysqlSideTable FOR SYSTEM_TIME AS OF st.proc_time AS mst
            ON st.id = mst.id;


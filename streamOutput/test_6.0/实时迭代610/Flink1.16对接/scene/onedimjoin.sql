


-- bug提出
CREATE TABLE MyTable1(
    id INT,
    name VARCHAR,
    channel VARCHAR,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_onedimjoin',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyResult1(
    id INT,
    name VARCHAR,
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
    'table-name'='result_112_onedimjoin_resultone',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE SideTable1(
    id INT,
    name VARCHAR,
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
    'table-name'='onedimjoin_sidetableone',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE VIEW view_tableOne AS SELECT
    mt1.id,
    mt1.name,
    st1.address,
    st1.school,
    st1.message,
    st1.start_time,
    st1.end_time
FROM
    MyTable1 mt1
JOIN
    SideTable1 for SYSTEM_TIME as of mt1.proc_time as st1
        ON  mt1.id = st1.id
WHERE
    mt1.name IS NOT NULL;
INSERT
INTO
    MyResult1
    SELECT
        *
    FROM
        view_tableOne;


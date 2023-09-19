


-- 已验证通过
CREATE TABLE MyTable(
    id INT,
    name INT,
    channel VARCHAR,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_hotfix_36409',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyResult(
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
    'table-name'='hotfix36409_result',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE SideTable(
    id INT,
    name INT,
    address VARCHAR,
    school VARCHAR,
    message VARCHAR,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='ALL',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='hotfix36409_sidetableone',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE VIEW view_tableOne AS SELECT
    mt1.id,
    st1.name,
    st1.address,
    st1.school,
    st1.message,
    st1.start_time,
    st1.end_time
FROM
    MyTable mt1
JOIN
    SideTable for SYSTEM_TIME as of mt1.proc_time as st1
        ON  mt1.id = st1.id
WHERE
    st1.name IS NOT NULL;
INSERT
INTO
    MyResult
    SELECT
        id,
        name,
        address,
        school,
        message,
        start_time,
        end_time
    FROM
        view_tableOne;


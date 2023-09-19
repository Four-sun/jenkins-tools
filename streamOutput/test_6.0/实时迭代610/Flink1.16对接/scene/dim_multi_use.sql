


-- 已验证通过
CREATE TABLE MyTable(
    id INT,
    name VARCHAR,
    channel VARCHAR,
    pv VARCHAR,
    dttime VARCHAR,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_dim_multi_use',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyResultOne(
    id INT,
    dttime VARCHAR,
    time_info VARCHAR
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_dimmultiuse_resulttableone',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE MyResultTwo(
    id INT,
    name VARCHAR,
    time_info VARCHAR,
    flag VARCHAR
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_dimmultiuse_resulttabletwo',
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
    'table-name'='dimmultiuse_sidetable',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE VIEW myView AS SELECT
    id,
    name,
    channel,
    pv,
    dttime,
    proc_time
FROM
    MyTable t1
WHERE
    t1.name = 'name';
INSERT
INTO
    MyResultOne
    SELECT
        t1.id AS id,
        t1.dttime AS dttime,
        side1.time_info AS time_info
    FROM
        myView t1
    LEFT JOIN
        SideTable FOR SYSTEM_TIME AS OF t1.proc_time AS side1
            on  t1.channel = side1.channel;
INSERT
INTO
    MyResultTwo
    SELECT
        tn1.id AS id,
        tn1.name AS name,
        siden1.time_info AS time_info,
        CAST('2' AS VARCHAR ) AS flag
    FROM
        myView tn1
    LEFT JOIN
        SideTable FOR SYSTEM_TIME AS OF tn1.proc_time AS siden1
            ON  tn1.channel = siden1.channel;


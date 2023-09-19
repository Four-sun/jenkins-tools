


CREATE TABLE MyTable(
    id INT,
    name VARCHAR,
    age INT,
    address VARCHAR,
    school VARCHAR,
    message VARCHAR,
    start_time TIMESTAMP
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_test_simple_group_by',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyResult(
    id INT,
    age bigint,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_testsimplegroupby_resultone',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
INSERT
INTO
    MyResult
    SELECT
        mt.id,
        COUNT(mt.age) AS age
    FROM
        MyTable mt
    GROUP BY
        id;


-- name case_63160
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-12-09 15:17:01
-- desc 
CREATE TABLE MyTable(
    id INT,
    age INT
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_test_simple_group_by',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyResult(
    id INT,
    age INT,
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
        *
    FROM
        MyTable;


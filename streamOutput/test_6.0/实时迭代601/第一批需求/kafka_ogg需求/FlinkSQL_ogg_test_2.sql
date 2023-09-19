CREATE TABLE sourceTable(
    id int,
    tinyint_data tinyint,
    int_data int,
    bigint_data bigint,
    decimal_data decimal,
    float_data float,
    double_data double,
    varchar_data varchar,
    date_data date,
    time_data time,
    timestamp_data timestamp,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='ogg-json-x',
    'topic'='fanshu3',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE mysqlResultTable(
    id bigint,
    varchar_data string,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='stream_mysql_ogg_one',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
-- name FlinkSQL_ogg_test_1
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-02-22 14:19:56
-- desc
INSERT  
INTO
    mysqlResultTable
    select
        id,
        varchar_data
    FROM
        sourceTable;

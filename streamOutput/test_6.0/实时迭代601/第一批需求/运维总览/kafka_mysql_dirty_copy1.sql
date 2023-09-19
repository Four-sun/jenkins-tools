CREATE TABLE sourceTable(
    id int,
    varchar_data varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'scan.startup.specific-offsets'='pt 0
offset 1024',
    'format'='json',
    'scan.startup.timestamp-millis'='1676964373815',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE mysqlResultTable(
    id bigint,
    varchar_data string
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
-- name kafka_mysql_dirty
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-02-22 09:52:41
-- desc
INSERT 
INTO
    mysqlResultTable
    select
        id,
        varchar_data 
    FROM
        sourceTable;

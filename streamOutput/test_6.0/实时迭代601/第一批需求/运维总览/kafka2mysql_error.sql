CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
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
    'table-name'='stream_mysql_ogg_five',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.82.144:3306/automation',
    'username'='drpeco'
 );
-- name kafka2mysql
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-02-21 10:13:37
-- desc 
INSERT INTO mysqlResultTable select id,name as varchar_data FROM sourceTable;

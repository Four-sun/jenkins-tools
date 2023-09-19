[]
[]
[{"sourceId":"359","columns":[{"column":"id","type":"INT"},{"column":"name","type":"INT"}],"parallelism":1,"createType":0,"type":1,"batchWaitInterval":1000,"tableName":"sink","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sourceName":"mysql_automation","batchSize":100,"table":"fusheng_test"}]
CREATE TABLE source(
    id int,
    name String
 )with(
    'connector'='stream-x'
 );
CREATE TABLE sink(
    id INT,
    name String
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='fusheng_test',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
insert 
into
    sink
    select
        id,
        name 
    from
        source;

[{"sourceId":"129","columnsText":"id int\nname varchar\nage int","charset":"utf-8","_panelKey":"1676945618422193964","sourceDataType":"dt_nest","timestampOffset":1676964403000,"timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"offsetReset":"latest","offsetUnit":"SECOND","offsetValue":"pt 0\noffset 318748","topic":"fanshu4","sourceName":"kafka2_auto","table":"sourceTable"}]
[]
[{"sourceId":"127","columns":[{"column":"id","type":"bigint"},{"column":"varchar_data","type":"string"}],"parallelism":1,"createType":0,"type":1,"batchWaitInterval":1000,"tableName":"mysqlResultTable","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sourceName":"mysql_186","batchSize":100,"table":"stream_mysql_ogg_three"}]
CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'scan.startup.specific-offsets'='pt 0 offset 318748',
    'format'='json',
    'scan.startup.timestamp-millis'='1676964403000',
    'topic'='fanshu4',
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
    'table-name'='stream_mysql_ogg_three',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
INSERT 
INTO
    mysqlResultTable
    select
        id,
        name as varchar_data 
    FROM
        sourceTable;

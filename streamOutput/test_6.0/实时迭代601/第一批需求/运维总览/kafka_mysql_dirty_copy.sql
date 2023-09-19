[{"sourceId":"129","columnsText":"id int\nvarchar_data varchar","charset":"utf-8","_panelKey":"167703075256890623","sourceDataType":"dt_nest","timestampOffset":1676964373815,"timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"varchar_data","type":"varchar"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"offsetReset":"custom","offsetUnit":"SECOND","offsetValue":"pt 0\noffset 1024","topic":"fanshu2","sourceName":"kafka2_auto","table":"sourceTable"}]
[]
[{"sourceId":"127","columns":[{"column":"id","type":"bigint"},{"column":"varchar_data","type":"string"}],"parallelism":1,"createType":0,"type":1,"batchWaitInterval":1000,"tableName":"mysqlResultTable","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sourceName":"mysql_186","batchSize":100,"table":"stream_mysql_ogg_one"}]
CREATE TABLE sourceTable(
    id int,
    varchar_data varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'scan.startup.specific-offsets'='partition:pt,offset:0;partition:offset,offset:1024',
    'format'='json',
    'scan.startup.timestamp-millis'='1676964373815',
    'topic'='fanshu2',
    'scan.startup.mode'='specific-offsets'
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
INSERT  
INTO
    mysqlResultTable
    select
        id,
        varchar_data      
    FROM
        sourceTable;

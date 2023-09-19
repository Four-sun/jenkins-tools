[{"sourceId":"625","columnsText":"id int\nname varchar","charset":"utf-8","_panelKey":"1676518560122156884","sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x_auto_test","table":"sourceTable"}]
[]
[{"sourceId":"625","columnsText":"id int\nname varchar","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"}],"parallelism":1,"createType":0,"type":37,"tableName":"kafkaResultTable","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sinkDataType":"dt_nest","topic":"fanshu7","sourceName":"kafka2x_auto_test"}]
CREATE TABLE sourceTable(
    id int,
    name varchar,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE kafkaResultTable(
    id int,
    name varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu7',
    'sink.parallelism'='1'
 );
INSERT 
INTO
    kafkaResultTable
    select
        id,
        name 
    from
        sourceTable;

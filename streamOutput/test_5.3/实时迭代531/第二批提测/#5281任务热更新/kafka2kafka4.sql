[{"sourceId":"337","columnsText":"id int\nname varchar\nage int","charset":"utf-8","_panelKey":"1669689194726256782","sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x_auto_test","table":"sourceTable"}]
[]
[{"sourceId":"337","columnsText":"id int\nname varchar\nage int","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"createType":0,"type":37,"tableName":"kafkaResultTable","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sinkDataType":"dt_nest","topic":"fanshu4","sourceName":"kafka2x_auto_test"}]
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
CREATE TABLE kafkaResultTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu4',
    'sink.parallelism'='1'
 );
INSERT  
INTO
    kafkaResultTable
    select
        id,
        name,
        age     
    from
        sourceTable;

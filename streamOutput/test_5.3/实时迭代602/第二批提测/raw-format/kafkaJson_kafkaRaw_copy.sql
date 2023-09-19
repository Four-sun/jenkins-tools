[{"sourceId":"817","columnsText":"id int\nname varchar\nage int","charset":"utf-8","_panelKey":"1680145861268473737","sourceDataType":1,"timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"offsetReset":"latest","offsetUnit":"SECOND","topic":"dtstream_one","sourceName":"kafka2x_auto_test","table":"sourceTableOne"}]
[]
[{"sourceId":"817","columnsText":"name varchar","columns":[{"column":"name","type":"varchar"}],"parallelism":1,"createType":0,"type":37,"tableName":"kafkaResultOne","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sinkDataType":7,"topic":"dtstream_two","sourceName":"kafka2x_auto_test"}]
CREATE TABLE sourceTableOne(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='dtstream_one',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE kafkaResultOne(
    name varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='raw',
    'topic'='dtstream_two',
    'sink.parallelism'='1'
 );
INSERT  
INTO
    kafkaResultOne
    SELECT
        name     
    from
        sourceTableOne;

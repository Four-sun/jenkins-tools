[{"sourceId":"817","columnsText":"name varchar","charset":"utf-8","_panelKey":"1680145861268473737","sourceDataType":7,"timeTypeArr":[1],"offset":0,"columns":[{"column":"name","type":"varchar"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"offsetReset":"latest","offsetUnit":"SECOND","topic":"dtstream_two","sourceName":"kafka2x_auto_test","table":"sourceTableOne"}]
[]
[{"sourceId":"817","columnsText":"id varchar\nname varchar\nage varchar","columns":[{"column":"id","type":"varchar"},{"column":"name","type":"varchar"},{"column":"age","type":"varchar"}],"parallelism":1,"createType":0,"type":37,"tableName":"kafkaResultOne","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sinkDataType":1,"topic":"dtstream_three","sourceName":"kafka2x_auto_test"}]
CREATE TABLE sourceTableOne(
    name varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='raw',
    'topic'='dtstream_two',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE kafkaResultOne(
    id varchar,
    name varchar,
    age varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='dtstream_three',
    'sink.parallelism'='1'
 );
INSERT  
INTO
    kafkaResultOne
    SELECT
        SPLIT_INDEX(name,
        ',',
        0) as id,
        SPLIT_INDEX(name,
        ',',
        1) as name,
        SPLIT_INDEX(name,
        ',',
        2) as age     
    from
        sourceTableOne;

[{"sourceId":"817","columnsText":"id int\nname varchar\nage int","charset":"utf-8","_panelKey":"1680159336872956601","sourceDataType":9,"timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"offsetReset":"latest","offsetUnit":"SECOND","topic":"dtstream_four","sourceName":"kafka2x_auto_test","table":"sourceTableOne"}]
[]
[{"sourceId":"817","columnsText":"id int\nname varchar\nage int","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"createType":0,"type":37,"tableName":"kafkaResultOne","bulkFlushMaxActions":100,"updateMode":"upsert","allReplace":"false","sinkDataType":"dt_nest","topic":"dtstream_five","sourceName":"kafka2x_auto_test","primaryKey":["id"]}]
CREATE TABLE sourceTableOne(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='chunjun-cdc-json-x',
    'topic'='dtstream_four',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE kafkaResultOne(
    id int,
    name varchar,
    age int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='upsert-kafka-x',
    'value.format'='json',
    'value.fields-include'='ALL',
    'key.format'='json',
    'topic'='dtstream_five',
    'sink.parallelism'='1'
 );
INSERT   
INTO
    kafkaResultOne
    SELECT
        id,
        name,
        age          
    from
        sourceTableOne;

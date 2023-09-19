[{"sourceId":"173","charset":"utf-8","_panelKey":"1691409695758296314","valueFieldsInclude":"ALL","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"createType":0,"type":37,"tableType":1,"offsetUnit":"SECOND","timeInterval":60,"table":"sourceTable","readMode":true,"columnsText":"id int\nname varchar\nage int","sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"valueFormat":"json","timeZone":"Asia/Shanghai","offsetReset":"latest","streamingStartOffset":"latest","keyFormat":"json","topic":"fanshu4","sourceName":"kafka2x237"}]
[]
[{"sourceId":"151","schema":"flinkx_test","columns":[{"column":"id","type":"string"},{"column":"gender","type":"string"}],"valueFieldsInclude":"ALL","parallelism":1,"valueFormat":"json","createType":0,"type":91,"batchWaitInterval":2000,"tableName":"starrocksResultTable","bulkFlushMaxActions":100,"keyFormat":"json","updateMode":"append","allReplace":"false","sourceName":"StarRocks22x","batchSize":2,"table":"starrocks_stream_test_one"}]
CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu4',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE starrocksResultTable(
    id string,
    gender string
 )WITH(
    'password' = '******',
    'connector'='starrocks-x',
    'schema-name'='flinkx_test',
    'feNodes'='172.16.82.221:8030',
    'sink.buffer-flush.max-rows'='2',
    'table-name'='starrocks_stream_test_one',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.82.221:9030',
    'username'='root'
 );
INSERT  
INTO
    starrocksResultTable
    select
        cast(id as string) id,
        name as gender      
    from
        sourceTable;

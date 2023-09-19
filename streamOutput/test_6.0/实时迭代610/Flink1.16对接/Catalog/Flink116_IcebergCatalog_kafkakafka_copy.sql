[{"sourceId":"253","columnsText":"id int\nname varchar\nage int","charset":"utf-8","_panelKey":"1685352277751615340","sourceDataType":1,"timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x237","table":"sourceTable"}]
[]
[]
CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
INSERT  
INTO
    icebergCatalog.icebergdatabaseone.iceberg_result_table
    select
        id,
        name,
        age      
    from
        sourceTable;

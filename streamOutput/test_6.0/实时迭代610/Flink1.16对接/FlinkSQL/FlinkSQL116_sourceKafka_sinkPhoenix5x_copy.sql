[{"sourceId":"253","columnsText":"id int\nname varchar\nage int","charset":"utf-8","_panelKey":"1685001499215927807","sourceDataType":1,"timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x237","table":"sourceTable"}]
[]
[{"sourceId":"289","columns":[{"column":"ID","type":"BIGINT"},{"column":"NAME","type":"VARCHAR"},{"column":"AGE","type":"VARCHAR"}],"parallelism":1,"createType":0,"type":38,"batchWaitInterval":1000,"tableName":"phoenixSinkTable","bulkFlushMaxActions":100,"updateMode":"upsert","allReplace":"false","sourceName":"Phoenix5x_auto_test","batchSize":100,"table":"TEST_2022_50000_1683884788","primaryKey":["ID"]}]
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
CREATE TABLE phoenixSinkTable(
    ID BIGINT,
    NAME VARCHAR,
    AGE VARCHAR,
    PRIMARY KEY(ID) NOT ENFORCED
 )WITH(
    'connector'='phoenix5-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='TEST_2022_50000_1683884788',
    'sink.parallelism'='1',
    'url'='jdbc:phoenix:172.16.83.242:2181'
 );
INSERT  
INTO
    phoenixSinkTable
    select
        st.id ,
        st.name as name,
        cast(st.age as varchar) as age     
    from
        sourceTable st;

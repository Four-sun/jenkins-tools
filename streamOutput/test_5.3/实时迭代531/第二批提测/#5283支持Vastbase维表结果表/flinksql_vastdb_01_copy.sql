[{"sourceId":"337","columnsText":"id int\nname varchar\nage int","charset":"utf-8","_panelKey":"1669623307071381268","sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x_auto_test","table":"sourceTable"}]
[]
[{"sourceId":"287","schema":"testuser","columns":[{"column":"id","type":"bigint"},{"column":"varchar_10_data","type":"varchar"}],"parallelism":1,"createType":0,"type":101,"batchWaitInterval":1000,"tableName":"vastdbResultTable","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sourceName":"vastbase","batchSize":100,"table":"result_112_vast_all_type_three"}]
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
CREATE TABLE vastdbResultTable(
    id bigint,
    varchar_10_data varchar
 )WITH(
    'password' = '******',
    'connector'='postgresql-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='testuser',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_vast_all_type_three',
    'sink.parallelism'='1',
    'url'='jdbc:postgresql://172.16.84.251:5432/postgres',
    'username'='testuser'
 );
INSERT  
INTO
    vastdbResultTable
    select
        st.id as id,
        st.name as varchar_10_data      
    from
        sourceTable st;

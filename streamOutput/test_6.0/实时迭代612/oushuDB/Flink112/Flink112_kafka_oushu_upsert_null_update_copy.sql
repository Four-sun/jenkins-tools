[{"sourceId":"515","charset":"utf-8","_panelKey":"1691398463490107839","valueFieldsInclude":"ALL","columns":[{"column":"id","type":"int"},{"column":"bigint_data","type":"bigint"},{"column":"varchar_data","type":"varchar"},{"column":"double_data","type":"double"},{"column":"numeric_data","type":"numeric(10,0)"},{"column":"timestamp_data","type":"timestamp"}],"parallelism":1,"timeType":1,"createType":0,"type":37,"tableType":1,"offsetUnit":"SECOND","timeInterval":60,"table":"sourceTable","readMode":true,"columnsText":"id int\nbigint_data bigint\nvarchar_data varchar\ndouble_data double\nnumeric_data numeric(10,0)\ntimestamp_data timestamp","sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"valueFormat":"json","timeZone":"Asia/Shanghai","offsetReset":"latest","streamingStartOffset":"latest","keyFormat":"json","topic":"fanshu2","sourceName":"kafka2x237"}]
[]
[{"sourceId":"517","schema":"public","columns":[{"column":"id","type":"bigint"},{"column":"bigint_data","type":"bigint"},{"column":"character_varying_data","type":"varchar"},{"column":"character_data","type":"varchar"},{"column":"double_data","type":"double"},{"column":"numeric_data","type":"decimal"},{"column":"text_data","type":"varchar"},{"column":"timestamp_data","type":"timestamp"}],"valueFieldsInclude":"ALL","parallelism":1,"valueFormat":"json","createType":0,"type":113,"batchWaitInterval":1000,"tableName":"oushuResultTable","bulkFlushMaxActions":100,"keyFormat":"json","updateMode":"upsert","allReplace":"true","sourceName":"oushudb_stream","batchSize":100,"table":"stream_all_type_test_two","primaryKey":["id"]}]
CREATE TABLE sourceTable(
    id int,
    bigint_data bigint,
    varchar_data varchar,
    double_data double,
    numeric_data numeric(10,0) ,
    timestamp_data timestamp
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE oushuResultTable(
    id bigint,
    bigint_data bigint,
    character_varying_data varchar,
    character_data varchar,
    double_data double,
    numeric_data decimal,
    text_data varchar,
    timestamp_data timestamp,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='oushu-x',
    -- 'sink.buffer-flush.interval'='1000',
    'schema-name'='public',
    'sink.all-replace'='true',
    -- 'sink.buffer-flush.max-rows'='100',
    'table-name'='stream_all_type_test_two',
    'sink.parallelism'='1',
    'url'='jdbc:postgresql://172.16.83.170:5432/postgres',
    'username'='oushu'
 );
INSERT         
into
    oushuResultTable
    select
        id,
        bigint_data,
        varchar_data as character_varying_data,
        varchar_data as character_data,
        double_data,
        numeric_data,
        varchar_data as text_data,
        timestamp_data          
    from
        sourceTable;

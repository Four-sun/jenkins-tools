[{"sourceId":"173","charset":"utf-8","_panelKey":"1691559566929896989","valueFieldsInclude":"ALL","columns":[{"column":"id","type":"int"},{"column":"tinyint_data","type":"tinyint"},{"column":"int_data","type":"int"},{"column":"bigint_data","type":"bigint"},{"column":"decimal_data","type":"decimal(10,0)"},{"column":"numeric_data","type":"numeric"},{"column":"float_data","type":"float"},{"column":"double_data","type":"double"},{"column":"varchar_data","type":"varchar"},{"column":"time_data","type":"time"},{"column":"timestamp_data","type":"timestamp"}],"parallelism":1,"timeType":1,"createType":0,"type":37,"extraType":10000,"tableType":1,"offsetUnit":"SECOND","timeInterval":60,"table":"sourceTable","readMode":true,"columnsText":"id int\ntinyint_data tinyint\nint_data int\nbigint_data bigint\ndecimal_data decimal(10,0)\nnumeric_data numeric\nfloat_data float\ndouble_data double\nvarchar_data varchar\ntime_data time\ntimestamp_data timestamp\n","sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"valueFormat":"csv","timeZone":"Asia/Shanghai","offsetReset":"latest","streamingStartOffset":"latest","keyFormat":"csv","topic":"stream_csv_csv","sourceName":"kafka2x237","primaryKey":["id"]}]
[]
[{"sourceId":"173","columnsText":"id int\ntinyint_data tinyint\nint_data int\nbigint_data bigint\ndecimal_data decimal(10,0)\nnumeric_data numeric\nfloat_data float\ndouble_data double\nvarchar_data varchar\ntime_data time\ntimestamp_data timestamp","columns":[{"column":"id","type":"int"},{"column":"tinyint_data","type":"tinyint"},{"column":"int_data","type":"int"},{"column":"bigint_data","type":"bigint"},{"column":"decimal_data","type":"decimal(10,0)"},{"column":"numeric_data","type":"numeric"},{"column":"float_data","type":"float"},{"column":"double_data","type":"double"},{"column":"varchar_data","type":"varchar"},{"column":"time_data","type":"time"},{"column":"timestamp_data","type":"timestamp"}],"valueFieldsInclude":"ALL","parallelism":1,"valueFormat":"json","createType":0,"type":37,"tableName":"kafkaResultOne","bulkFlushMaxActions":100,"keyFormat":"json","updateMode":"upsert","allReplace":"false","sinkDataType":"dt_nest","topic":"fanshu11","sourceName":"kafka2x237","primaryKey":["id"]}]
CREATE TABLE sourceTable(
    id int,
    tinyint_data tinyint,
    int_data int,
    bigint_data bigint,
    decimal_data decimal(10,0) ,
    numeric_data numeric,
    float_data float,
    double_data double,
    varchar_data varchar,
    time_data time,
    timestamp_data timestamp,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='upsert-kafka-x',
    'value.format'='csv',
    'key.format'='csv',
    'value.fields-include'='ALL',
    'topic'='stream_csv_csv'
 );
CREATE TABLE kafkaResultOne(
    id int,
    tinyint_data tinyint,
    int_data int,
    bigint_data bigint,
    decimal_data decimal(10,0) ,
    numeric_data numeric,
    float_data float,
    double_data double,
    varchar_data varchar,
    time_data time,
    timestamp_data timestamp,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='upsert-kafka-x',
    'value.format'='json',
    'value.fields-include'='ALL',
    'key.format'='json',
    'topic'='fanshu11',
    'sink.parallelism'='1'
 );
INSERT       
INTO
    kafkaResultOne
    SELECT
        id,
        tinyint_data,
        int_data,
        bigint_data,
        decimal_data,
        numeric_data,
        float_data,
        double_data,
        varchar_data,
        time_data,
        timestamp_data                              
    FROM
        sourceTable;

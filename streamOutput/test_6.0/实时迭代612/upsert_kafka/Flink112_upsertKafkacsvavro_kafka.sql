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
    timestamp_data timestamp(3) ,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='upsert-kafka-x',
    'value.format'='avro',
    'key.format'='csv',
    'value.fields-include'='ALL',
    'topic'='stream_csv_avro'
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
    timestamp_data timestamp(3) ,
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
-- name Flink112_upsertKafka_kafka
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-08 20:36:26
-- desc 
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


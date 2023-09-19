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
    proc_time AS PROCTIME() ,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='upsert-kafka-x',
    'value.format'='json',
    'key.format'='json',
    'value.fields-include'='ALL',
    'topic'='fanshu2'
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
    'key.format'='json',
    'value.fields-include'='ALL',
    'topic'='stream_json_json',
    'sink.parallelism'='1'
 );
CREATE TABLE kafkaResultTwo(
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
    'value.format'='avro',
    'key.format'='json',
    'value.fields-include'='ALL',
    'topic'='stream_json_csv',
    'sink.parallelism'='1'
 );
CREATE TABLE kafkaResultThree(
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
    'value.format'='avro',
    'key.format'='json',
    'value.fields-include'='ALL',
    'topic'='stream_json_avro',
    'sink.parallelism'='1'
 );
CREATE TABLE kafkaResultFour(
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
    'key.format'='csv',
    'value.fields-include'='ALL',
    'topic'='stream_csv_json',
    'sink.parallelism'='1'
 );
CREATE TABLE kafkaResultFive(
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
    'topic'='stream_csv_csv',
    'sink.parallelism'='1'
 );
CREATE TABLE kafkaResultSix(
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
    'value.format'='avro',
    'key.format'='csv',
    'value.fields-include'='ALL',
    'topic'='stream_csv_avro',
    'sink.parallelism'='1'
 );
CREATE TABLE kafkaResultSeven(
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
    'key.format'='avro',
    'value.fields-include'='ALL',
    'topic'='stream_avro_json',
    'sink.parallelism'='1'
 );
CREATE TABLE kafkaResultEight(
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
    'key.format'='avro',
    'value.fields-include'='ALL',
    'topic'='stream_avro_csv',
    'sink.parallelism'='1'
 );
CREATE TABLE kafkaResultNine(
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
    'value.format'='avro',
    'key.format'='avro',
    'value.fields-include'='ALL',
    'topic'='stream_avro_avro',
    'sink.parallelism'='1'
 );
-- name Flink112_kafka_upsertKafka_all
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-09-07 14:53:28
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


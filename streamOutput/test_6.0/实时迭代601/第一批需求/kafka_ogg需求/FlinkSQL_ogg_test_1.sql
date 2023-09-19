CREATE TABLE sourceTable(
    id int,
    tinyint_data tinyint,
    int_data int,
    bigint_data bigint,
    decimal_data decimal,
    float_data float,
    double_data double,
    varchar_data varchar,
    date_data date,
    time_data time,
    timestamp_data timestamp,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='ogg-json-x',
    'topic'='fanshu3',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE kafkaResultTable(
    id int,
    tinyint_data tinyint,
    int_data int,
    bigint_data bigint,
    decimal_data decimal,
    float_data float,
    double_data double,
    varchar_data varchar,
    date_data date,
    time_data time,
    timestamp_data timestamp,
    name varchar,
    age int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='upsert-kafka-x',
    'value.format'='json',
    'value.fields-include'='ALL',
    'key.format'='json',
    'topic'='fanshu7',
    'sink.parallelism'='1'
 );
-- name FlinkSQL_ogg_test_1
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-02-22 14:19:56
-- desc
INSERT  
INTO
    kafkaResultTable
    select
        id,
        tinyint_data,
        int_data,
        bigint_data,
        decimal_data,
        float_data,
        double_data,
        varchar_data,
        date_data,
        time_data,
        timestamp_data,
        name,
        age     
    FROM
        sourceTable;

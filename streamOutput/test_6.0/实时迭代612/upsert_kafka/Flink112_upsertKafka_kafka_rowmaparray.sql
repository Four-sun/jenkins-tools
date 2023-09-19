CREATE TABLE sourceTable(
    id BIGINT,
    name STRING,
    obj_data ROW<time1 TIME,
    str STRING,
    lg BIGINT>,
    arr_data ARRAY<ROW<f1 STRING,
    f2 INT>>,
    map_data MAP<STRING,
    BIGINT>,
    mapinmap MAP<STRING,
    MAP<STRING,
    INT>>,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='upsert-kafka-x',
    'value.format'='json',
    'key.format'='json',
    'value.fields-include'='ALL',
    'topic'='stream_row_test'
 );

CREATE TABLE kafkaResultOne(
    id BIGINT,
    name VARCHAR,
    obj_str VARCHAR,
    arr1_f1 VARCHAR,
    map_flink BIGINT,
    mapinmap_key INT,
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
    select
        id,
        name,
        obj_data.str as obj_str,
        arr_data[1].f1 as arr1_f1,
        map_data['flink'] as map_flink,
        mapinmap['inner_map']['key'] as mapinmap_key
    from
        sourceTable;


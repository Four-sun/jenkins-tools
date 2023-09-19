


CREATE TABLE sourceTable(
    id            BIGINT,
    name          STRING,
    date_data        DATE,
    obj_data         ROW<time1 TIME,
    str STRING,
    lg BIGINT>,
    arr_data           ARRAY<ROW<f1 STRING,
    f2 INT>>,
    time_data      TIME,
    timestamp_data  TIMESTAMP(3) ,
    map_data        MAP<STRING,
    BIGINT>,
    mapinmap      MAP<STRING,
    MAP<STRING,
    INT>>,
    proc_time as PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_row_map_arr',
    'scan.startup.mode'='latest-offset'
 );
create table json_source(
    id BIGINT,
    name VARCHAR,
    date_data DATE,
    obj_str VARCHAR,
    arr1_f1 VARCHAR,
    map_flink BIGINT,
    mapinmap_key INT
 )with(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_row_map_arr_table',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );

INSERT
INTO
    json_source
    select
        id,
        name,
        date_data,
        obj_data.str as obj_str,
        arr_data[1].f1 as arr1_f1,
        map_data['flink'] as map_flink,
        mapinmap['inner_map']['key'] as mapinmap_key
    from
        sourceTable;


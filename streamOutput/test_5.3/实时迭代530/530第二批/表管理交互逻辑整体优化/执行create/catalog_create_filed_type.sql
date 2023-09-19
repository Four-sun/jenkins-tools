


-- name catalog_create_one
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-10-17 11:21:38
-- desc
-- CREATE DATABASE fanshu_catalog_1.fanshu_database;
-- CREATE DATABASE fanshu_catalog.fanshu_database;
-- DROP DATABASE fanshu_catalog.fanshu_database;

CREATE TABLE fanshu_catalog_1.fanshu_database.fanshu_table_3(
    id int,
    tinyint_data tinyint,
    smallint_data smallint,
    int_data int,
    bigint_data bigint,
    float_data float,
    double_data double,
    boolean_data boolean,
    string_data string
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );

--  -- 中英文
-- CREATE TABLE fanshu_catalog_1.fanshu_database.fanshu_table_3(
--     id int,
--     name varchar,
--     age int,
--     proc_time AS PROCTIME() 
--  )WITH(
--     'properties.bootstrap.servers'='172.16.100.109:9092',
--     'connector'='kafka-x',
--     'scan.parallelism'='1',
--     'format'='json',
--     'topic'='fanshu2',
--     'scan.startup.mode'='latest-offset'
--  );


--  CREATE TABLE fanshu_catalog_1.fanshu_database.sourceTable like fanshu_catalog_1.fanshu_database.fanshu_table_2;


-- CREATE TABLE fanshu_catalog_1.fanshu_database.fanshu_table_5(
--     id            BIGINT,
--     name          STRING,
--     date_data        DATE,
--     obj_data         ROW<time1 TIME,
--     str STRING,
--     lg BIGINT>,
--     arr_data           ARRAY<ROW<f1 STRING,
--     f2 INT>>,
--     time_data      TIME,
--     timestamp_data  TIMESTAMP(3) ,
--     map_data        MAP<STRING,
--     BIGINT>,
--     mapinmap      MAP<STRING,
--     MAP<STRING,
--     INT>>,
--     proc_time as PROCTIME() 
--  )WITH(
--     'properties.bootstrap.servers'='172.16.100.109:9092',
--     'connector'='kafka-x',
--     'scan.parallelism'='1',
--     'format'='json',
--     'topic'='source_112_row_map_arr',
--     'scan.startup.mode'='latest-offset'
--  );




-- name catalog_create_one
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-10-17 11:21:38
-- desc
CREATE DATABASE IF NOT EXISTS fanshu_catalog.fanshu_database;
CREATE DATABASE fanshu_catalog.fanshu_database;
DROP DATABASE fanshu_catalog.fanshu_database;
CREATE TABLE IF NOT EXISTS fanshu_catalog.fanshu_database.fanshu_table_1(
    id int
 );
CREATE TABLE IF NOT EXISTS fanshu_catalog.fanshu_database.fanshu_table_2(
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
CREATE TABLE fanshu_catalog.fanshu_database.qianyi_table_info2(
    id int COMMENT'sss',
    name varchar,
    age int,
    ts TIMESTAMP(3) ,
    `timestamp` TIMESTAMP(3) WITH LOCAL TIME ZONE METADATA,
    `record_time` TIMESTAMP(3) WITH LOCAL TIME ZONE METADATA FROM 'timestamp',
    `record_time1` TIMESTAMP(3) WITH LOCAL TIME ZONE METADATA FROM 'timestamp' VIRTUAL,
    proc_time AS PROCTIME() ,
    PRIMARY KEY(`id`) NOT ENFORCED,
    WATERMARK FOR ts AS ts - INTERVAL '5' SECOND
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );


CREATE TABLE fanshu_catalog.fanshu_database.qianyi_table_info3(
    id INT NOT NULL,
    name STRING,
    age INT,
    ts TIMESTAMP(3) ,
    timestamp TIMESTAMP(3) WITH LOCAL TIME ZONE METADATA,
    `record_time` TIMESTAMP(3) WITH LOCAL TIME ZONE METADATA FROM 'timestamp',
    `record_time1` TIMESTAMP(3) WITH LOCAL TIME ZONE METADATA FROM 'timestamp' VIRTUAL,
    proc_time PROCTIME() ,
    PRIMARY KEY(id) NOT ENFORCED,
    WATERMARK FOR ts AS `ts` - INTERVAL '5' SECOND
 )WITH(
    'scan.startup.mode'='latest-offset',
    'scan.parallelism'='1',
    'format'='json',
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'topic'='fanshu2'
 );




-- name catalog_create_one
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-10-17 11:21:38
-- desc
CREATE DATABASE IF NOT EXISTS fanshu_catalog.fanshu_database;
CREATE DATABASE fanshu_catalog.fanshu_database;
DROP DATABASE fanshu_catalog.fanshu_database;


CREATE TABLE IF NOT EXISTS fanshu_catalog.fanshu_database.fanshu_table_1(
    id int);

CREATE TABLE IF NOT EXISTS fanshu_catalog.fanshu_database.fanshu_table_1(
    id int,
    tinyint_data tinyint,
    smallint_data smallint,
    int_data int,
    bigint_data bigint,
    float_data float,
    double_data double,
    boolean_data boolean,
    string_data string
 )WITH (
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );


 CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );

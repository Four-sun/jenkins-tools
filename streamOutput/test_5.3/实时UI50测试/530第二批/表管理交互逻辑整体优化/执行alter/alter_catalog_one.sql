


-- name alter_catalog_one
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-11-23 11:55:01
-- desc 
create database if not exists fanshu_catalog.database_two;
CREATE TABLE fanshu_catalog.database_two.fanshu1(
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
alter table fanshu_catalog.database_two.fanshu1 rename to fanshu2;


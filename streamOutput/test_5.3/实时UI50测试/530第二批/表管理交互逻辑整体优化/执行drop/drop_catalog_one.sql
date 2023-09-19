


-- name drop_catalog_one
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-11-23 11:55:01
-- desc 
create database if not exists fanshu_catalog.database_one;
CREATE TABLE fanshu_catalog.database_one.fanshu1(
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
drop database if exists fanshu_catalog.database_one;
-- 删除非空数据库，连通数据库中的所有表也一起删除
drop database if exists fanshu_catalog.database_one CASCADE;
-- 删除表操作
drop table if exists fanshu_catalog.database_one.fanshu1;


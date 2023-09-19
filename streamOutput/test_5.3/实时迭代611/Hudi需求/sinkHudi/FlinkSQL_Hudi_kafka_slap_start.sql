

CREATE TABLE kafkaResult(
    uuid varchar,
    name varchar,
    age int,
    pt varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu7',
    'sink.parallelism'='1'
 );
-- name FlinkSQL_Hudi_kafka
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-07-10 14:17:18
-- desc FlinkSQL任务Hudi源表-批读模式-指定开始，未指定结束commit_time,读取开始到最新commit_time数据
INSERT 
INTO
    kafkaResult
    select
       uuid,
       name,
       age,
       pt
    from
        cow_cdc_fanshu_8;

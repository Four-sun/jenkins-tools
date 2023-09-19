

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
-- desc 验证FLINK1.12—FlinkSQL任务Hudi源表-批读模式-未指定开始，指定结束commit_time,只读取end_commit对应的数据
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

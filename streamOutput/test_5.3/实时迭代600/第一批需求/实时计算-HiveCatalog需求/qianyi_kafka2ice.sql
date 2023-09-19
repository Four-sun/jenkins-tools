


-- name qianyi_kafka2ice
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-01-04 19:36:11
-- desc 

insert into stream_iceberg_one.aa.qianyi_iceberg select id ,name from stream_600_test.aa.qianyi_source;

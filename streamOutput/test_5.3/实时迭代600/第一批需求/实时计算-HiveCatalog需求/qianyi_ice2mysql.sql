


-- name qianyi_ice2mysql
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-01-04 19:36:23
-- desc 
insert into stream_600_test.aa.qianyi_mysql select id ,name from stream_iceberg_one.aa.qianyi_iceberg;

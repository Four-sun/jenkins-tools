


-- name Flink116_HiveCatalog_KafkaMysql
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-29 10:32:12
-- desc
INSERT 
INTO
    HiveCatalog_one.stream_db_600.mysqlresulttableone
    select
        id as id,
        name as varchar_data
    from
        HiveCatalog_one.stream_db_600.sourcetableone;

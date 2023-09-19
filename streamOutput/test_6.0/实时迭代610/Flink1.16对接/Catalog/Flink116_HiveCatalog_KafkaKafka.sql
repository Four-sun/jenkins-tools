


-- name Flink116_HiveCatalog_KafkaMysql
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-29 10:32:12
-- desc
INSERT 
INTO
   HiveCatalog_one.devops600_test_one.kafkaresulttableone
    select
        id as id,
        name as name,
        id as age
    from
        HiveCatalog_one.devops600_test_one.sourcetable;

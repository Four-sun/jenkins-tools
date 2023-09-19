


-- name FlinkSQL112_catalog_kafka_kafka
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-22 14:00:09
-- desc
INSERT 
INTO
    stream_iceberg_one1.stream_db_600_fanshu.kafkaresulttable
    select
        id,
        name,
        age 
    from
        stream_iceberg_one1.stream_db_600_fanshu.sourcetable;

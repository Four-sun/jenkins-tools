


-- name Flink_Catalog_kafka_kafka
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-07-18 14:00:51
-- desc
insert 
into
    fanshuCatalog.fanshuDatabase.kafkaResultOne
    select
        id,
        name,
        age 
    from
        fanshuCatalog.fanshuDatabase.sourceTableOne;


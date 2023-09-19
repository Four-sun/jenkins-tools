


-- name hmscatalog_kafka_iceberg_one
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-09-08 17:07:04
-- desc 
INSERT 
INTO
    dev_ice_catalog.dev_ice_database.fanshu_001
    select
        st.id,
        st.name ,
        1 as age
    from
        dtCatalogOne.dtDatabaseOne.sourceTable st;




-- name catalog_kafka_mysql
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-10-17 16:32:27
-- desc
INSERT 
INTO
    fanshu_catalog.fanshu_database_one.mysqlResultTableOne
    SELECT
        st.id,
        st.age as int_data,
        st.name as varchar_data 
    from
        fanshu_catalog.fanshu_database_one.sourceTable1 st;

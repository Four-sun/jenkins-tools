


-- name dtcatalog_one
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-09-07 14:50:13
-- desc 
INSERT 
INTO
    dtCatalogOne.dtDatabaseOne.mysqlResultTable
    select
        st.id,
        st.name as varchar_data
    from
        dtCatalogOne.dtDatabaseOne.sourceTable st;




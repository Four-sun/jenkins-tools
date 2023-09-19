


-- name session_insert_one
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-11-23 11:55:01
-- desc 
INSERT      
INTO
    fanshu_catalog.fanshu_database_one.mysqlResultTableOne
    select
        id,
        age as int_data,
        name as varchar_data                        
    from
        fanshu_catalog.fanshu_database.sourceTable;
-- INSERT      
-- INTO
--     fanshu_catalog.fanshu_database_one.mysqlResultTableOne
--     select
--         id,
--         age as int_data,
--         cast(proc_time as varchar) as varchar_data                        
--     from
--         fanshu_catalog.fanshu_database.sourceTable;


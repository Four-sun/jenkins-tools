


-- name dtcatalog_one
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-09-07 14:50:13
-- desc 
INSERT 
INTO
    mizhi_test_catalog.mizhi_test_database.sink
    select
        *
    from
        mizhi_test_catalog.mizhi_test_database.sourceTable;




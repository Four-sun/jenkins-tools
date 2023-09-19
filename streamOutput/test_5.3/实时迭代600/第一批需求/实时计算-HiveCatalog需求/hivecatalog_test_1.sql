


-- name hivecatalog_test_1
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-12-29 17:50:13
-- desc 源表结果表都为hivecatalog
INSERT 
INTO
    stream_600_test.stream_db_600.mysqlresulttableone
    select
        id,
        name as varchar_data
    from
        stream_600_test.stream_db_600.sourcetable;




-- name kafkamysqlmysql
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-03-02 14:31:57
-- desc 


insert 
into
    stream_iceberg_one1.stream_db_600.kafkaresulttable
    select
        id,
        name,
        age 
    from
        stream_iceberg_one1.stream_db_600.sourcetableone;


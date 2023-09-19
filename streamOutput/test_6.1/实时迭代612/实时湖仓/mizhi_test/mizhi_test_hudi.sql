


-- name hmscatalog_iceberg_kafka
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-09-07 14:50:13
-- desc 
INSERT 
INTO
    mizhi_test_HMS_hudi.mizhi_test_hudi.mizhi_hudi_sink
    select
        id,
        name,
        age 
    from
        mizhi_test_HMS_hudi.mizhi_test_hudi.mizhi_hudi_source




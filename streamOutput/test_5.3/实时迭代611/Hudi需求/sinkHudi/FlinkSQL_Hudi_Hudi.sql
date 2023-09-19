


-- name FlinkSQL_Hudi_kafka
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-07-10 14:17:18
-- desc
INSERT 
INTO
    cow_cdc_fanshu_8
    select
        uuid,
        name,
        age,
        pt
    from
        cow_cdc_fanshu_7;

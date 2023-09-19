


-- name catalog_kafka_mysql
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-10-17 16:32:27
-- desc
INSERT 
INTO
    fanshu_catalog.fanshu_database_one.kafkaResultTable
    SELECT
        st.id,
        ost.VARCHAR_255 as name,
        st.age as age
    from
        fanshu_catalog.fanshu_database_one.sourceTable1 st 
    left join  
    fanshu_catalog.fanshu_database_one.oracleSideTableOne for SYSTEM_TIME as of st.proc_time as ost 
    on cast(st.id as DECIMAL) = ost.ID;

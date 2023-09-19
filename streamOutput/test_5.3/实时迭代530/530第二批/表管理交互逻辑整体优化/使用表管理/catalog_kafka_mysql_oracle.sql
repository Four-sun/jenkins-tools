


-- name catalog_kafka_mysql
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-10-17 16:32:27
-- desc
INSERT    
INTO
    fanshu_catalog.fanshu_database_one.oracleResultOne
    SELECT
        cast(st.id as decimal(10,
        0) ) as ID,
        ost.decimal_data as DECIMAL_DATA,
        ost.varchar_data as VARCHAR_DATA,
        ost.timestamp_data as DATE_DATA,
        ost.timestamp_data as TIMESTAMP_DATA     
    from
        fanshu_catalog.fanshu_database_one.sourceTable1 st                
    left join
        fanshu_catalog.fanshu_database_one.flinkCatalogSideThree for SYSTEM_TIME as of st.proc_time as ost                                
            on st.id = ost.id;

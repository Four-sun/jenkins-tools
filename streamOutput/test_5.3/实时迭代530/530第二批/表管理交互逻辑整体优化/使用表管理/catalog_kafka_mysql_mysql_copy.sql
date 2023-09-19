[]
[]
[]
INSERT   
INTO
    fanshu_catalog.fanshu_database_one.mysqlResultTableOne
    SELECT
        st.id,
        mst.int_data as int_data,
        mst.varchar_data as varchar_data           
    from
        fanshu_catalog.fanshu_database_one.sourceTable1 st               
    left join
        fanshu_catalog.fanshu_database_one.flinkCatalogSideTwo for SYSTEM_TIME as of st.proc_time as mst                  
            on st.id = mst.id;




-- name dtcatalog_one
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-28 15:03:10
-- desc
INSERT 
INTO
    fanshuCatalog10.fanshuDatabase10.mysqlResultTable
    select
        st.id,
        mst.varchar_data
    from
        fanshuCatalog10.fanshuDatabase10.sourceTable st
    LEFT JOIN
        fanshuCatalog10.fanshuDatabase10.mysqlSideTable for system_time as of st.proc_time as mst 
            on st.id = mst.id;



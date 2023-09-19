


-- name Flink116_DTCatalog_KafkaMysqlMysql
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 13:48:35
-- desc
INSERT 
INTO
    fanshuCatalog_one.fanshuDatabase_one.mysqlResultTableOne
    SELECT
        st.id,
        st.name as varchar_data
    FROM
        fanshuCatalog_one.fanshuDatabase_one.sourceTable st 
    LEFT JOIN
        fanshuCatalog_one.fanshuDatabase_one.mysqlSideTableOne for SYSTEM_TIME as of st.proc_time as mst 
    ON st.id = mst.id;


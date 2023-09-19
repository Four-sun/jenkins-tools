

CREATE TABLE mysqlResultTable(
    id INT,
    varchar_data VARCHAR
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='stream_mysql_ogg_three',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
-- name sourceDT_sideHive_resultNORMAL
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-12-29 19:52:29
-- desc
INSERT 
into
    mysqlResultTable
    select
        st.id,
        mst.varchar_data
    from
        dtcatalog_fanshu_test.database_fanshu_test.sourceTable st 
    LEFT JOIN
        stream_600_test.stream_db_600.mysqlresulttableone for SYSTEM_TIME as of st.proc_time as mst 
            on st.id=mst.id;

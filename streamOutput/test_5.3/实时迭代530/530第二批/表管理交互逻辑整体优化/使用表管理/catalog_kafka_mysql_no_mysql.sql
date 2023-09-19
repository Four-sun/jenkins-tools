

CREATE TABLE mysqlResultTable(
    id INT,
    int_data INT,
    varchar_data VARCHAR
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='flink_catalog_one',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
-- name catalog_kafka_mysql
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-10-17 16:32:27
-- desc 不同类型组合 验证DTCatalog-kafka源表-mysql维表-mysql结果表
INSERT  
INTO
    mysqlResultTable
    SELECT
        st.id,
        mst.int_data as int_data,
        mst.varchar_data as varchar_data      
    from
        fanshu_catalog.fanshu_database_one.sourceTable1 st          
    left join
        fanshu_catalog.fanshu_database_one.flinkCatalogSideTwo for SYSTEM_TIME as of st.proc_time as mst     
            on st.id = mst.id;

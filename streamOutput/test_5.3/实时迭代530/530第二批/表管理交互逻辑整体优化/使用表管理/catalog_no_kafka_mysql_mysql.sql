CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );


-- name catalog_kafka_mysql
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-10-17 16:32:27
-- desc 不同类型组合 验证DTCatalog-kafka源表(非DTCatalog)-mysql维表-mysql结果表
INSERT  
INTO
    fanshu_catalog.fanshu_database_one.mysqlResultTableOne
    SELECT
        st.id,
        mst.int_data as int_data,
        mst.varchar_data as varchar_data      
    from
        sourceTable st          
    left join
        fanshu_catalog.fanshu_database_one.flinkCatalogSideTwo for SYSTEM_TIME as of st.proc_time as mst     
            on st.id = mst.id;

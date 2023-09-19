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
CREATE TABLE greatdbSideTable(
    id INT,
    boolean_data TINYINT,
    tinyint_data TINYINT,
    int_data INT,
    bigint_data BIGINT,
    decimal_data DECIMAL,
    double_data DOUBLE,
    char_data CHAR,
    varchar_data VARCHAR,
    date_data DATE,
    time_data TIME,
    datetime_data STRING,
    timestamp_data TIMESTAMP,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='greatdb-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='flink_source_table_one',
    'url'='jdbc:mysql://stream002:3306/test_0913?useSSL=false&tinyInt1isBit=false',
    'username'='repl'
 );
CREATE TABLE greatdbResultTable(
    id INT,
    int_data INT,
    varchar_data VARCHAR
 )WITH(
    'password' = '******',
    'connector'='greatdb-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='flink_result_table_two',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://stream002:3306/test_0913?useSSL=false&tinyInt1isBit=false',
    'username'='repl'
 );
-- name flinsql_112_greatdb_one
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-10-14 13:57:26
-- desc
INSERT       
INTO
    greatdbResultTable
    select
        st.id,
        -- gt.boolean_daata,
        -- gt.tinyint_data,
        gt.int_data,
        -- gt.bigint_data,
        -- gt.decimal_data,
        -- gt.doubsle_data,
        -- gt.char_data,
        gt.varchar_data
        -- gt.date_data,
        -- gt.time_data,
        -- gt.datetime_data,
        -- gt.timestamp_data     
    from
        sourceTable st                
    left join
        greatdbSideTable for SYSTEM_TIME as of st.proc_time as gt                               
            on st.id =gt.id;

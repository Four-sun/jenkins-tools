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
    'topic'='mizhi',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE dorisSideTable(
    id bigint,
    boolean_data boolean,
    tinyint_data int,
    int_data bigint,
    bigint_data bigint,
    decimal_data decimal,
    double_data double,
    char_data CHAR,
    varchar_data string,
    date_data string,
    time_data TIME,
    timestamp_data timestamp,
    fanshu_test string,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='doris-x',
    'lookup.cache-type'='LRU',
    'schema-name'='automation',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='mysql_flink_cdc_test_one',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE dorisResultTableOne(
    id bigint,
    int_data bigint,
    varchar_data string
 )WITH(
    'password' = '******',
    'connector'='doris-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='automation',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='flink_catalog_one',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
INSERT  
INTO
    dorisResultTableOne
    select
        st.id,
        mst.int_data,
        mst.varchar_data     
    from
        sourceTable st     
    left join
        dorisSideTable for SYSTEM_TIME as of st.proc_time as mst              
            on st.id = mst.id;

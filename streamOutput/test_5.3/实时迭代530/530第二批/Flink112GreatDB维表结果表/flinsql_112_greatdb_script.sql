[{"sourceId":"93","columnsText":"id int\nname varchar\nage int","charset":"utf-8","_panelKey":"1665727052284170788","sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x_auto_test","table":"sourceTable"}]
[{"sourceId":"97","schema":"test_0913","cacheTTLMs":"60000","cache":"LRU","keyField":["id"],"cacheSize":"10000","columns":[{"column":"id","type":"INT"},{"column":"tinyint_data","type":"TINYINT"},{"column":"int_data","type":"INT"},{"column":"bigint_data","type":"BIGINT"},{"column":"decimal_data","type":"DECIMAL"},{"column":"double_data","type":"DOUBLE"},{"column":"char_data","type":"CHAR"},{"column":"varchar_data","type":"VARCHAR"},{"column":"date_data","type":"DATE"},{"column":"time_data","type":"TIME"},{"column":"datetime_data","type":"DATETIME"},{"column":"timestamp_data","type":"TIMESTAMP"}],"parallelism":1,"createType":0,"type":95,"tableName":"greatdbSideTable","sourceName":"greatdb","asyncPoolSize":5,"table":"flink_source_table_one","primaryKey":["id"]}]
[{"sourceId":"97","schema":"test_0913","columns":[{"column":"id","type":"INT"},{"column":"int_data","type":"INT"},{"column":"varchar_data","type":"VARCHAR"}],"parallelism":1,"createType":0,"type":95,"batchWaitInterval":1000,"tableName":"greatdbResultTable","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sourceName":"greatdb","batchSize":100,"table":"flink_result_table_three"}]
ADD JAR WITH /home/admin/sftp/dttestuic_com/stream/resource/13_agg-ast_agg-ast-1.0.jar;
CREATE SCALAR FUNCTION aggast WITH fund.udf.BugTest;
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
CREATE TABLE greatdbResultTable(
    id INT,
    int_data INT,
    varchar_data VARCHAR
 )WITH(
    'password' = '******',
    'connector'='greatdb-x',
    'lookup.parallelism'='1',
    'table-name'='flink_result_table_three',
    'url'='jdbc:mysql://stream002:3306/test_0913',
    'username'='repl'
 );
CREATE TABLE greatdbSideTable(
    id INT,
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
    'url'='jdbc:mysql://stream002:3306/test_0913',
    'username'='repl'
 );
INSERT        
INTO
    greatdbResultTable
    select
        st.id,
        gt.int_data,
        aggast(gt.varchar_data)     
    from
        sourceTable st                     
    left join
        greatdbSideTable for SYSTEM_TIME as of st.proc_time as gt                                            
            on st.id =gt.id;

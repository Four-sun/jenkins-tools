[{"sourceId":"239","columnsText":"id int\nname varchar\nage int","charset":"utf-8","_panelKey":"1684481875973620799","sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2_auto","table":"sourceTable"}]
[{"sourceId":"241","cacheTTLMs":"60000","cache":"LRU","keyField":["int_data"],"cacheSize":"10000","columns":[{"column":"id","type":"int"},{"column":"int_data","type":"int"},{"column":"varchar_data","type":"string"},{"column":"timestamp_data","type":"timestamp"}],"parallelism":1,"createType":0,"type":1,"tableName":"mysqlSideTable","sourceName":"mysql_186","asyncPoolSize":5,"table":"side_112_mysql_all_type_table","primaryKey":["int_data"]}]
[{"sourceId":"241","columns":[{"column":"id","type":"int"},{"column":"varchar_data","type":"string"}],"parallelism":1,"createType":0,"type":1,"batchWaitInterval":1000,"tableName":"mysqlResultTableOne","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sourceName":"mysql_186","batchSize":100,"table":"stream_mysql_ogg_one"},{"sourceId":"241","columns":[{"column":"id","type":"int"},{"column":"varchar_data","type":"string"}],"parallelism":1,"createType":0,"type":1,"batchWaitInterval":1000,"tableName":"mysqlResultTableTwo","bulkFlushMaxActions":100,"updateMode":"upsert","allReplace":"false","sourceName":"mysql_186","batchSize":100,"table":"stream_mysql_ogg_three","primaryKey":["id"]},{"sourceId":"241","columns":[{"column":"id","type":"int"},{"column":"varchar_data","type":"string"}],"parallelism":1,"createType":0,"type":1,"batchWaitInterval":1000,"tableName":"mysqlResultTableThree","bulkFlushMaxActions":100,"updateMode":"upsert","allReplace":"true","sourceName":"mysql_186","batchSize":100,"table":"stream_mysql_ogg_one","primaryKey":["id"]}]
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
CREATE TABLE mysqlResultTableOne(
    id int,
    varchar_data string
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='stream_mysql_ogg_one',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE mysqlResultTableTwo(
    id int,
    varchar_data string,
    PRIMARY KEY(id) NOT ENFORCED
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
CREATE TABLE mysqlResultTableThree(
    id int,
    varchar_data string,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='true',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='stream_mysql_ogg_one',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE mysqlSideTable(
    id int,
    int_data int,
    varchar_data string,
    timestamp_data timestamp,
    PRIMARY KEY(int_data) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='side_112_mysql_all_type_table',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
INSERT  
INTO
    mysqlResultTableOne
    select
        st.id,
        mst.varchar_data     
    from
        sourceTable st     
    left join
        mysqlSideTable for SYSTEM_TIME as of st.proc_time as mst              
            on st.id = mst.id;
--             on st.id = mst.id;
;

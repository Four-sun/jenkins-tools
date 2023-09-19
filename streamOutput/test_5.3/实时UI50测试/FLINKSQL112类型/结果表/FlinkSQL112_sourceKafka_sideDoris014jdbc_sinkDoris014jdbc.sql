[{"sourceId":"219","columnsText":"id int\nname varchar\nage int","charset":"utf-8","_panelKey":"1673354422730345321","sourceDataType":1,"timeTypeArr":[1],"offset":0,"customParams":[],"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x_auto_test","table":"sourceTable"},{"sourceId":"219","columnsText":"id int\nname varchar\nage int\nstart_time timestamp","charset":"utf-8","_panelKey":"1673355178887720107","sourceDataType":1,"timeTypeArr":[1,2],"offset":10,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"},{"column":"start_time","type":"timestamp"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"latest","timeColumn":"start_time","offsetUnit":"SECOND","topic":"test_topic_name_gcwfybte","sourceName":"kafka2x_auto_test","table":"sourceTableOne"},{"sourceId":"219","columnsText":"id int\nname varchar\nage int","charset":"gbk2312","_panelKey":"1673355289637674590","timestampOffset":1673355324056,"sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"timestamp","offsetUnit":"SECOND","topic":"test_topic_name_wtzaudhp","sourceName":"kafka2x_auto_test","table":"sourceTableTwo"},{"sourceId":"219","columnsText":"id int\nname varchar\nage int","charset":"utf-8","_panelKey":"1673355340324158762","sourceDataType":2,"timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"custom","offsetUnit":"SECOND","offsetValue":"0 43","topic":"test_topic_name_bxronphj","sourceName":"kafka2x_auto_test","table":"sourceTableThree"}]
[{"sourceId":"535","schema":"automation","cacheTTLMs":"60000","cache":"LRU","keyField":["id"],"cacheSize":"10000","columns":[{"column":"id","type":"INT"},{"column":"int_data","type":"INT"},{"column":"varchar_data","type":"VARCHAR"}],"parallelism":1,"createType":0,"type":57,"tableName":"dorisSideTable","sourceName":"doris_jdbc","asyncPoolSize":5,"table":"mysql_flink_cdc_test_one","primaryKey":["id"]}]
[{"sourceId":"535","schema":"automation","columns":[{"column":"id","type":"INT"},{"column":"int_data","type":"INT"},{"column":"varchar_data","type":"VARCHAR"}],"parallelism":1,"createType":0,"type":57,"batchWaitInterval":1000,"tableName":"dorisResultTableOne","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sourceName":"doris_jdbc","batchSize":100,"table":"flink_catalog_one"}]
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
CREATE TABLE sourceTableOne(
    id int,
    name varchar,
    age int,
    start_time timestamp,
    WATERMARK FOR start_time AS start_time - INTERVAL'10'SECOND,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='test_topic_name_gcwfybte',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE sourceTableTwo(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'scan.startup.timestamp-millis'='1673355324056',
    'topic'='test_topic_name_wtzaudhp',
    'scan.startup.mode'='timestamp'
 );
CREATE TABLE sourceTableThree(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'scan.startup.specific-offsets'='partition:0,offset:43',
    'format'='csv',
    'topic'='test_topic_name_bxronphj',
    'scan.startup.mode'='specific-offsets'
 );
CREATE TABLE dorisResultTableOne(
    id INT,
    int_data INT,
    varchar_data VARCHAR
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
CREATE TABLE dorisSideTable(
    id INT,
    int_data INT,
    varchar_data VARCHAR,
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

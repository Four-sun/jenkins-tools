[{"sourceId":"219","columnsText":"id string\nname varchar\nage int","charset":"utf-8","_panelKey":"1673354422730345321","sourceDataType":1,"timeTypeArr":[1],"offset":0,"customParams":[],"columns":[{"column":"id","type":"string"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x_auto_test","table":"sourceTable"},{"sourceId":"219","columnsText":"id int\nname varchar\nage int\nstart_time timestamp","charset":"utf-8","_panelKey":"1673355178887720107","sourceDataType":1,"timeTypeArr":[1,2],"offset":10,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"},{"column":"start_time","type":"timestamp"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"latest","timeColumn":"start_time","offsetUnit":"SECOND","topic":"test_topic_name_gcwfybte","sourceName":"kafka2x_auto_test","table":"sourceTableOne"},{"sourceId":"219","columnsText":"id int\nname varchar\nage int","charset":"gbk2312","_panelKey":"1673355289637674590","timestampOffset":1673355324056,"sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"timestamp","offsetUnit":"SECOND","topic":"test_topic_name_wtzaudhp","sourceName":"kafka2x_auto_test","table":"sourceTableTwo"},{"sourceId":"219","columnsText":"id int\nname varchar\nage int","charset":"utf-8","_panelKey":"1673355340324158762","sourceDataType":2,"timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"custom","offsetUnit":"SECOND","offsetValue":"0 43","topic":"test_topic_name_bxronphj","sourceName":"kafka2x_auto_test","table":"sourceTableThree"}]
[{"sourceId":"537","columnsText":"cf ROW<id string, name varchar, age int>","cacheTTLMs":"60000","cache":"LRU","keyField":["id"],"cacheSize":"10000","columns":[{"column":"cf ROW<id string, name varchar, age int>"}],"parallelism":1,"createType":0,"type":8,"tableName":"Hbase1SideTable","hbasePrimaryKeyType":"string","sourceName":"hbase1x_auto_test","asyncPoolSize":5,"hbasePrimaryKey":"id","table":"fanshu_test_2"}]
[{"sourceId":"219","columnsText":"id int\nname varchar\nage int","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"createType":0,"type":37,"tableName":"kafkaResultTable","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sinkDataType":1,"topic":"fanshu3","partitionKeys":["id"],"sourceName":"kafka2x_auto_test","enableKeyPartitions":true},{"sourceId":"219","columnsText":"id int\nname varchar\nage int","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"createType":0,"type":37,"tableName":"kafkaResultTableOne","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sinkDataType":"dt_nest","topic":"fanshu4","sourceName":"kafka2x_auto_test"},{"sourceId":"215","columnsText":"id int\nname varchar\nage int","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"createType":0,"type":37,"tableName":"kafkaResultTableTwo","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sinkDataType":3,"topic":"fanshu7","sourceName":"kafka_stream"},{"sourceId":"219","columnsText":"id int\nname varchar\nage int","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"createType":0,"type":37,"tableName":"kafkaResultTableThree","bulkFlushMaxActions":100,"updateMode":"upsert","allReplace":"false","sinkDataType":"dt_nest","topic":"fanshu_2","sourceName":"kafka2x_auto_test","primaryKey":["id"]}]
CREATE TABLE sourceTable(
    id string,
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
CREATE TABLE kafkaResultTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu3',
    'sink.parallelism'='1'
 );
CREATE TABLE kafkaResultTableOne(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu4',
    'sink.parallelism'='1'
 );
CREATE TABLE kafkaResultTableTwo(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='avro',
    'topic'='fanshu7',
    'sink.parallelism'='1'
 );
CREATE TABLE kafkaResultTableThree(
    id int,
    name varchar,
    age int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='upsert-kafka-x',
    'value.format'='json',
    'value.fields-include'='ALL',
    'key.format'='json',
    'topic'='fanshu_2',
    'sink.parallelism'='1'
 );
CREATE TABLE Hbase1SideTable(
    id string,
    cf ROW<id string,
    name varchar,
    age int>,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='hbase14-x',
    'lookup.cache-type'='LRU',
    'zookeeper.quorum'='172.16.83.84:2181,172.16.83.101:2181,172.16.83.201:2181',
    'lookup.parallelism'='1',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='fanshu_test_2'
 );
INSERT  
INTO
    kafkaResultTable
    select
        cast(st.id as int) as id,
        mst.name as name,
        cast(mst.id as int) as age      
    from
        sourceTable st     
    left join
        Hbase1SideTable for SYSTEM_TIME as of st.proc_time as mst              
            on st.id = mst.id;

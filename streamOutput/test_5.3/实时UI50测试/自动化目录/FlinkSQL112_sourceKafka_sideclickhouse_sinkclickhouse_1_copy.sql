[{"sourceId":"219","columnsText":"id int\nname varchar\nage int","charset":"utf-8","_panelKey":"1673354422730345321","sourceDataType":1,"timeTypeArr":[1],"offset":0,"customParams":[],"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x_auto_test","table":"sourceTable"},{"sourceId":"219","columnsText":"id int\nname varchar\nage int\nstart_time timestamp","charset":"utf-8","_panelKey":"1673355178887720107","sourceDataType":1,"timeTypeArr":[1,2],"offset":10,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"},{"column":"start_time","type":"timestamp"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"latest","timeColumn":"start_time","offsetUnit":"SECOND","topic":"test_topic_name_gcwfybte","sourceName":"kafka2x_auto_test","table":"sourceTableOne"},{"sourceId":"219","columnsText":"id int\nname varchar\nage int","charset":"gbk2312","_panelKey":"1673355289637674590","timestampOffset":1673355324056,"sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"timestamp","offsetUnit":"SECOND","topic":"test_topic_name_wtzaudhp","sourceName":"kafka2x_auto_test","table":"sourceTableTwo"},{"sourceId":"219","columnsText":"id int\nname varchar\nage int","charset":"utf-8","_panelKey":"1673355340324158762","sourceDataType":2,"timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"custom","offsetUnit":"SECOND","offsetValue":"0 43","topic":"test_topic_name_bxronphj","sourceName":"kafka2x_auto_test","table":"sourceTableThree"}]
[{"sourceId":"175","cacheTTLMs":"60000","cache":"LRU","keyField":["id"],"cacheSize":"10000","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"idcard","type":"varchar"},{"column":"birthday","type":"date"},{"column":"mobile","type":"varchar"},{"column":"email","type":"varchar"},{"column":"gender","type":"int"},{"column":"create_time","type":"datetime"}],"parallelism":1,"createType":0,"type":25,"tableName":"clickhouseSideTable","sourceName":"clickhouse_auto_test","asyncPoolSize":5,"table":"stream_clickhouse_side_table","primaryKey":["id"]}]
[{"sourceId":"175","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"idcard","type":"varchar"},{"column":"birthday","type":"date"},{"column":"mobile","type":"varchar"},{"column":"email","type":"varchar"},{"column":"gender","type":"int"},{"column":"create_time","type":"datetime"}],"parallelism":1,"createType":0,"type":25,"batchWaitInterval":1000,"tableName":"clickhouseResultTable","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sourceName":"clickhouse_auto_test","batchSize":100,"table":"stream_clickhouse_result_table"}]
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
CREATE TABLE clickhouseResultTable(
    id int,
    name varchar,
    idcard varchar,
    birthday date,
    mobile varchar,
    email varchar,
    gender int,
    create_time STRING
 )WITH(
    'connector'='clickhouse-x',
    'sink.buffer-flush.interval'='1000',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='stream_clickhouse_result_table',
    'sink.parallelism'='1',
    'url'='jdbc:clickhouse://172.16.21.76:8123/test',
    'username'='default'
 );
CREATE TABLE clickhouseSideTable(
    id int,
    name varchar,
    idcard varchar,
    birthday date,
    mobile varchar,
    email varchar,
    gender int,
    create_time STRING,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='clickhouse-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='stream_clickhouse_side_table',
    'url'='jdbc:clickhouse://172.16.21.76:8123/test',
    'username'='default'
 );
INSERT    
INTO
    clickhouseResultTable
    select
        st.id,
        mst.name,
        mst.idcard,
        mst.birthday,
        mst.mobile,
        mst.email,
        mst.gender,
        mst.create_time              
    from
        sourceTable st               
    left join
        clickhouseSideTable for SYSTEM_TIME as of st.proc_time as mst                                        
            on st.id = mst.id;

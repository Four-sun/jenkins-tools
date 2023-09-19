[{"sourceId":"219","columnsText":"id int\nname varchar\nage int","charset":"utf-8","_panelKey":"1673354422730345321","sourceDataType":1,"timeTypeArr":[1],"offset":0,"customParams":[],"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x_auto_test","table":"sourceTable"}]
[{"sourceId":"163","cacheTTLMs":"60000","cache":"LRU","keyField":["id"],"cacheSize":"10000","columns":[{"column":"id","type":"INT"},{"column":"name","type":"STRING"},{"column":"idcard","type":"INT"}],"parallelism":1,"createType":0,"type":24,"tableName":"kuduSideTable","sourceName":"kudu_auto_test","asyncPoolSize":5,"table":"fanshu1","primaryKey":["id"]}]
[{"sourceId":"163","columns":[{"column":"id","type":"STRING"},{"column":"name","type":"STRING"}],"parallelism":1,"createType":0,"type":24,"batchWaitInterval":1000,"tableName":"kuduResultTableOne","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sourceName":"kudu_auto_test","batchSize":100,"table":"fanshuDemoOne","primaryKey":[]}]
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
CREATE TABLE kuduResultTableOne(
    id STRING,
    name STRING
 )WITH(
    'connector'='kudu-x',
    'sink.buffer-flush.interval'='1000',
    'masters'='172.16.100.109:7051',
    'session.mutation-buffer-space'='100',
    'table-name'='fanshuDemoOne',
    'sink.parallelism'='1'
 );
CREATE TABLE kuduSideTable(
    id INT,
    name STRING,
    idcard INT,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='kudu-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'lookup.cache.ttl'='60000',
    'masters'='172.16.100.109:7051',
    'lookup.cache.max-rows'='10000',
    'table-name'='fanshu1'
 );
INSERT  
INTO
    kuduResultTableOne
    select
        cast(st.id as varchar) as id,
        mst.name as name     
    from
        sourceTable st     
    left join
        kuduSideTable for SYSTEM_TIME as of st.proc_time as mst              
            on st.id = mst.id;

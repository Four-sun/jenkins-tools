[{"sourceId":"219","columnsText":"id int\nname varchar\nage int","charset":"utf-8","_panelKey":"1673354422730345321","sourceDataType":1,"timeTypeArr":[1],"offset":0,"customParams":[],"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x_auto_test","table":"sourceTable"}]
[{"sourceId":"167","cacheTTLMs":"60000","cache":"LRU","keyField":["id"],"cacheSize":"10000","columns":[{"column":"id","type":"int"},{"column":"start_time","type":"varchar"},{"column":"start_date","type":"varchar"},{"column":"start_timestamp","type":"timestamp"},{"column":"end_time","type":"varchar"},{"column":"end_date","type":"varchar"},{"column":"end_timestamp","type":"timestamp"},{"column":"age","type":"int"}],"parallelism":1,"createType":0,"type":29,"tableName":"impalaSideTable","sourceName":"impala_auto_test","asyncPoolSize":5,"table":"impala_fanshu_test_3","primaryKey":["id"]}]
[{"sourceId":"167","storeType":"parquet","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"createType":0,"type":29,"batchWaitInterval":1000,"tableName":"impalaResultTableOne","bulkFlushMaxActions":100,"updateMode":"upsert","allReplace":"false","sourceName":"impala_auto_test","batchSize":100,"isShowPartition":false,"table":"impala_fanshu_test_4","primaryKey":["id"]}]
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
CREATE TABLE impalaResultTableOne(
    id int,
    name varchar,
    age int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='impala-x',
    'schema-name'='default',
    'table-name'='impala_fanshu_test_4',
    'sink.parallelism'='1',
    'url'='jdbc:impala://172.16.100.32:21050/default;AuthMech=0'
 );
CREATE TABLE impalaSideTable(
    id int,
    start_time varchar,
    start_date varchar,
    start_timestamp timestamp,
    end_time varchar,
    end_date varchar,
    end_timestamp timestamp,
    age int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='impala-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'schema-name'='default',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='impala_fanshu_test_3',
    'url'='jdbc:impala://172.16.100.32:21050/default;AuthMech=0'
 );
INSERT  
INTO
    impalaResultTableOne
    select
        st.id,
        mst.start_time as name,
        mst.age as age      
    from
        sourceTable st     
    left join
        impalaSideTable for SYSTEM_TIME as of st.proc_time as mst              
            on st.id = mst.id;

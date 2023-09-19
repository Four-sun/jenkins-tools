[{"sourceId":"219","columnsText":"id int","charset":"utf-8","_panelKey":"1676020269384852373","sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x_auto_test","table":"sourceTable"}]
[{"sourceId":"167","cacheTTLMs":"60000","cache":"LRU","keyField":["id"],"cacheSize":"10000","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"idcard","type":"varchar"},{"column":"birthday","type":"varchar"},{"column":"mobile","type":"varchar"},{"column":"email","type":"varchar"},{"column":"gender","type":"int"},{"column":"create_time","type":"timestamp"},{"column":"pt","type":"varchar"}],"parallelism":1,"createType":0,"type":29,"tableName":"impalaSideTable","sourceName":"impala_auto_test","asyncPoolSize":5,"table":"stream_impala_side_table","primaryKey":["id"]}]
[{"sourceId":"167","storeType":"parquet","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"idcard","type":"varchar"},{"column":"birthday","type":"varchar"},{"column":"mobile","type":"varchar"},{"column":"email","type":"varchar"},{"column":"gender","type":"int"},{"column":"create_time","type":"timestamp"},{"column":"pt","type":"varchar"}],"parallelism":1,"createType":0,"type":29,"batchWaitInterval":1000,"tableName":"impalaResultTable","bulkFlushMaxActions":100,"updateMode":"upsert","allReplace":"false","sourceName":"impala_auto_test","batchSize":100,"isShowPartition":false,"table":"stream_impala_result_table","primaryKey":["id"]}]
CREATE TABLE sourceTable(
    id int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE impalaResultTable(
    id int,
    name varchar,
    idcard varchar,
    birthday varchar,
    mobile varchar,
    email varchar,
    gender int,
    create_time timestamp,
    pt varchar,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='impala-x',
    'schema-name'='default',
    'table-name'='stream_impala_result_table',
    'sink.parallelism'='1',
    'url'='jdbc:impala://172.16.100.32:21050/default;AuthMech=0'
 );
CREATE TABLE impalaSideTable(
    id int,
    name varchar,
    idcard varchar,
    birthday varchar,
    mobile varchar,
    email varchar,
    gender int,
    create_time timestamp,
    pt varchar,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='impala-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'schema-name'='default',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='stream_impala_side_table',
    'url'='jdbc:impala://172.16.100.32:21050/default;AuthMech=0'
 );
INSERT   
INTO
    impalaResultTable
    select
        st.id,
        mst.name,
        mst.idcard,
        mst.birthday,
        mst.mobile,
        mst.email,
        mst.gender,
        mst.create_time,
        mst.pt          
    from
        sourceTable st          
    left join
        impalaSideTable for SYSTEM_TIME as of st.proc_time as mst                           
            on st.id = mst.id;

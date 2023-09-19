[{"sourceId":"253","columnsText":"id int\nname varchar\nage int","charset":"utf-8","_panelKey":"168484237126870743","sourceDataType":1,"timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x237","table":"sourceTable"}]
[{"sourceId":"257","schema":"public","cacheTTLMs":"60000","cache":"ALL","keyField":["id"],"cacheSize":"10000","columns":[{"column":"id","type":"bigint"},{"column":"integer_data","type":"int"},{"column":"varchar_10_data","type":"varchar"},{"column":"timestamp_data","type":"timestamp"}],"parallelism":1,"createType":0,"type":4,"tableName":"postgresqlSideTable","sourceName":"postgresql_auto_test","asyncPoolSize":5,"table":"source_112_postgresql_all_type_one","primaryKey":["id"]}]
[{"sourceId":"257","schema":"public","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"createType":0,"type":4,"batchWaitInterval":1000,"tableName":"postgresqlResultTableOne","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sourceName":"postgresql_auto_test","batchSize":100,"table":"fanshu001","primaryKey":[]},{"sourceId":"257","schema":"public","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"createType":0,"type":4,"batchWaitInterval":1000,"tableName":"postgresqlResultTableTwo","bulkFlushMaxActions":100,"updateMode":"upsert","allReplace":"false","sourceName":"postgresql_auto_test","batchSize":100,"table":"fanshu001","primaryKey":["id"]},{"sourceId":"257","schema":"public","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"createType":0,"type":4,"batchWaitInterval":1000,"tableName":"postgresqlResultTableThree","bulkFlushMaxActions":100,"updateMode":"upsert","allReplace":"false","sourceName":"postgresql_auto_test","batchSize":100,"table":"fanshu001","primaryKey":["id","name","age"]}]
CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE postgresqlResultTableOne(
    id int,
    name varchar,
    age int
 )WITH(
    'password' = '******',
    'connector'='postgresql-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='public',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='fanshu001',
    'sink.parallelism'='1',
    'url'='jdbc:postgresql://172.16.101.246:5432/postgres',
    'username'='dtstack_rep'
 );
CREATE TABLE postgresqlResultTableTwo(
    id int,
    name varchar,
    age int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='postgresql-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='public',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='fanshu001',
    'sink.parallelism'='1',
    'url'='jdbc:postgresql://172.16.101.246:5432/postgres',
    'username'='dtstack_rep'
 );
CREATE TABLE postgresqlResultTableThree(
    id int,
    name varchar,
    age int,
    PRIMARY KEY(id,name,age) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='postgresql-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='public',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='fanshu001',
    'sink.parallelism'='1',
    'url'='jdbc:postgresql://172.16.101.246:5432/postgres',
    'username'='dtstack_rep'
 );
CREATE TABLE postgresqlSideTable(
    id bigint,
    integer_data int,
    varchar_10_data varchar,
    timestamp_data timestamp,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='postgresql-x',
    'lookup.cache-type'='ALL',
    'schema-name'='public',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='source_112_postgresql_all_type_one',
    'url'='jdbc:postgresql://172.16.101.246:5432/postgres',
    'username'='dtstack_rep'
 );
INSERT  
INTO
    postgresqlResultTableOne
    select
        st.id,
        mst.varchar_10_data as name,
        mst.integer_data as age     
    from
        sourceTable st     
    left join
        postgresqlSideTable for SYSTEM_TIME as of st.proc_time as mst              
            on st.id = mst.id;
INSERT  
INTO
    postgresqlResultTableTwo
    select
        st.id,
        mst.varchar_10_data as name,
        mst.integer_data as age     
    from
        sourceTable st     
    left join
        postgresqlSideTable for SYSTEM_TIME as of st.proc_time as mst              
            on st.id = mst.id;
INSERT  
INTO
    postgresqlResultTableThree
    select
        st.id,
        mst.varchar_10_data as name,
        mst.integer_data as age     
    from
        sourceTable st     
    left join
        postgresqlSideTable for SYSTEM_TIME as of st.proc_time as mst              
            on st.id = mst.id;

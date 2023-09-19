[{"sourceId":"169","columnsText":"id varchar\nname varchar\nage int\nstart_time timestamp","charset":"utf-8","_panelKey":"1661159734895194011","sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"varchar"},{"column":"name","type":"varchar"},{"column":"age","type":"int"},{"column":"start_time","type":"timestamp"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka_source","table":"sourceTable"}]
[{"sourceId":"191","columnsText":"id varchar\nname varchar\nage varchar","cacheTTLMs":"60000","cache":"LRU","keyField":"id","cacheSize":"10000","columns":[{"column":"id","type":"varchar"},{"column":"name","type":"varchar"},{"column":"age","type":"varchar"}],"parallelism":1,"createType":0,"table-input":"dtstack","type":12,"tableName":"redisSideTable","primaryKey-input":"id","sourceName":"redis144","asyncPoolSize":5,"table":"dtstack","primaryKey":"id"}]
[{"sourceId":"155","columns":[{"column":"id","type":"INT"},{"column":"name","type":"VARCHAR"},{"column":"age","type":"INT"}],"parallelism":1,"createType":0,"type":1,"batchWaitInterval":1000,"tableName":"mysqlResultTable","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sourceName":"mysql_automation","batchSize":100,"table":"stream_522_rabbitmq_result_two"}]
-- name redis_test
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-12-09 15:17:01
-- desc 
CREATE TABLE sourceTable(
    id varchar,
    name varchar,
    age int,
    start_time timestamp,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE mysqlResultTable(
    id INT,
    name VARCHAR,
    age INT
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='stream_522_rabbitmq_result_two',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE redisSideTable(
    id varchar,
    name varchar,
    age varchar,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
     'mode'='set',
    'password' = '******',
    'database'='0',
    'master-name'='mymaster',
    'connector'='redis-x',
    'lookup.parallelism'='1',
    'redis-type'='2',
    'table-name'='dtstack',
    'url'='172.16.82.144:26379,172.16.82.178:26379'
 );
INSERT     
INTO
    mysqlResultTable
    SELECT
        cast(st.id as int) as id,
        rst.name as name,
        st.age as age                   
    FROM
        sourceTable st      
    left join
        redisSideTable for SYSTEM_TIME as of st.proc_time as rst                      
            ON st.id = rst.id;


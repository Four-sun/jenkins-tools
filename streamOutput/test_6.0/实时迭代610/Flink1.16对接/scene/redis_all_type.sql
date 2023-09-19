[]
[]
[{"sourceId":"303","columnsText":"id int\nname varchar","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"}],"parallelism":1,"dataType":"string","createType":0,"table-input":"stream_test_1","type":12,"tableName":"redisResultTable","mode":"hset","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","primaryKey-input":"id","sourceName":"redis_144","table":"stream_test_1","primaryKey":"id"}]
CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_redis_all_type',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE redisResultTable(
    id int,
    name varchar,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'mode'='hset',
    'password' = '******',
    'database'='0',
    'master-name'='mymaster',
    'connector'='redis-x',
    'redis-type'='2',
    'table-name'='stream_test_1',
    'sink.parallelism'='1',
    'type'='string',
    'url'='172.16.82.144:26379'
 );
INSERT
INTO
    redisResultTable
    select
        id,
        name
    from
        sourceTable;


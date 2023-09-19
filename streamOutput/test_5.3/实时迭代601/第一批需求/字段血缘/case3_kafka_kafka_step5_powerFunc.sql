CREATE TABLE sourceTable(
    id int,
    id1 int,
    id2 int,
    id3 int,
    id4 int,
    id5 int,
    name1 varchar,
    name2 varchar,
    name3 varchar,
    name4 varchar,
    name5 varchar,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='stream_blood_seven',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE mysqlSideTable(
    id INT,
    varchar_data VARCHAR,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='stream_mysql_ogg_one',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE kafkaResultTable(
    id int,
    countnum int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='stream_blood_eight',
    'sink.parallelism'='1'
 );
-- name blood_kafka_mysql_kafka
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-02-16 15:11:28
-- desc
insert  
into
    kafkaResultTable
    select
        t.id AS id,
        cast(POWER(t.id,t.id1) as int) as countnum          
    from
        sourceTable t       
    where
        t.name1 = 'name';

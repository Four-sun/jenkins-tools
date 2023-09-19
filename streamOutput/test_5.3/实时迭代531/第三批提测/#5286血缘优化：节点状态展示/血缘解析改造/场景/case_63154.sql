-- name case_63154
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-12-09 15:17:01
-- desc 
CREATE TABLE MyTable(
    id INT,
    channel VARCHAR,
    start_time TIMESTAMP,
    name VARCHAR,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_three_dim_join',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyResult(
    id INT,
    dt_time VARCHAR,
    name1 VARCHAR,
    name2 VARCHAR,
    name3 VARCHAR,
    name4 VARCHAR,
    time_info VARCHAR,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_threedimjoin_resulttableone',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE SideTable1(
    id INT,
    name VARCHAR,
    channel VARCHAR,
    time_info VARCHAR,
    flag VARCHAR,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='threedimjoin_sidetableone',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE SideTable2(
    id INT,
    name VARCHAR,
    channel VARCHAR,
    time_info VARCHAR,
    flag VARCHAR,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='threedimjoin_sidetabletwo',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE SideTable3(
    id INT,
    name VARCHAR,
    channel VARCHAR,
    time_info VARCHAR,
    flag VARCHAR,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='threedimjoin_sidetablethree',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
insert
into
    MyResult
    select
        t1.id AS id,
        cast(t1.start_time as varchar) as dt_time,
        t1.name as name1,
        t2.name as name2,
        t3.name as name3,
        t4.name as name4,
        t2.time_info as time_info
    from
        (     select
            id,
            name,
            channel,
            start_time,
            proc_time
        from
            MyTable     ) t1
    left join
        SideTable1 for SYSTEM_TIME as of t1.proc_time as t2
            on  t1.channel = t2.channel
    join
        SideTable2 for SYSTEM_TIME as of t1.proc_time as t3
            on t1.channel = t3.channel
    join
        SideTable3 for SYSTEM_TIME as of t1.proc_time as t4
            on t1.channel = t4.channel
    where
        t1.name = 'name';


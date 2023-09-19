


-- 已验证通过
CREATE TABLE MyTable(
    id INT,
    name VARCHAR,
    channel VARCHAR,
    start_time TIMESTAMP,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_two_dim_join',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyResult(
    id INT,
    dt_time VARCHAR,
    name1 VARCHAR,
    name2 VARCHAR,
    name3 VARCHAR,
    time_info VARCHAR
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_twodimjoin_resulttableone',
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
    'table-name'='twodimjoin_sidetableone',
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
    'table-name'='twodimjoin_sidetabletwo',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
insert
into
    MyResult
    select
        t1.id AS id,
        cast(t1.start_time as varchar) AS dt_time,
        t1.name AS name1,
        t2.name AS name2,
        t3.name AS name3,
        t2.time_info AS time_info
    from
        (     select
            id,
            name,
            channel,
            start_time,
            proc_time
        from
            MyTable      ) t1
    left join
        SideTable1 for SYSTEM_TIME as of t1.proc_time as t2
            on  t1.channel = t2.channel
    join
        SideTable2 for SYSTEM_TIME as of t1.proc_time as t3
            on t1.channel = t3.channel
            and t2.flag = t3.flag
    where
        t1.name = 'name';


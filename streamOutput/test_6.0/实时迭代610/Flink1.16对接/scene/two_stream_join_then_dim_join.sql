


-- 已验证通过
CREATE TABLE MyTableOne(
    id int,
    channel varchar,
    age INT,
    start_time timestamp(3),
    WATERMARK FOR start_time AS start_time - INTERVAL'10'SECOND,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_two_stream_one',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyTableTwo(
    id int,
    channel varchar,
    age INT,
    start_time timestamp(3),
    WATERMARK FOR start_time AS start_time - INTERVAL'10'SECOND,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_two_stream_two',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyResult(
    id INT,
    channel VARCHAR,
    pv VARCHAR,
    name VARCHAR,
    my_time TIMESTAMP,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_twostreamjointhendimjoin_resulttableone',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE SideTableOne(
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
    'table-name'='twostreamjointhendimjoin_sidetableone',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
insert
into
    MyResult
    SELECT
        o.id as id,
        o.channel as channel,
        cast(o.age as VARCHAR ) as pv,
        t1.name as name,
        cast (o.proc_time as timestamp ) as my_time
    FROM
        MyTableOne o
    left join
        MyTableTwo s
            on o.channel = s.channel
    join
        SideTableOne for SYSTEM_TIME as of o.proc_time as t1
            on o.channel = t1.channel
    WHERE
        o.proc_time BETWEEN s.proc_time - INTERVAL '1' HOUR AND s.proc_time
        and t1.name LIKE  '%name%';


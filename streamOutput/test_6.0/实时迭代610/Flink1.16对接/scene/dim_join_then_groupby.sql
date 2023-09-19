


-- 已验证通过
CREATE TABLE MyTable(
    id INT,
    name VARCHAR,
    channel VARCHAR,
    start_time TIMESTAMP(3),
    WATERMARK FOR start_time AS start_time - INTERVAL'60'SECOND,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_dim_join_then_groupby',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyResult(
    id INT,
    countnum INT
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_dim_join_then_groupby_result',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE sideTableA(
    id INT,
    channel VARCHAR,
    time_info VARCHAR,
    name VARCHAR,
    price DOUBLE,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='dimjointhengroupby_sidetableone',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
insert
into
    MyResult
    select
        t.id AS id,
        cast (count(t.id) as int)  as countnum
    from
        MyTable t
    left join
        sideTableA for SYSTEM_TIME as of t.proc_time as s
            on  t.channel = s.channel
    where
        t.name = 'name'
    group by
        t.id         ,
        TUMBLE(t.proc_time,
        INTERVAL '60' SECOND);


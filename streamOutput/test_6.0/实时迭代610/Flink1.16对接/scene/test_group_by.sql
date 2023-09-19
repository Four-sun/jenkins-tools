


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
    'topic'='sourec_112_test_group_by',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyResult(
    id INT,
    name VARCHAR,
    message VARCHAR,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_testgroupby_result',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE SideTable(
    id INT,
    name VARCHAR,
    address VARCHAR,
    school VARCHAR,
    message VARCHAR,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='testgroupby_sidetableone',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
insert
into
    MyResult
    select
        sum(b.id) as id,
        b.name as name,
        SUBSTRING(message,
        1,
        10) as message
    from
        (select
            a.name,
            a.id as id,
            cast(a.start_time as varchar) as message
        from
            MyTable a   ) b
    group by
        SUBSTRING(message,
        1,
        10),
        b.name;


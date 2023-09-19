CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE kuduSideTable(
    id INT,
    name STRING,
    idcard INT,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='kudu-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'lookup.cache.ttl'='60000',
    'masters'='172.16.100.109:7051',
    'lookup.cache.max-rows'='10000',
    'table-name'='fanshu1'
 );
CREATE TABLE kuduResultTableOne(
    id STRING,
    name STRING,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'sink.write-mode'='upsert',
    'connector'='kudu-x',
    'sink.buffer-flush.interval'='1000',
    'masters'='172.16.100.109:7051',
    'session.mutation-buffer-space'='100',
    'table-name'='fanshuDemoOne',
    'sink.parallelism'='1'
 );
-- desc kudu维表
INSERT 
INTO
    kuduResultTableOne
    select
        cast(st.id as varchar) as id,
        agg002(mst.name) as name
    from
        sourceTable st
    left join
        kuduSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;

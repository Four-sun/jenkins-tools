


-- 已验证通过
CREATE TABLE sourceTable(
    id int,
    name varchar,
    varchar_data varchar,
    tinyint_data tinyint,
    float_data float,
    double_data double,
    date_data date,
    time_data time,
    timestamp_data timestamp,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_clickhouse_all_type',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE clickhouseResultTable(
    id int,
    name varchar,
    idcard varchar,
    birthday date,
    mobile varchar,
    email varchar,
    gender int,
    create_time STRING
 )WITH(
    'connector'='clickhouse-x',
    'sink.buffer-flush.interval'='1000',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='stream_clickhouse_result_table',
    'sink.parallelism'='1',
    'url'='jdbc:clickhouse://172.16.21.76:8123/test',
    'username'='default'
 );
CREATE TABLE clickhouseSideTable(
    id int,
    name varchar,
    idcard varchar,
    birthday date,
    mobile varchar,
    email varchar,
    gender int,
    create_time STRING,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='clickhouse-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='stream_clickhouse_side_table',
    'url'='jdbc:clickhouse://172.16.21.76:8123/test',
    'username'='default'
 );
INSERT
INTO
    clickhouseResultTable
    select
        st.id,
        mst.name,
        mst.idcard,
        mst.birthday,
        mst.mobile,
        mst.email,
        mst.gender,
        mst.create_time
    from
        sourceTable st
    left join
        clickhouseSideTable for SYSTEM_TIME as of st.proc_time as mst
            on st.id = mst.id;


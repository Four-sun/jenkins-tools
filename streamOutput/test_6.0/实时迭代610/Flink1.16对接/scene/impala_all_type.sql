


-- 已验证通过
CREATE TABLE sourceTable(
    id int,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_impala_all_type',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE impalaResultTable(
    id int,
    name varchar,
    idcard varchar,
    birthday varchar,
    mobile varchar,
    email varchar,
    gender int,
    create_time timestamp,
    pt varchar,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='impala-x',
    'schema-name'='default',
    'table-name'='stream_impala_result_table',
    'sink.parallelism'='1',
    'url'='jdbc:impala://172.16.100.32:21050/default'
 );
CREATE TABLE impalaSideTable(
    id int,
    name varchar,
    idcard varchar,
    birthday varchar,
    mobile varchar,
    email varchar,
    gender int,
    create_time timestamp,
    pt varchar,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='impala-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'schema-name'='default',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='stream_impala_side_table',
    'url'='jdbc:impala://172.16.100.32:21050/default'
 );
INSERT
INTO
    impalaResultTable
    select
        st.id,
        mst.name,
        mst.idcard,
        mst.birthday,
        mst.mobile,
        mst.email,
        mst.gender,
        mst.create_time,
        mst.pt
    from
        sourceTable st
    left join
        impalaSideTable for SYSTEM_TIME as of st.proc_time as mst
            on st.id = mst.id;


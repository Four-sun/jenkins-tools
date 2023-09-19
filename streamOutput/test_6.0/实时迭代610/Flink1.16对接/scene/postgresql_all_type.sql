


-- 数据库权限问题
CREATE TABLE sourceTable(
    id int,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_postgresql_all_type',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE postgresqlResultTable(
    id bigint,
    smallint_data smallint,
    integer_data int,
    bigint_data bigint,
    decimal_data decimal,
    numeric_data decimal,
    real_data float,
    double_data double,
    character_10_data varchar,
    varchar_10_data varchar,
    char_10_data varchar,
    text_data varchar,
    bytea_data BYTES,
    timestamp_data timestamp,
    date_data date,
    time_data time,
    boolean_data boolean
 )WITH(
    'password' = '******',
    'connector'='postgresql-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='public',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_postgresql_all_type',
    'sink.parallelism'='1',
    'url'='jdbc:postgresql://172.16.101.246:5432/postgres',
    'username'='postgres'
 );
 
CREATE TABLE postgresqlSideTable(
    id bigint,
    smallint_data smallint,
    integer_data int,
    bigint_data bigint,
    decimal_data decimal,
    numeric_data decimal,
    real_data float,
    double_data double,
    character_10_data varchar,
    varchar_10_data varchar,
    char_10_data varchar,
    text_data varchar,
    bytea_data BYTES,
    timestamp_data timestamp,
    date_data date,
    time_data time,
    boolean_data boolean
 )WITH(
    'password' = '******',
    'connector'='postgresql-x',
    'lookup.cache-type'='LRU',
    'schema-name'='public',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='source_112_postgresql_all_type',
    'url'='jdbc:postgresql://172.16.101.246:5432/postgres',
    'username'='postgres'
 );
INSERT
INTO
    postgresqlResultTable
    SELECT
        st.id,
        sst.smallint_data,
        sst.integer_data,
        sst.bigint_data,
        sst.numeric_data,
        sst.decimal_data,
        sst.real_data,
        sst.double_data,
        sst.character_10_data,
        sst.varchar_10_data,
        sst.char_10_data,
        sst.text_data,
        sst.bytea_data,
        sst.timestamp_data,
        sst.date_data,
        sst.time_data,
        sst.boolean_data
    FROM
        sourceTable st
    LEFT JOIN
        postgresqlSideTable FOR SYSTEM_TIME AS OF st.proc_time AS sst
            ON st.id = sst.id;


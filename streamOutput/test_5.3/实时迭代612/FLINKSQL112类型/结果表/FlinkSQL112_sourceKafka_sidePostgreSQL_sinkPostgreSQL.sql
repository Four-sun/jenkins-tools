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
CREATE TABLE postgresqlSideTable(
    id bigint,
    integer_data int,
    varchar_10_data varchar,
    timestamp_data timestamp,
    PRIMARY KEY(id) NOT ENFORCED
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
    'url'='jdbc:postgresql://172.16.101.246:5432/postgres?stringtype=unspecified',
    'username'='postgres'
 );
CREATE TABLE postgresqlResultTableOne(
    id int,
    name varchar,
    age varchar
 )WITH(
    'password' = '******',
    'connector'='postgresql-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='public',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='postgresql_output_test',
    'sink.parallelism'='1',
    'url'='jdbc:postgresql://172.16.101.246:5432/postgres?stringtype=unspecified',
    'username'='postgres'
 );
CREATE TABLE postgresqlResultTableTwo(
    id int,
    name varchar,
    age varchar,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='postgresql-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='public',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='postgresql_output_test',
    'sink.parallelism'='1',
    'url'='jdbc:postgresql://172.16.101.246:5432/postgres?stringtype=unspecified',
    'username'='postgres'
 );
CREATE TABLE postgresqlResultTableThree(
    id int,
    name varchar,
    age varchar,
    PRIMARY KEY(id,name) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='postgresql-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='public',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='postgresql_output_test',
    'sink.parallelism'='1',
    'url'='jdbc:postgresql://172.16.101.246:5432/postgres?stringtype=unspecified',
    'username'='postgres'
 );
-- name FlinkSQL112_sourceKafka_sidePostgreSQL_sinkPostgreSQL
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-22 13:43:36
-- desc FlinkSQL112_sourceKafka_sidePostgreSQL_sinkPostgreSQL
INSERT 
INTO
    postgresqlResultTableOne
    select
        st.id,
        mst.varchar_10_data as name,
        cast(mst.integer_data as VARCHAR ) as age
    from
        sourceTable st
    left join
        postgresqlSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;
INSERT 
INTO
    postgresqlResultTableTwo
    select
        st.id,
        mst.varchar_10_data as name,
        cast(mst.integer_data as VARCHAR ) as age
    from
        sourceTable st
    left join
        postgresqlSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;
INSERT 
INTO
    postgresqlResultTableThree
    select
        st.id,
        mst.varchar_10_data as name,
        cast(mst.integer_data as VARCHAR ) as age
    from
        sourceTable st
    left join
        postgresqlSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;


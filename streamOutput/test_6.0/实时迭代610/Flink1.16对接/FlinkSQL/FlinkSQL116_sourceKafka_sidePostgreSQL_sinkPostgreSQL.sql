CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
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
    'lookup.cache-type'='ALL',
    'schema-name'='public',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'table-name'='source_112_postgresql_all_type_one',
    'lookup.cache-period'='60000',
    'url'='jdbc:postgresql://172.16.101.246:5432/postgres',
    'username'='dtstack_rep'
 );
CREATE TABLE postgresqlResultTableOne(
    id int,
    name varchar,
    age int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='postgresql-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='public',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='fanshu001',
    'sink.parallelism'='1',
    'url'='jdbc:postgresql://172.16.101.246:5432/postgres',
    'username'='dtstack_rep'
 );
CREATE TABLE postgresqlResultTableTwo(
    id int,
    name varchar,
    age int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='postgresql-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='public',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='fanshu001',
    'sink.parallelism'='1',
    'url'='jdbc:postgresql://172.16.101.246:5432/postgres',
    'username'='dtstack_rep'
 );
CREATE TABLE postgresqlResultTableThree(
    id int,
    name varchar,
    age int,
    PRIMARY KEY(id,name,age) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='postgresql-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='public',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='fanshu001',
    'sink.parallelism'='1',
    'url'='jdbc:postgresql://172.16.101.246:5432/postgres',
    'username'='dtstack_rep'
 );
-- name FlinkSQL116_sourceKafka_sidePostgreSQL_sinkPostgreSQL
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-23 19:45:39
-- desc 
-- desc FlinkSQL112_sourceKafka_sidePostgreSQL_sinkPostgreSQL11
INSERT 
INTO
    postgresqlResultTableOne
    select
        st.id,
        mst.varchar_10_data as name,
        mst.integer_data as age
    from
        sourceTable st
    left join
        postgresqlSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;

-- INSERT 
-- INTO
--     postgresqlResultTableTwo
--     select
--         st.id,
--         mst.varchar_10_data as name,
--         mst.integer_data as age
--     from
--         sourceTable st
--     left join
--         postgresqlSideTable for SYSTEM_TIME as of st.proc_time as mst 
--             on st.id = mst.id;

-- INSERT 
-- INTO
--     postgresqlResultTableThree
--     select
--         st.id,
--         mst.varchar_10_data as name,
--         mst.integer_data as age
--     from
--         sourceTable st
--     left join
--         postgresqlSideTable for SYSTEM_TIME as of st.proc_time as mst 
--             on st.id = mst.id;

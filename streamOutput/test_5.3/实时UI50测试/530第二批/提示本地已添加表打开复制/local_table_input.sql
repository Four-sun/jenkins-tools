CREATE TABLE sourceTable(
    id int,
    name varchar,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='dujie_test1_5_k3',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE mysqlSideTable(
    mid INT,
    mstime TIME,
    mbb VARCHAR,
    metime TIMESTAMP,
    PRIMARY KEY(mid) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='4tablejoin_sidefour_11',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE mysqlResultTable(
    sink_id INT,
    sink_name VARCHAR,
    sink_start_time TIME,
    sink_school VARCHAR,
    sink_message VARCHAR,
    sink_end_time TIMESTAMP
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='4tablejoin_resulttable',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
-- name local_table_input
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-11-23 11:55:01
-- desc 
INSERT 
INTO
    mysqlResultTable
    select
        st.id 
    from
        sourceTable st 
    left join
        mysqlSideTable mst 
            on st.id = mst.id;


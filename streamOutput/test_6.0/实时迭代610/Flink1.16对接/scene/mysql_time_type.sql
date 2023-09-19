


CREATE TABLE sourceTable(
    id int,
    DECIMAL_DATA decimal,
    VARCHAR_DATA varchar,
    DATE_DATA date,
    TIMESTAMP_DATA timestamp,
    DATETIME_DATA STRING,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_mysql_time_type_one',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE mysqlResultTable(
    id INT,
    timestamp_data TIMESTAMP,
    datetime_data STRING,
    date_data DATE,
    time_data TIME
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_mysql_time_type_table_two',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE mysqlSideTable(
    id INT,
    timestamp_data TIMESTAMP,
    datetime_data STRING,
    date_data DATE,
    time_data TIME,
    PRIMARY KEY(id,datetime_data) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='result_112_mysql_time_type_table',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
INSERT
INTO
    mysqlResultTable
    SELECT
        st.id,
        ost.timestamp_data,
        ost.datetime_data,
        ost.date_data,
        ost.time_data
    FROM
        sourceTable st
    LEFT JOIN
        mysqlSideTable for SYSTEM_TIME as of st.proc_time as ost
            on  st.id = ost.id
            and st.DATETIME_DATA = ost.datetime_data;


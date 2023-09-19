


CREATE TABLE sourceTable(
    id int,
    DECIMAL_DATA decimal,
    VARCHAR_DATA varchar,
    DATE_DATA date,
    TIMESTAMP_DATA timestamp,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_sqlserver_date_type',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE sqlserverResultTable(
    id bigint,
    date_data date,
    time_data time,
    datetime_data TIMESTAMP(3),
    datetime2_data TIMESTAMP(7),
    smalldatetime_data TIMESTAMP(0),
    datetimeoffset_data TIMESTAMP(0)
 )WITH(
    'password' = '******',
    'connector'='sqlserver-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='dbo',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='source_112_sqlserver_all_type_three',
    'sink.parallelism'='1',
    'url'='jdbc:sqlserver://172.16.101.246:1433;database=db_test',
    'username'='sa'
 );
CREATE TABLE sqlserverSideTable(
    id bigint,
    date_data date,
    time_data time,
    datetime_data TIMESTAMP(3),
    datetime2_data TIMESTAMP(7),
    smalldatetime_data TIMESTAMP(0),
    datetimeoffset_data TIMESTAMP(0),
    PRIMARY KEY(id,date_data) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='sqlserver-x',
    'lookup.cache-type'='LRU',
    'schema-name'='dbo',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='source_112_sqlserver_all_type_one',
    'url'='jdbc:sqlserver://172.16.101.246:1433;database=db_test',
    'username'='sa'
 );
INSERT
INTO
    sqlserverResultTable
    SELECT
        st.id,
        ost.date_data,
        ost.time_data,
        ost.datetime_data,
        ost.datetime2_data,
        ost.smalldatetime_data,
        ost.datetimeoffset_data
    FROM
        sourceTable st
    LEFT JOIN
        sqlserverSideTable for SYSTEM_TIME as of st.proc_time as ost
            on  st.id = ost.id
            and st.DATE_DATA  = ost.date_data;


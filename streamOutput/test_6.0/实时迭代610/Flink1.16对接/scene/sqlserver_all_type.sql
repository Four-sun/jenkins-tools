


-- 已验证通过
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
    'topic'='source_112_sqlserver_all_type',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE sqlserverResultTable(
    id bigint,
    char_data char,
    varchar_data varchar,
    varchar_255_data varchar,
    nvarchar_data varchar,
    nvarchar_255_data varchar,
    nchar_data char,
    text_data varchar,
    ntext_data varchar,
    decimal_data decimal,
    money_data decimal(10,0) ,
    smallmoney_data decimal(10,0) ,
    numeric_data numeric,
    bit_data boolean,
    int_data int,
    tinyint_data tinyint,
    smallint_data smallint,
    bigint_data bigint,
    date_data date,
    time_data time,
    datetime_data TIMESTAMP(3),
    datetime2_data TIMESTAMP(7),
    smalldatetime_data TIMESTAMP(0)
 )WITH(
    'password' = '******',
    'connector'='sqlserver-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='dbo',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_sqlserver_all_type',
    'sink.parallelism'='1',
    'url'='jdbc:sqlserver://172.16.101.246:1433;database=db_test',
    'username'='sa'
 );
CREATE TABLE sqlserverSideTable(
    id bigint,
    char_data char,
    varchar_data varchar,
    varchar_255_data varchar,
    nvarchar_data varchar,
    nvarchar_255_data varchar,
    nchar_data char,
    text_data varchar,
    ntext_data varchar,
    decimal_data decimal,
    money_data decimal,
    smallmoney_data decimal,
    numeric_data numeric,
    float_data float,
    real_data float,
    bit_data boolean,
    int_data int,
    tinyint_data tinyint,
    smallint_data smallint,
    bigint_data bigint,
    date_data date,
    time_data time,
    datetime_data TIMESTAMP(3),
    datetime2_data TIMESTAMP(7),
    smalldatetime_data TIMESTAMP(0),
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='sqlserver-x',
    'lookup.cache-type'='LRU',
    'schema-name'='dbo',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='source_112_sqlserver_all_type',
    'url'='jdbc:sqlserver://172.16.101.246:1433;database=db_test',
    'username'='sa'
 );
INSERT
INTO
    sqlserverResultTable
    SELECT
        st.id,
        sst.char_data,
        sst.varchar_data,
        sst.varchar_255_data,
        sst.nvarchar_data,
        sst.nvarchar_255_data,
        sst.nchar_data,
        sst.text_data,
        sst.ntext_data,
        sst.decimal_data,
        sst.money_data,
        sst.smallmoney_data,
        sst.numeric_data,
        sst.bit_data,
        sst.int_data,
        sst.tinyint_data,
        sst.smallint_data,
        sst.bigint_data,
        sst.date_data,
        sst.time_data,
        sst.datetime_data,
        sst.datetime2_data,
        sst.smalldatetime_data
    FROM
        sourceTable st
    LEFT JOIN
        sqlserverSideTable FOR SYSTEM_TIME AS OF st.proc_time AS sst
            ON st.id = sst.id;


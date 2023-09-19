


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
    'topic'='source_112_oracle_all_type',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE oracleResultTable(
    ID decimal,
    NUMBER_38_DATA decimal,
    NUMBER_38_5_DATA decimal,
    FLOAT_DATA decimal,
    FLOAT_38_DATA decimal,
    LONG_DATA varchar,
    CHAR_255_DATA char,
    NCHAR_255_DATA varchar,
    NVARCHAR2_255_DATA varchar,
    VARCHAR_255_DATA varchar,
    VARCHAR2_255_DATA varchar,
    DATE_DATA timestamp,
    TIMESTAMP_DATA timestamp
 )WITH(
    'password' = '******',
    'connector'='oracle-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='SHIXIAO',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='RESULT_112_ORACLE_ALL_TYPE',
    'sink.parallelism'='1',
    'url'='jdbc:oracle:thin:@172.16.100.243:1521:orcl',
    'username'='shixiao'
 );
CREATE TABLE oracleSideTable(
    ID decimal,
    NUMBER_38_DATA decimal,
    NUMBER_38_5_DATA decimal,
    FLOAT_DATA decimal,
    FLOAT_38_DATA decimal,
    LONG_DATA varchar,
    CHAR_255_DATA char,
    NCHAR_255_DATA varchar,
    NVARCHAR2_255_DATA varchar,
    VARCHAR_255_DATA varchar,
    VARCHAR2_255_DATA varchar,
    DATE_DATA timestamp,
    TIMESTAMP_DATA timestamp,
    PRIMARY KEY(ID) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='oracle-x',
    'lookup.cache-type'='LRU',
    'schema-name'='SHIXIAO',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='SOURCE_112_ORACLE_ALL_TYPE',
    'url'='jdbc:oracle:thin:@172.16.100.243:1521:orcl',
    'username'='shixiao'
 );
INSERT
INTO
    oracleResultTable
    SELECT
        cast(st.id as decimal(10,
        0)) as ID,
        ost.NUMBER_38_DATA,
        ost.NUMBER_38_5_DATA,
        ost.FLOAT_DATA,
        ost.FLOAT_38_DATA,
        ost.LONG_DATA,
        ost.CHAR_255_DATA,
        ost.NCHAR_255_DATA,
        ost.NVARCHAR2_255_DATA,
        ost.VARCHAR_255_DATA,
        ost.VARCHAR2_255_DATA,
        ost.DATE_DATA,
        ost.TIMESTAMP_DATA
    FROM
        sourceTable st
    LEFT JOIN
        oracleSideTable FOR SYSTEM_TIME AS OF st.proc_time AS ost
            ON st.id = ost.ID;


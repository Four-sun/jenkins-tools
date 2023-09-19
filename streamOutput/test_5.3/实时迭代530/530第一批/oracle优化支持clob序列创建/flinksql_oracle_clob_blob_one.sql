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
CREATE TABLE oracleSideTable(
    ID decimal,
    FLOAT_DATA decimal,
    DOUBLE_DATA decimal,
    NUMBER_1 decimal,
    CHAR_255 varchar,
    NCHAR_255 varchar,
    NVARCHAR2_255 varchar,
    VARCHAR_255 varchar,
    VARCHAR2_255 varchar,
    CLOB_DATA varchar(4001) ,
    BLOB_DATA bytes,
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
    'table-name'='FLINKX_NEW_ALL_TYPE_ONE',
    'url'='jdbc:oracle:thin:@172.16.100.243:1521:orcl',
    'username'='shixiao'
 );
CREATE TABLE oracleResultTable(
    ID decimal,
    FLOAT_DATA decimal,
    DOUBLE_DATA decimal,
    NUMBER_1 decimal,
    CHAR_255 varchar,
    NCHAR_255 varchar,
    NVARCHAR2_255 varchar,
    VARCHAR_255 varchar,
    VARCHAR2_255 varchar,
    CLOB_DATA varchar(4001) ,
    BLOB_DATA bytes,
    DATE_DATA timestamp,
    TIMESTAMP_DATA timestamp
 )WITH(
    'password' = '******',
    'connector'='oracle-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='SHIXIAO',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='FLINKX_NEW_ALL_TYPE_TWO',
    'sink.parallelism'='1',
    'url'='jdbc:oracle:thin:@172.16.100.243:1521:orcl',
    'username'='shixiao'
 );
-- name flinksql_oracle_clob_blob_one
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-09-27 16:32:40
-- desc
INSERT 
INTO
    oracleResultTable
    select
        ost.ID,
        ost.FLOAT_DATA,
        ost.DOUBLE_DATA,
        ost.NUMBER_1,
        ost.CHAR_255,
        ost.NCHAR_255,
        ost.NVARCHAR2_255,
        ost.VARCHAR_255,
        ost.VARCHAR2_255,
        ost.CLOB_DATA,
        ost.BLOB_DATA,
        ost.DATE_DATA,
        ost.TIMESTAMP_DATA 
    FROM
        sourceTable st 
    LEFT JOIN
        oracleSideTable for SYSTEM_TIME as of st.proc_time as ost 
            ON st.id = ost.ID;


CREATE TABLE oracleSideTable(
    ID decimal,
    NVARCHAR2_255 varchar,
    VARCHAR_255 varchar,
    VARCHAR2_255 varchar,
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
    'table-name'='FLINKX_CDC_ALL_TYPE',
    'url'='jdbc:oracle:thin:@172.16.100.243:1521:orcl',
    'username'='shixiao'
 );

-- name HiveKafka_HiveOracle_HiveKafka_One
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-12-30 11:51:01
-- desc
INSERT 
INTO
    stream_600_test.stream_db_600.kafkaresulttable
    select
        st.id,
        ost.VARCHAR_255 as name,
        st.age 
    from
        stream_600_test.stream_db_600.sourcetableone st 
    left join
        oracleSideTable for SYSTEM_TIME as of st.proc_time as ost
    on st.id =ost.ID ;

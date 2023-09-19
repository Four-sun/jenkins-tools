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
CREATE TABLE sourceTableOne(
    id int,
    name varchar,
    age int,
    start_time timestamp,
    WATERMARK FOR start_time AS start_time - INTERVAL'10'SECOND,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='test_topic_name_gcwfybte',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE sourceTableTwo(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'scan.startup.timestamp-millis'='1673355324056',
    'topic'='test_topic_name_wtzaudhp',
    'scan.startup.mode'='timestamp'
 );
CREATE TABLE sourceTableThree(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'scan.startup.specific-offsets'='partition:0,offset:43',
    'format'='csv',
    'topic'='test_topic_name_bxronphj',
    'scan.startup.mode'='specific-offsets'
 );
CREATE TABLE sqlserverSideTableOne(
    id bigint,
    varchar_data varchar,
    int_data int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'lookup.error-limit'='1000',
    'connector'='sqlserver-x',
    'lookup.cache-type'='LRU',
    'schema-name'='dbo',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='1',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='source_112_sqlserver_all_type',
    'url'='jdbc:sqlserver://172.16.101.246:1433;database=db_test',
    'username'='sa'
 );
CREATE TABLE sqlserverSideTableTwo(
    id bigint,
    varchar_data varchar,
    int_data int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='sqlserver-x',
    'lookup.cache-type'='None',
    'schema-name'='dbo',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='1',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='source_112_sqlserver_all_type_one',
    'url'='jdbc:sqlserver://172.16.101.246:1433;database=db_test',
    'username'='sa'
 );
CREATE TABLE sqlserverSideTableThree(
    id bigint,
    varchar_data varchar,
    int_data int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'lookup.error-limit'='1000',
    'url'='jdbc:sqlserver://172.16.101.246:1433;database=db_test',
    'password' = '******',
    'connector'='sqlserver-x',
    'lookup.cache-type'='ALL',
    'schema-name'='dbo',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'table-name'='source_112_sqlserver_all_type_one',
    'lookup.cache-period'='60000',
    'username'='sa'
 );
CREATE TABLE kafkaResultTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='csv',
    'key.format'='json',
    'topic'='fanshu3',
    'sink.parallelism'='1',
    'key.fields'='id',
    'sink.partitioner'='com.dtstack.chunjun.connector.kafka.partitioner.CustomerFlinkPartition'
 );
CREATE TABLE kafkaResultTableOne(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu4',
    'sink.parallelism'='1'
 );
CREATE TABLE kafkaResultTableTwo(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='avro',
    'topic'='fanshu7',
    'sink.parallelism'='1'
 );
CREATE TABLE kafkaResultTableThree(
    id int,
    name varchar,
    age int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='upsert-kafka-x',
    'value.format'='json',
    'value.fields-include'='ALL',
    'key.format'='json',
    'topic'='fanshu_2',
    'sink.parallelism'='1'
 );

-- desc sqlserverjdbc维表-LRU、ALL、None、三种不同类型
INSERT 
INTO
    kafkaResultTable
    select
        st.id,
        mst.varchar_data as name,
        mst.int_data as age 
    from
        sourceTable st
    left join
        sqlserverSideTableOne for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;

INSERT 
INTO
    kafkaResultTableOne
    select
        st.id,
        mst.varchar_data as name,
        mst.int_data as age 
    from
        sourceTableOne st
    left join
        sqlserverSideTableTwo for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;

INSERT 
INTO
    kafkaResultTableTwo
    select
        st.id,
        mst.varchar_data as name,
        mst.int_data as age 
    from
        sourceTableTwo st
    left join
        sqlserverSideTableThree for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;


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
CREATE TABLE oracleSideTableOne(
    ID decimal(38,0) ,
    NAME varchar,
    ADDRESS varchar,
    SCHOOL varchar,
    MESSAGE varchar,
    START_TIME timestamp,
    END_TIME timestamp,
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
    'table-name'='ORACLE_FLINKX_CDC_TEST_ONE',
    'url'='jdbc:oracle:thin:@172.16.100.243:1521:orcl',
    'username'='shixiao'
 );
CREATE TABLE oracleSideTableTwo(
    ID decimal(38,0) ,
    NAME varchar,
    ADDRESS varchar,
    SCHOOL varchar,
    MESSAGE varchar,
    START_TIME timestamp,
    END_TIME timestamp,
    PRIMARY KEY(ID,NAME) NOT ENFORCED
 )WITH(
    'password' = '******',
    'lookup.error-limit'='100',
    'connector'='oracle-x',
    'lookup.cache-type'='None',
    'schema-name'='SHIXIAO',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='3',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='ORACLE_FLINKX_CDC_TEST_ONE',
    'url'='jdbc:oracle:thin:@172.16.100.243:1521:orcl',
    'username'='shixiao'
 );
CREATE TABLE oracleSideTableThree(
    ID decimal(38,0) ,
    NAME varchar,
    ADDRESS varchar,
    SCHOOL varchar,
    MESSAGE varchar,
    START_TIME timestamp,
    END_TIME timestamp,
    PRIMARY KEY(ID) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='oracle-x',
    'lookup.cache-type'='ALL',
    'schema-name'='SHIXIAO',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'table-name'='ORACLE_FLINKX_CDC_TEST_ONE',
    'lookup.cache-period'='60000',
    'url'='jdbc:oracle:thin:@172.16.100.243:1521:orcl',
    'username'='shixiao'
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

-- desc oracle维表-LRU、ALL、None、三种不同类型
INSERT 
INTO
    kafkaResultTable
    select
        st.id,
        mst.NAME as name,
        st.age 
    from
        sourceTable st
    left join
        oracleSideTableOne for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.ID;

INSERT 
INTO
    kafkaResultTableOne
    select
        st.id,
        mst.NAME as name,
        st.age 
    from
        sourceTableOne st
    left join
        oracleSideTableTwo for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.ID;

INSERT 
INTO
    kafkaResultTableTwo
    select
        st.id,
        mst.NAME as name,
        st.age 
    from
        sourceTableTwo st
    left join
        oracleSideTableThree for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.ID;


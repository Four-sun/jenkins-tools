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
CREATE TABLE inceptorSideTable(
    id int,
    name varchar(100) ,
    age varchar(100) ,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'security.kerberos.krb5.conf'='./krb5.conf',
    'password' = '******',
    'connector'='inceptor-x',
    'lookup.cache-type'='ALL',
    'lookup.parallelism'='1',
    'table-name'='stream_test_01',
    'security.kerberos.keytab'='./inceptor.keytab',
    'lookup.cache-period'='60000',
    'url'='jdbc:hive2://172.16.83.150:10000/tiezhu;principal=hive/tdh02@TDH',
    'username'='admin',
    'security.kerberos.principal'='hive/tdh02@TDH'
 );
CREATE TABLE kafkaResultTable(
    id int,
    name varchar,
    age varchar
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
-- desc Doris014jdbc维表
INSERT 
INTO
    kafkaResultTable
    select
        st.id as id,
        mst.name as name,
        mst.age as age 
    from
        sourceTable st
    left join
        inceptorSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;



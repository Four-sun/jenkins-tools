CREATE TABLE sourceTable(
    id int,
    name varchar,
    varchar_data varchar,
    tinyint_data tinyint,
    float_data float,
    double_data double,
    date_data date,
    time_data time,
    timestamp_data timestamp,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE solrResultTable(
    id int,
    name varchar,
    varchar_data varchar,
    tinyint_data tinyint,
    float_data float,
    double_data double,
    date_data date,
    time_data time,
    timestamp_data timestamp
 )WITH(
    'zk-chroot'='/solr',
    'connector'='solr-x',
    'sink.buffer-flush.interval'='1000',
    'sink.buffer-flush.max-rows'='100',
    'collection'='auto_test',
    'sink.parallelism'='1',
    'zk-hosts'='172.16.101.95:2181,172.16.100.32:2181,172.16.101.137:2181'
 );
CREATE TABLE kafkaResultOne(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'format'='json',
    'key.format'='json',
    'topic'='fanshu2',
    'sink.parallelism'='1',
    'key.fields'='id',
    'sink.partitioner'='com.dtstack.chunjun.connector.kafka.partitioner.CustomerFlinkPartition'
 );
-- desc FlinkSQL112_sourceKafka_sinkSolr
INSERT  
INTO
    solrResultTable
    SELECT
        st.id,
        st.name,
        st.varchar_data,
        st.tinyint_data,
        st.float_data,
        st.double_data,
        st.date_data,
        st.time_data,
        st.timestamp_data  
    FROM
        sourceTable st;

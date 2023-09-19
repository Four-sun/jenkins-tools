CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='2',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE solrResultTable(
    id int,
    name varchar,
    age int
 )WITH(
    'zk-chroot'='/solr',
    'connector'='solr-x',
    'sink.buffer-flush.interval'='1000',
    'sink.buffer-flush.max-rows'='100',
    'collection'='auto_test',
    'sink.parallelism'='2',
    'zk-hosts'='172.16.101.95:2181,172.16.100.32:2181,172.16.101.137:2181'
 );
-- desc FlinkSQL112_sourceKafka_sinkSolr
INSERT 
INTO
    solrResultTable
    SELECT
        st.id,
        st.name,
        st.age     
    FROM
        sourceTable st;

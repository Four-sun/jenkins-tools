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

CREATE TABLE hbaseResultTable(
    id int,
    cf ROW<id int,
    name varchar,
    age int>,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='hbase14-x',
    'zookeeper.quorum'='172.16.83.84:2181,172.16.83.101:2181,172.16.83.201:2181',
    'sink.buffer-flush.interval'='1000',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='test_source_table_amtgofzc',
    'sink.parallelism'='1'
 );
-- desc FlinkSQL112_sourceKafka_sinkHbase1
INSERT 
INTO
    hbaseResultTable
    SELECT
        st.id as rowkey,
        ROW(id,
        name,
        age) as cf     
    FROM
        sourceTable st;

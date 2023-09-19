CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
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
    'zookeeper.quorum'='172.16.85.218:2181,172.16.85.111:2181,172.16.85.210:2181',
    'sink.buffer-flush.interval'='1000',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='fanshu_test_3',
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

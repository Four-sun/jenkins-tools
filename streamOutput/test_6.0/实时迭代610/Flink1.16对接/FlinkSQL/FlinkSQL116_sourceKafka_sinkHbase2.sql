CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int,
    int_data int,
    varchar_data varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='csv',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE hbaseResultTable(
    id int,
    info ROW<int_data int,
    varchar_data varchar>,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='hbase2-x',
    'zookeeper.quorum'='172.16.101.95,172.16.100.32,172.16.101.137:2181',
    'sink.buffer-flush.interval'='1000',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='fanshu_test_1',
    'zookeeper.znode.parent'='/hbase',
    'sink.parallelism'='1'
 );
-- name FlinkSQL116_sourceKafka_sinkHbase2
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 12:41:19
-- desc 
INSERT 
INTO
    hbaseResultTable
    SELECT
        st.id as rowkey,
        ROW(int_data,
        varchar_data) as info     
    FROM
        sourceTable st;
